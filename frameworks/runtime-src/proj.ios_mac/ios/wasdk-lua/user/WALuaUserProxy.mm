//
//  WALuaUserProxy.m
//  CocosTestLua
//
//  Created by wuyx on 16/9/2.
//
//

#import "WALuaUserProxy.h"
#import "cocos2d.h"
#include "CCLuaEngine.h"
#include "CCLuaBridge.h"
#import "WALuaConstants.h"
#import "WALuaUtil.h"
#import "WALuaFuncIdManager.h"
#import "NSObject+BWJSONMatcher.h"

static WALuaUserProxy* testSingleton;

@interface WALuaUserProxy()
@property(nonatomic,strong)NSString* loginDelegateKey;
@property(nonatomic,strong)NSString* loginViewDelegateKey;
@property(nonatomic,strong)NSString* bindingDelegeteKey;
@property(nonatomic,strong)NSString* queryBoundAccountKey;
@property(nonatomic,strong)NSString* unBindAccountKey;
@property(nonatomic,strong)NSString* switchAccountKey;
@property(nonatomic,strong)NSString* createNewAccountKey;
@property(nonatomic,strong)NSString* openAccountManagerKey;
@property(nonatomic)int newAcctFuncId;
@property(nonatomic)int switchAcctFuncId;
@property(nonatomic)BOOL hadRegisterNoti;
@end
@implementation WALuaUserProxy

+(WALuaUserProxy*)sharedInstance{
    if (!testSingleton) {
        testSingleton = [[WALuaUserProxy alloc]init];
        testSingleton.loginDelegateKey = @"kLoginDelegate";
        testSingleton.loginViewDelegateKey = @"kLoginViewDelegateKey";
        testSingleton.bindingDelegeteKey = @"kBindingDelegeteKey";
        testSingleton.queryBoundAccountKey = @"kQueryBoundAccountKey";
        testSingleton.unBindAccountKey = @"kUnBindAccountKey";
        testSingleton.switchAccountKey = @"kSwitchAccountKey";
        testSingleton.createNewAccountKey = @"kCreateNewAccountKey";
        testSingleton.openAccountManagerKey = @"kOpenAccountManagerKey";
        testSingleton.hadRegisterNoti = NO;
    }
    return testSingleton;
}

+(void)login:(NSDictionary*)dict{
    
    NSString* platform = [dict objectForKey:WA_LUA_PARAM_PLATFORM];
    NSString* extInfo = [dict objectForKey:WA_LUA_PARAM_EXT_INFO];
    
    //保存回调函数
    NSNumber* succFuncId = [dict objectForKey:WA_LUA_FUNC_SUCCESS];
    NSNumber* failFuncId = [dict objectForKey:WA_LUA_FUNC_FAILURE];
    NSNumber* cancelFuncId = [dict objectForKey:WA_LUA_FUNC_CANCEL];
    [WALuaFuncIdManager addObjWithKey:[self sharedInstance].loginDelegateKey succFuncId:succFuncId failFuncId:failFuncId cancelFuncId:cancelFuncId];
    
    //调用登录方法
    [WAUserProxy loginWithPlatform:platform extInfo:extInfo delegate:[self sharedInstance]];
}

#pragma mark 实现协议 WALoginDelegate
-(void)loginDidCompleteWithResults:(WALoginResult*)result{
    if (![WALuaFuncIdManager getObjWithKey:[WALuaUserProxy sharedInstance].loginDelegateKey option:WALuaExecOptionSucc]) {
        WALog(@"(lua)没有传登录成功的回调函数")
    }
    
    [WALuaFuncIdManager execWithKey:[WALuaUserProxy sharedInstance].loginDelegateKey option:WALuaExecOptionSucc result:result];
}

