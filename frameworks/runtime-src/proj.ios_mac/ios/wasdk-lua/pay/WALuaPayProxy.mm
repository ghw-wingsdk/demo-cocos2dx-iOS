//
//  WALuaPayProxy.m
//  WACocos2dxLua
//
//  Created by wuyx on 16/9/8.
//
//

#import "WALuaPayProxy.h"
#import "WALuaConstants.h"
#import "WALuaFuncIdManager.h"
#import "cocos2d.h"
#include "CCLuaEngine.h"
#include "CCLuaBridge.h"
#import "WALuaUtil.h"
static WALuaPayProxy* waluaPaySingleton;
@interface WALuaPayProxy()
@property(nonatomic,strong)NSString* queryInventoryWithDelegate;
@property(nonatomic,strong)NSString* payWithProductIdKey;
@end

@implementation WALuaPayProxy

+(WALuaPayProxy*)sharedInstance{
    if (!waluaPaySingleton) {
        waluaPaySingleton = [[WALuaPayProxy alloc]init];
        waluaPaySingleton.queryInventoryWithDelegate = @"kQueryInventoryWithDelegate";
        waluaPaySingleton.payWithProductIdKey = @"kPayWithProductId";
    }
    return waluaPaySingleton;
}

+(void)init4Iap{
    [WAPayProxy init4Iap];
}

+(void)queryInventory:(NSDictionary *)dict{
    //保存回调函数
    NSNumber* succFuncId = [dict objectForKey:WA_LUA_FUNC_SUCCESS];
    NSNumber* failFuncId = [dict objectForKey:WA_LUA_FUNC_FAILURE];
    [WALuaFuncIdManager addObjWithKey:[self sharedInstance].queryInventoryWithDelegate succFuncId:succFuncId failFuncId:failFuncId cancelFuncId:nil];
    [WAPayProxy queryInventoryWithDelegate:[self sharedInstance]];
}

#pragma mark 实现协议 WAInventoryDelegate
-(void)queryInventoryDidCompleteWithResult:(NSArray<WAIapProduct *>*)Inventory{
    [WALuaFuncIdManager execWithKey:[WALuaPayProxy sharedInstance].queryInventoryWithDelegate option:WALuaExecOptionSucc result:Inventory];
}

-(void)queryInventoryDidFailWithError:(NSError*)error{
    NSMutableDictionary* mDict = [NSMutableDictionary dictionary];
    [mDict setObject:WA_PLATFORM_APPLE forKey:WA_LUA_PARAM_PLATFORM];
    NSDictionary* errDict = [WALuaUtil assembleInfoWithError:error];
    [mDict setObject:errDict forKey:WA_LUA_PARAM_ERROR];
    [WALuaFuncIdManager execWithKey:[WALuaPayProxy sharedInstance].queryInventoryWithDelegate option:WALuaExecOptionFail result:mDict];
}


+(void)payUI:(NSDictionary*)dict{
    NSString* productId = [dict objectForKey:WA_LUA_PARAM_PRODUCT_ID];
    NSString* extInfo = [dict objectForKey:WA_LUA_PARAM_EXT_INFO];
    NSNumber* succFuncId = [dict objectForKey:WA_LUA_FUNC_SUCCESS];
    NSNumber* failFuncId = [dict objectForKey:WA_LUA_FUNC_FAILURE];
    [WALuaFuncIdManager addObjWithKey:[self sharedInstance].payWithProductIdKey succFuncId:succFuncId failFuncId:failFuncId cancelFuncId:nil];
    [WAPayProxy payWithProductId:productId extInfo:extInfo delegate:[self sharedInstance]];
}

#pragma mark 实现协议 WAPaymentDelegate
-(void)paymentDidCompleteWithResult:(WAIapResult*)iapResult andPlatform:(NSString*)platform{
    NSDictionary* result = @{WA_LUA_PARAM_RESULT:iapResult , WA_LUA_PARAM_PLATFORM:platform};
    [WALuaFuncIdManager execWithKey:[WALuaPayProxy sharedInstance].payWithProductIdKey option:WALuaExecOptionSucc result:result];
}

-(void)paymentDidFailWithError:(NSError*)error andPlatform:(NSString*)platform{
    NSDictionary* errDict = [WALuaUtil assembleInfoWithError:error];
    NSDictionary* result = @{WA_LUA_PARAM_ERROR:errDict , WA_LUA_PARAM_PLATFORM:platform};
    [WALuaFuncIdManager execWithKey:[WALuaPayProxy sharedInstance].payWithProductIdKey option:WALuaExecOptionSucc result:result];
}

+(BOOL)isPayServiceAvailable:(NSDictionary*)dict{
    NSString* platform = [dict objectForKey:WA_LUA_PARAM_PLATFORM];
    return [WAPayProxy isPayServiceAvailableWithPlatform:platform];
}




@end
