//
//  WALuaTrackProxy.h
//  WACocos2dxLua
//
//  Created by wuyx on 16/9/8.
//
//

#import <Foundation/Foundation.h>
#import <WASdkIntf/WASdkIntf.h>
@interface WALuaTrackProxy : NSObject

+(void)trackEvent:(NSDictionary*)dict;
+(void)trackEventExt:(NSDictionary*)dict;
+(void)autoTriggerAfterPayment:(NSDictionary*)dict;
@end