-(void)loginDidFailWithError:(NSError*)error andResult:(WALoginResult*)result{
    if (![WALuaFuncIdManager getObjWithKey:[WALuaUserProxy sharedInstance].loginDelegateKey option:WALuaExecOptionFail]) {
        WALog(@"(lua)没有传登录失败的回调函数")
    }
    
    NSMutableDictionary* mDict = [NSMutableDictionary dictionary];
    if (result.platform) {
        [mDict setObject:result.platform forKey:WA_LUA_PARAM_PLATFORM];
    }
    NSDictionary* errDict = [WALuaUtil assembleInfoWithError:error];
    [mDict setObject:errDict forKey:WA_LUA_PARAM_ERROR];
    
    [mDict setObject:result forKey:WA_LUA_PARAM_RESULT];
    
    [WALuaFuncIdManager execWithKey:[WALuaUserProxy sharedInstance].loginDelegateKey option:WALuaExecOptionFail result:mDict];
}

-(void)loginDidCancel:(WALoginResult *)result{
    if (![WALuaFuncIdManager getObjWithKey:[WALuaUserProxy sharedInstance].loginDelegateKey option:WALuaExecOptionCancel]) {
        WALog(@"(lua)没有传登录取消的回调函数")
        return;
    }
    
    [WALuaFuncIdManager execWithKey:[WALuaUserProxy sharedInstance].loginDelegateKey option:WALuaExecOptionCancel result:result];
    
}


+(void)loginUI:(NSDictionary*)dict{
    NSNumber* cacheEnabled = [dict objectForKey:WA_LUA_PARAM_CACHE_ENABLED];;
    
    //保存回调函数
    NSNumber* succFuncId = [dict objectForKey:WA_LUA_FUNC_SUCCESS];
    NSNumber* failFuncId = [dict objectForKey:WA_LUA_FUNC_FAILURE];
    NSNumber* cancelFuncId = [dict objectForKey:WA_LUA_FUNC_CANCEL];
    [WALuaFuncIdManager addObjWithKey:[self sharedInstance].loginViewDelegateKey succFuncId:succFuncId failFuncId:failFuncId cancelFuncId:cancelFuncId];
    //调用登录界面
    [WAUserProxy login:[self sharedInstance] cacheEnabled:cacheEnabled.boolValue];
}


#pragma mark 实现协议WALoginViewDelegate
-(void)loginViewDidCompleteWithResult:(WALoginResult*)result{
    
    if (![WALuaFuncIdManager getObjWithKey:[WALuaUserProxy sharedInstance].loginViewDelegateKey option:WALuaExecOptionSucc]) {
        WALog(@"(lua)没有传登录成功的回调函数")
    }
    
    [WALuaFuncIdManager execWithKey:[WALuaUserProxy sharedInstance].loginViewDelegateKey option:WALuaExecOptionSucc result:result];
}

-(void)loginViewDidFailWithError:(NSError*)error andResult:(WALoginResult*)result{
    if (![WALuaFuncIdManager getObjWithKey:[WALuaUserProxy sharedInstance].loginViewDelegateKey option:WALuaExecOptionFail]) {
        WALog(@"(lua)没有传登录失败的回调函数")
    }
    
    NSMutableDictionary* mDict = [NSMutableDictionary dictionary];
    if (result.platform) {
        [mDict setObject:result.platform forKey:WA_LUA_PARAM_PLATFORM];
    }
    NSDictionary* errDict = [WALuaUtil assembleInfoWithError:error];
    [mDict setObject:errDict forKey:WA_LUA_PARAM_ERROR];
    [mDict setObject:result forKey:WA_LUA_PARAM_RESULT];
    
    [WALuaFuncIdManager execWithKey:[WALuaUserProxy sharedInstance].loginViewDelegateKey option:WALuaExecOptionFail result:mDict];
    
}

-(void)loginViewDidCancel:(WALoginResult*)result{
    if (![WALuaFuncIdManager getObjWithKey:[WALuaUserProxy sharedInstance].loginViewDelegateKey option:WALuaExecOptionCancel]) {
        WALog(@"(lua)没有传登录取消的回调函数")
        return;
    }
    
    [WALuaFuncIdManager execWithKey:[WALuaUserProxy sharedInstance].loginViewDelegateKey option:WALuaExecOptionCancel result:result];
}

