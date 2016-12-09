//
//  WALuaUserProxy.h
//  CocosTestLua
//
//  Created by wuyx on 16/9/2.
//
//

#import <Foundation/Foundation.h>
#import <WASdkIntf/WASdkIntf.h>
@interface WALuaUserProxy : NSObject<WALoginDelegate,WAAccountBindingDelegate,WALoginViewDelegate,WAAcctManagerDelegate>
+(void)login:(NSDictionary*)dict;
+(void)loginUI:(NSDictionary*)dict;
+(void)hide;
+(void)setLoginFlowType:(NSDictionary*)dict;
+(int)getLoginFlowType;
+(void)logout;
+(void)bindingAccount:(NSDictionary*)dict;
+(void)queryBoundAccount:(NSDictionary*)dict;
+(void)unBindAccount:(NSDictionary*)dict;
+(void)switchAccount:(NSDictionary*)dict;
+(void)createNewAccount:(NSDictionary*)dict;
+(void)clearLoginCache;
+(NSString*)getAccountInfo:(NSDictionary*)dict;
+(NSString*)getCurrentLoginResult;
@end
