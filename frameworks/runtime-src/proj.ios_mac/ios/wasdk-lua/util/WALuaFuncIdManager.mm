//
//  WALuaFuncIdManager.m
//  WACocos2dxLua
//
//  Created by wuyx on 16/9/9.
//
//

#import "WALuaFuncIdManager.h"
#import "cocos2d.h"
#include "CCLuaEngine.h"
#include "CCLuaBridge.h"
#import "NSObject+BWJSONMatcher.h"
#import "WALuaConstants.h"

static WALuaFuncIdManager* waLuaFuncIdManagerSingleton = nil;
@interface WALuaFuncIdManager()
@property(nonatomic,strong)NSMutableDictionary* repertory;
@end
@implementation WALuaFuncIdManager
+(WALuaFuncIdManager*)sharedInstance{
    if (!waLuaFuncIdManagerSingleton) {
        waLuaFuncIdManagerSingleton = [[WALuaFuncIdManager alloc]init];
        waLuaFuncIdManagerSingleton.repertory = [NSMutableDictionary dictionary];
    }
    return waLuaFuncIdManagerSingleton;
}

+(void)addObjWithKey:(NSString*)aKey succFuncId:(NSNumber*)succFuncId failFuncId:(NSNumber*)failFuncId cancelFuncId:(NSNumber*)cancelFuncId{
    [[WALuaFuncIdManager sharedInstance] addObjWithKey:aKey succFuncId:succFuncId failFuncId:failFuncId cancelFuncId:cancelFuncId];
}
+(void)execWithKey:(NSString*)key option:(WALuaExecOption)option result:(NSObject*)result{
    [[WALuaFuncIdManager sharedInstance] execWithKey:key option:option result:result];
}

+(void)execWithKey:(NSString*)key option:(WALuaExecOption)option releaseOption:(WALuaReleaseOption)releaseOption result:(NSObject*)result{
    [[WALuaFuncIdManager sharedInstance] execWithKey:key option:option releaseOption:releaseOption result:result];
}

+(NSNumber*)getObjWithKey:(NSString*)key option:(WALuaExecOption)option{
    NSDictionary* funcDict = [[WALuaFuncIdManager sharedInstance] getObjWithKey:key];
    if (option == WALuaExecOptionSucc) {
        return [funcDict objectForKey:WA_LUA_FUNC_SUCCESS];
    }else if (option == WALuaExecOptionFail) {
        return [funcDict objectForKey:WA_LUA_FUNC_FAILURE];
    }else if (option == WALuaExecOptionCancel) {
        return [funcDict objectForKey:WA_LUA_FUNC_CANCEL];
    }
    
    return nil;
}

-(void)addObjWithKey:(NSString*)aKey succFuncId:(NSNumber*)succFuncId failFuncId:(NSNumber*)failFuncId cancelFuncId:(NSNumber*)cancelFuncId{
    __block BOOL isExist = NO;
    
    if (!_repertory) {
        _repertory = [NSMutableDictionary dictionary];
    }
    
    [_repertory enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([aKey isEqualToString:key]) {
            isExist = YES;
            *stop = YES;
        }
    }];
    
    NSMutableDictionary* funcDict = [NSMutableDictionary dictionary];
    if (succFuncId) {
        [funcDict setObject:succFuncId forKey:WA_LUA_FUNC_SUCCESS];
    }
    if (failFuncId) {
        [funcDict setObject:failFuncId forKey:WA_LUA_FUNC_FAILURE];
    }
    if (cancelFuncId) {
        [funcDict setObject:cancelFuncId forKey:WA_LUA_FUNC_CANCEL];
    }
    
    
    if (isExist) {
        NSMutableArray* arr = [_repertory objectForKey:aKey];
        [arr addObject:funcDict];
    }else{
        NSMutableArray* arr = [NSMutableArray array];
        [arr addObject:funcDict];
        [_repertory setObject:arr forKey:aKey];
    }
}

-(NSDictionary*)getObjWithKey:(NSString*)key{
    NSMutableArray* arr = [_repertory objectForKey:key];
    NSDictionary* dict = [arr firstObject];
    return dict;
}

-(void)deleteObjWithKey:(NSString*)key{
    NSMutableArray* arr = [_repertory objectForKey:key];
    if (arr.count) {
        [arr removeObjectAtIndex:0];
    }
    
}

-(void)deleteObjWithKey:(NSString*)key option:(WALuaExecOption)option{
    NSMutableArray* arr = [_repertory objectForKey:key];
    NSString* funcKey = @"";
    if (option == WALuaExecOptionSucc) {
        funcKey = WA_LUA_FUNC_SUCCESS;
    }else if(option == WALuaExecOptionFail){
        funcKey = WA_LUA_FUNC_FAILURE;
    }else if(option == WALuaExecOptionCancel){
        funcKey = WA_LUA_FUNC_CANCEL;
    }
    
    if (arr.count) {
        NSMutableDictionary* funcDict = [arr firstObject];
        [funcDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if ([key isEqualToString:funcKey]) {
                [funcDict removeObjectForKey:key];
                *stop = YES;
            }
        }];
    }
    
}

-(void)execWithKey:(NSString*)key option:(WALuaExecOption)option releaseOption:(WALuaReleaseOption)releaseOption result:(NSObject*)result{
    NSString* resultJson = [result toJSONString];
    
    NSNumber* funcId;
    NSDictionary* funcDict = [self getObjWithKey:key];
    
    NSNumber* succId = [funcDict objectForKey:WA_LUA_FUNC_SUCCESS];
    
    NSNumber* failId = [funcDict objectForKey:WA_LUA_FUNC_FAILURE];
    
    NSNumber* cancelId = [funcDict objectForKey:WA_LUA_FUNC_CANCEL];
    
    if (option == WALuaExecOptionSucc) {
        funcId = succId;
    }else if (option == WALuaExecOptionFail) {
        funcId = failId;
    }else if (option == WALuaExecOptionCancel) {
        funcId = cancelId;
    }else{
        funcId = succId;
    }
    
    if (funcId) {
        cocos2d::LuaBridge::pushLuaFunctionById(funcId.intValue);
        cocos2d::LuaBridge::getStack()->pushString([resultJson UTF8String]);
        cocos2d::LuaBridge::getStack()->executeFunction(1);
    }
    
    if (releaseOption == WALuaReleaseOptionAll) {
        if (succId) {
            cocos2d::LuaBridge::releaseLuaFunctionById(succId.intValue);
        }
        
        if (failId) {
            cocos2d::LuaBridge::releaseLuaFunctionById(failId.intValue);
        }
        
        if (cancelId) {
            cocos2d::LuaBridge::releaseLuaFunctionById(cancelId.intValue);
        }
        
        [self deleteObjWithKey:key];
        
    }else if(releaseOption == WALuaReleaseOptionSingle){
        if (funcId) {
            cocos2d::LuaBridge::releaseLuaFunctionById(funcId.intValue);
        }
        
        [self deleteObjWithKey:key option:option];
    }else{
        //不做释放
    }
    
}

-(void)execWithKey:(NSString*)key option:(WALuaExecOption)option result:(NSObject*)result{
    [self execWithKey:key option:option releaseOption:WALuaReleaseOptionAll result:result];
}
@end