#pragma mark 调用此方法隐藏登录界面
+(void)hide{
    [WAUserProxy hide];
}


#pragma mark 设置登录流程
+(void)setLoginFlowType:(NSDictionary*)dict{
    NSNumber* flowType = [dict objectForKey:WA_LUA_PARAM_FLOW_TYPE];
    if (flowType) {
        [WAUserProxy setLoginFlowType:flowType.intValue];
    }
    
}

+(int)getLoginFlowType{
    return [WAUserProxy getLoginFlowType];
}

#pragma mark 登出
+(void)logout{
    [WAUserProxy logout];
}

#pragma mark 绑定
+(void)bindingAccount:(NSDictionary*)dict{
    NSString* platform = [dict objectForKey:WA_LUA_PARAM_PLATFORM];
    NSString* extInfo = [dict objectForKey:WA_LUA_PARAM_EXT_INFO];
    //保存回调函数
    NSNumber* succFuncId = [dict objectForKey:WA_LUA_FUNC_SUCCESS];
    NSNumber* failFuncId = [dict objectForKey:WA_LUA_FUNC_FAILURE];
    NSNumber* cancelFuncId = [dict objectForKey:WA_LUA_FUNC_CANCEL];

    
    [WALuaFuncIdManager addObjWithKey:[self sharedInstance].bindingDelegeteKey succFuncId:succFuncId failFuncId:failFuncId cancelFuncId:cancelFuncId];

    //调用绑定方法
    [WAUserProxy bindingAccountWithPlatform:platform extInfo:extInfo delegate:[self sharedInstance]];
}
#pragma mark 实现协议 WAAccountBindingDelegate
-(void)bindingDidCompleteWithResult:(WABindingResult*)result{
    if (![WALuaFuncIdManager getObjWithKey:[WALuaUserProxy sharedInstance].bindingDelegeteKey option:WALuaExecOptionSucc]) {
        WALog(@"(lua)没有传绑定成功的回调函数")
    }
    
    [WALuaFuncIdManager execWithKey:[WALuaUserProxy sharedInstance].bindingDelegeteKey option:WALuaExecOptionSucc result:result];
}

-(void)bindingDidFailWithError:(NSError*)error andResult:(WABindingResult*)result{
    
    
    if (![WALuaFuncIdManager getObjWithKey:[WALuaUserProxy sharedInstance].bindingDelegeteKey option:WALuaExecOptionFail]) {
        WALog(@"(lua)没有传绑定失败的回调函数")
    }
    
    NSMutableDictionary* mDict = [NSMutableDictionary dictionary];
    if (result.platform) {
        [mDict setObject:result.platform forKey:WA_LUA_PARAM_PLATFORM];
    }
    NSDictionary* errDict = [WALuaUtil assembleInfoWithError:error];
    [mDict setObject:errDict forKey:WA_LUA_PARAM_ERROR];
    
    [mDict setObject:result forKey:WA_LUA_PARAM_RESULT];
    
    [WALuaFuncIdManager execWithKey:[WALuaUserProxy sharedInstance].bindingDelegeteKey option:WALuaExecOptionFail result:mDict];
}

-(void)bindingDidCancel:(WABindingResult*)result{
    if (![WALuaFuncIdManager getObjWithKey:[WALuaUserProxy sharedInstance].bindingDelegeteKey option:WALuaExecOptionCancel]) {
        WALog(@"(lua)没有传绑定取消的回调函数")
        return;
    }
    
    [WALuaFuncIdManager execWithKey:[WALuaUserProxy sharedInstance].bindingDelegeteKey option:WALuaExecOptionCancel result:result];
}

