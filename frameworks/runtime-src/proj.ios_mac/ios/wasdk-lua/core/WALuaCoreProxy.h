//
//  WALuaCoreProxy.h
//  WACocos2dxLua
//
//  Created by wuyx on 16/9/8.
//
//

#import <Foundation/Foundation.h>
#import <WASdkIntf/WASdkIntf.h>
@interface WALuaCoreProxy : NSObject
/*!
 @abstract 初始化
 */
+(void)init;
/*!
 @abstract 开启数据收集
 */
+(void)initAppEventTracker;
/*!
 @abstract 是否调试模式
 */
+(NSNumber*)isDebugMode;
/*!
 @abstract 设置调试模式
 */
+(void)setDebugMode:(NSDictionary*)dict;
/*!
 @abstract 获取userId
 */
+(NSString*)getUserId;
/*!
 @abstract 设置serverId
 @param serverId
 */
+(void)setServerId:(NSDictionary*)dict;
/*!
 @abstract 获取serverId
 */

+(NSString*)getServerId;
/*!
 @abstract 设置level
 @param level
 */
+(void)setLevel:(NSDictionary*)dict;
/*!
 @abstract 获取level
 */
+(NSNumber*)getLevel;
/*!
 @abstract 设置gameUserId
 @param gameUserId
 */
+(void)setGameUserId:(NSDictionary*)dict;
/*!
 @abstract 获取gameUserId
 */
+(NSString*)getGameUserId;
@end
