//
//  WALuaHupProxy.m
//  WACocos2dxLua
//
//  Created by wuyx on 16/9/20.
//
//

#import "WALuaHupProxy.h"
#import "WALuaConstants.h"
#import "WALuaUtil.h"
#import "WALuaFuncIdManager.h"
#import <NSObject+BWJSONMatcher.h>
@implementation WALuaHupProxy

/*!
 @abstract 检查更新
 @param handler 回调
 */
+(void)checkUpdate:(NSDictionary*)dict{
    
    static NSString* waCheckUpdateKey = @"kWaCheckUpdate";
    
    NSNumber* succFuncId = [dict objectForKey:WA_LUA_FUNC_SUCCESS];
    NSNumber* failFuncId = [dict objectForKey:WA_LUA_FUNC_FAILURE];
    
    [WALuaFuncIdManager addObjWithKey:waCheckUpdateKey succFuncId:succFuncId failFuncId:failFuncId cancelFuncId:nil];
    
    [WAHupProxy checkUpdate:^(NSError *error, WAUpdateInfo *updateInfo) {
        if (error) {
            if (failFuncId) {
                WALog(@"checkUpdate没有传失败回调函数")
            }
            NSDictionary* errDict = [WALuaUtil assembleInfoWithError:error];
            
            [WALuaFuncIdManager execWithKey:waCheckUpdateKey option:WALuaExecOptionFail result:errDict];
            
        }else{
            if (succFuncId) {
                WALog(@"checkUpdate没有传成功回调函数")
            }
            
            [WALuaFuncIdManager execWithKey:waCheckUpdateKey option:WALuaExecOptionSucc result:updateInfo];
        }
    }];
    
}
/*!
 @abstract 开始更新
 @param handler 回调
 */
+(void)startUpdate:(NSDictionary*)dict{
    static NSString* waStartUpdateKey = @"kWaStartUpdateKey";
    
    NSNumber* succFuncId = [dict objectForKey:WA_LUA_FUNC_SUCCESS];
    NSNumber* failFuncId = [dict objectForKey:WA_LUA_FUNC_FAILURE];
    
//    @property(nonatomic)int code;
//    @property(nonatomic,copy)NSString* msg;
//    @property(nonatomic)Boolean upgrated;
//    @property(nonatomic)int patchId;
//    @property(nonatomic)int patchVersion;
//    @property(nonatomic,copy)NSString* patchEncrypt;
//    @property(nonatomic,copy)NSString* moduleId;
//    @property(nonatomic)Boolean isMandatory;
//    @property(nonatomic,strong)NSString* downloadUrl;
//    @property(nonatomic,copy)NSString* osign;
    
    NSNumber* code = [dict objectForKey:WA_LUA_PARAM_CODE];
    NSString* msg = [dict objectForKey:WA_LUA_PARAM_MSG];
    NSNumber* upgrated = [dict objectForKey:WA_LUA_PARAM_UPGRATED];
    NSNumber* patchId = [dict objectForKey:WA_LUA_PARAM_PATCH_ID];
    NSNumber* patchVersion = [dict objectForKey:WA_LUA_PARAM_PATCH_VERSION];
    NSString* patchEncrypt = [dict objectForKey:WA_LUA_PARAM_PATCH_ENCRYPT];
    NSString* moduleId = [dict objectForKey:WA_LUA_PARAM_MODULE_ID];
    NSNumber* isMandatory = [dict objectForKey:WA_LUA_PARAM_IS_MANDATORY];
    NSString* downloadUrl = [dict objectForKey:WA_LUA_PARAM_DOWNLOAD_URL];
    NSString* osign = [dict objectForKey:WA_LUA_PARAM_OSIGN];
    
    WAUpdateInfo* updateInfo = [[WAUpdateInfo alloc]init];
    updateInfo.code = code.intValue;
    updateInfo.msg = msg;
    updateInfo.upgrated = upgrated.boolValue;
    updateInfo.patchId = patchId.intValue;
    updateInfo.patchVersion = patchVersion.intValue;
    updateInfo.patchEncrypt = patchEncrypt;
    updateInfo.moduleId = moduleId;
    updateInfo.isMandatory = isMandatory.boolValue;
    updateInfo.downloadUrl = downloadUrl;
    updateInfo.osign = osign;
    
    [WALuaFuncIdManager addObjWithKey:waStartUpdateKey succFuncId:succFuncId failFuncId:failFuncId cancelFuncId:nil];
    
    [WAHupProxy startUpdate:updateInfo handler:^(NSError *error) {
        if (error) {
            if (failFuncId) {
                WALog(@"startUpdate没有传失败回调函数")
            }
            NSDictionary* errDict = [WALuaUtil assembleInfoWithError:error];
            
            [WALuaFuncIdManager execWithKey:waStartUpdateKey option:WALuaExecOptionFail result:errDict];
            
        }else{
            if (succFuncId) {
                WALog(@"startUpdate没有传成功回调函数")
            }
            
            [WALuaFuncIdManager execWithKey:waStartUpdateKey option:WALuaExecOptionSucc result:updateInfo];
        }
    }];
    
}
/*!
 @abstract 获取更新包信息
 @return WAUpdateInfo 更新包信息
 */
+(NSString*)getPatchInfo{
    WAUpdateInfo* hotUpdate = [WAHupProxy getPatchInfo];
    if (hotUpdate) {
        return hotUpdate.toJSONString;
    }
    return nil;
}

@end