#pragma mark 查询绑定的第三方平台账户列表
+(void)queryBoundAccount:(NSDictionary*)dict{
    
    NSNumber* succFuncId = [dict objectForKey:WA_LUA_FUNC_SUCCESS];
    NSNumber* failFuncId = [dict objectForKey:WA_LUA_FUNC_FAILURE];
    
    
    [WALuaFuncIdManager addObjWithKey:[self sharedInstance].queryBoundAccountKey succFuncId:succFuncId failFuncId:failFuncId cancelFuncId:nil];
    
    
    [WAUserProxy queryBoundAccountWithCompleteBlock:^(NSError *error, NSArray<WAAccount *> *accounts) {
        if (error) {
            if (failFuncId) {
                
                NSMutableDictionary* mDict = [NSMutableDictionary dictionary];
                [mDict setObject:WA_LUA_PLATFORM_NONE forKey:WA_LUA_PARAM_PLATFORM];
                NSDictionary* errDict = [WALuaUtil assembleInfoWithError:error];
                [mDict setObject:errDict forKey:WA_LUA_PARAM_ERROR];
                
                [WALuaFuncIdManager execWithKey:[self sharedInstance].queryBoundAccountKey option:WALuaExecOptionFail result:mDict];
                
            }
            
        }else{
            if (succFuncId) {
                
                [WALuaFuncIdManager execWithKey:[self sharedInstance].queryBoundAccountKey option:WALuaExecOptionSucc result:accounts];
            }
        }
    }];
}

#pragma mark 解绑账号接口
+(void)unBindAccount:(NSDictionary*)dict{
    NSString* platform = [dict objectForKey:WA_LUA_PARAM_PLATFORM];
    NSString* platformUserId = [dict objectForKey:WA_LUA_PARAM_PUSER_ID];
    
    //保存回调函数
    NSNumber* succFuncId = [dict objectForKey:WA_LUA_FUNC_SUCCESS];
    NSNumber* failFuncId = [dict objectForKey:WA_LUA_FUNC_FAILURE];
    
    [WALuaFuncIdManager addObjWithKey:[self sharedInstance].unBindAccountKey succFuncId:succFuncId failFuncId:failFuncId cancelFuncId:nil];
    
    //调用解绑接口
    [WAUserProxy unBindAccountWithPlatform:platform platformUserId:platformUserId completeBlock:^(NSError *error) {
        if (error) {
            if (failFuncId) {
                
                
                NSMutableDictionary* mDict = [NSMutableDictionary dictionary];
                [mDict setObject:WA_PLATFORM_FACEBOOK forKey:WA_LUA_PARAM_PLATFORM];
                NSDictionary* errDict = [WALuaUtil assembleInfoWithError:error];
                [mDict setObject:errDict forKey:WA_LUA_PARAM_ERROR];
                [WALuaFuncIdManager execWithKey:[self sharedInstance].unBindAccountKey option:WALuaExecOptionFail result:mDict];
                
            }
        }else{
            if (succFuncId) {
                NSDictionary* account = @{WA_LUA_PARAM_PLATFORM:platform,WA_LUA_PARAM_PUSER_ID:platformUserId};
                [WALuaFuncIdManager execWithKey:[self sharedInstance].unBindAccountKey option:WALuaExecOptionSucc result:account];
                
            }
        }
        
    }];
}

