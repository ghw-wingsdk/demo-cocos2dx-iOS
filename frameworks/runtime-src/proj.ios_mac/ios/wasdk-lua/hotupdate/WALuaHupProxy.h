//
//  WALuaHupProxy.h
//  WACocos2dxLua
//
//  Created by wuyx on 16/9/20.
//
//

#import <Foundation/Foundation.h>
#import <WASdkIntf/WASdkIntf.h>
@interface WALuaHupProxy : NSObject
/*!
 @abstract 检查更新
 @param handler 回调
 */
+(void)checkUpdate:(NSDictionary*)dict;
/*!
 @abstract 开始更新
 @param handler 回调
 */
+(void)startUpdate:(NSDictionary*)dict;
/*!
 @abstract 获取更新包信息
 @return WAUpdateInfo 更新包信息
 */
+(WAUpdateInfo*)getPatchInfo;
@end
