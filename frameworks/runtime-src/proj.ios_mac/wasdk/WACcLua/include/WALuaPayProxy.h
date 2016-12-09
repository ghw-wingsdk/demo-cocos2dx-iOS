//
//  WALuaPayProxy.h
//  WACocos2dxLua
//
//  Created by wuyx on 16/9/8.
//
//

#import <Foundation/Foundation.h>
#import <WASdkIntf/WASdkIntf.h>
@interface WALuaPayProxy : NSObject<WAInventoryDelegate,WAPaymentDelegate>
+(void)init4Iap;
+(void)queryInventory:(NSDictionary*)dict;
+(void)payUI:(NSDictionary*)dict;
+(BOOL)isPayServiceAvailable:(NSDictionary*)dict;
@end