#pragma mark 切换账号接口
+(void)switchAccount:(NSDictionary*)dict{
    NSString* platform = [dict objectForKey:WA_LUA_PARAM_PLATFORM];
    
    //保存回调函数
    NSNumber* succFuncId = [dict objectForKey:WA_LUA_FUNC_SUCCESS];
    NSNumber* failFuncId = [dict objectForKey:WA_LUA_FUNC_FAILURE];
    NSNumber* cancelFuncId = [dict objectForKey:WA_LUA_FUNC_CANCEL];
    
    [WALuaFuncIdManager addObjWithKey:[self sharedInstance].switchAccountKey succFuncId:succFuncId failFuncId:failFuncId cancelFuncId:cancelFuncId];

    //调用切换账号接口
    [WAUserProxy switchAccountWithPlatform:platform completeBlock:^(NSError *error, WALoginResult *loginResult) {
        
        if (error) {
            if (error.code == WACodeCancelled) {
                if (cancelFuncId) {
                    [WALuaFuncIdManager execWithKey:[self sharedInstance].switchAccountKey option:WALuaExecOptionCancel result:loginResult];
                }
            }else{
                if (failFuncId) {
                    
                    NSMutableDictionary* mDict = [NSMutableDictionary dictionary];
                    if (loginResult.platform) {
                        [mDict setObject:loginResult.platform forKey:WA_LUA_PARAM_PLATFORM];
                        [mDict setObject:loginResult forKey:WA_LUA_PARAM_RESULT];
                    }
                    NSDictionary* errDict = [WALuaUtil assembleInfoWithError:error];
                    [mDict setObject:errDict forKey:WA_LUA_PARAM_ERROR];
                    

                    [WALuaFuncIdManager execWithKey:[self sharedInstance].switchAccountKey option:WALuaExecOptionFail result:mDict];
                    
                }
            }
            
            
        }else{
            if (succFuncId) {
                [WALuaFuncIdManager execWithKey:[self sharedInstance].switchAccountKey option:WALuaExecOptionSucc result:loginResult];
            }
        }
    }];
}

#pragma mark 创建账号接口
+(void)createNewAccount:(NSDictionary*)dict{

    NSNumber* succFuncId = [dict objectForKey:WA_LUA_FUNC_SUCCESS];
    NSNumber* failFuncId = [dict objectForKey:WA_LUA_FUNC_FAILURE];
    
    [WALuaFuncIdManager addObjWithKey:[self sharedInstance].createNewAccountKey succFuncId:succFuncId failFuncId:failFuncId cancelFuncId:nil];
    
    //调用创建账号接口
    [WAUserProxy createNewAccountWithCompleteBlock:^(NSError *error, WALoginResult *result) {

        if (error) {
            if (failFuncId) {
                
                NSMutableDictionary* mDict = [NSMutableDictionary dictionary];
                if (result.platform) {
                    [mDict setObject:result.platform forKey:WA_LUA_PARAM_PLATFORM];
                    [mDict setObject:result forKey:WA_LUA_PARAM_RESULT];
                }
                NSDictionary* errDict = [WALuaUtil assembleInfoWithError:error];
                [mDict setObject:errDict forKey:WA_LUA_PARAM_ERROR];
                
                [WALuaFuncIdManager execWithKey:[self sharedInstance].createNewAccountKey option:WALuaExecOptionFail result:mDict];
                
            }
            
        }else{
            if (succFuncId) {
                [WALuaFuncIdManager execWithKey:[self sharedInstance].createNewAccountKey option:WALuaExecOptionSucc result:result];
            }
        }
    }];
}


#pragma mark 清除登录方式的缓存 清除缓存之后会再次弹出登录选择框
+(void)clearLoginCache{
    [WAUserProxy clearLoginCache];
}


-(void)bindDidSucceed:(NSNotification*)noti{
    
    if (noti.object) {
        WABindingResult* bResult = noti.object;
        
        NSDictionary* rDict = @{WA_LUA_PARAM_NOTI_TYPE:WA_LUA_VALUE_BIND_DID_SUCCEED,WA_LUA_PARAM_RESULT:bResult};
        [self assembleAcctManagerResult:rDict];
    }
}


-(void)bindDidFail:(NSNotification*)noti{
    if (noti.object) {
        WABindingResult* bResult = noti.object;
        NSDictionary* rDict = @{WA_LUA_PARAM_NOTI_TYPE:WA_LUA_VALUE_BIND_DID_FAIL,WA_LUA_PARAM_RESULT:bResult};
        [self assembleAcctManagerResult:rDict];
    }
}

-(void)unbindDidSucceed:(NSNotification*)noti{
    if (noti.object) {
        WAAccount* acct = noti.object;
        NSDictionary* rDict = @{WA_LUA_PARAM_NOTI_TYPE:WA_LUA_VALUE_UNBIND_DID_SUCCEED,WA_LUA_PARAM_RESULT:acct};
        [self assembleAcctManagerResult:rDict];
    }
}

-(void)unbindDidFail:(NSNotification*)noti{
    if (noti.object) {
        WAAccount* acct = noti.object;
        NSDictionary* rDict = @{WA_LUA_PARAM_NOTI_TYPE:WA_LUA_VALUE_UNBIND_DID_FAIL,WA_LUA_PARAM_RESULT:acct};
        [self assembleAcctManagerResult:rDict];
    }
}

-(void)assembleAcctManagerResult:(NSDictionary*)resultDict{
    [WALuaFuncIdManager execWithKey:self.openAccountManagerKey option:WALuaExecOptionCancel releaseOption:WALuaReleaseOptionNone result:resultDict];
}

#pragma mark 调用此方法打开账户管理界面
+(void)openAccountManager:(NSDictionary*)dict{

    if (![self sharedInstance].hadRegisterNoti) {
        [[NSNotificationCenter defaultCenter]addObserver:[self sharedInstance] selector:@selector(bindDidSucceed:) name:WABindDidSucceedNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:[self sharedInstance] selector:@selector(bindDidFail:) name:WABindDidFailNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:[self sharedInstance] selector:@selector(unbindDidSucceed:) name:WAUnbindDidSucceedNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:[self sharedInstance] selector:@selector(unbindDidFail:) name:WAUnbindDidFailNotification object:nil];
        [self sharedInstance].hadRegisterNoti = YES;
    }
    
    
    
    //保存回调函数
    NSNumber* newAcctFuncId = [dict objectForKey:WA_LUA_FUNC_NEW_ACCT];
    NSNumber* switchFuncId = [dict objectForKey:WA_LUA_FUNC_SWITCH_ACCT];
    NSNumber* acctManagerNoti = [dict objectForKey:WA_LUA_FUNC_ACCT_MANAGER_NOTI];
    
    
    [WALuaFuncIdManager addObjWithKey:[self sharedInstance].openAccountManagerKey succFuncId:newAcctFuncId failFuncId:switchFuncId cancelFuncId:acctManagerNoti];

    [WAUserProxy openAccountManager:[self sharedInstance]];
}

#pragma mark 实现协议WAAcctManagerDelegate
-(void)newAcctDidCompleteWithResult:(WALoginResult*)result{
    
    if (![WALuaFuncIdManager getObjWithKey:[WALuaUserProxy sharedInstance].openAccountManagerKey option:WALuaExecOptionSucc]) {
        WALog(@"(lua)没有传新建账号的回调函数")
    }
    
    [WALuaFuncIdManager execWithKey:[WALuaUserProxy sharedInstance].openAccountManagerKey option:WALuaExecOptionSucc result:result];
}

-(void)switchAcctDidCompleteWithResult:(WALoginResult*)result{
    
    if (![WALuaFuncIdManager getObjWithKey:[WALuaUserProxy sharedInstance].openAccountManagerKey option:WALuaExecOptionFail]) {
        WALog(@"(lua)没有传切换账号的回调函数")
    }
    
    [WALuaFuncIdManager execWithKey:[WALuaUserProxy sharedInstance].openAccountManagerKey option:WALuaExecOptionFail result:result];
}

#pragma mark 获取账户信息
+(NSString*)getAccountInfo:(NSDictionary*)dict{
    NSString* platform = [dict objectForKey:WA_LUA_PARAM_PLATFORM];
    WAAppUser* appUser = [WAUserProxy getAccountInfoWithPlatform:platform];
    NSString* userJson = [appUser toJSONString];
    return userJson;
}

+(NSString*)getCurrentLoginResult{
    WALoginResult* curLoginResult = [WAUserProxy getCurrentLoginResult];
    
    if (!curLoginResult) {
        return nil;
    }
    
    NSString* loginJson = [curLoginResult toJSONString];
    
    return loginJson;
    
}

@end
