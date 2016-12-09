//
//  WALuaSocialProxy.h
//  WACocos2dxLua
//
//  Created by wuyx on 16/9/19.
//
//

#import <Foundation/Foundation.h>
#import <WASdkIntf/WASdkIntf.h>
#import <AssetsLibrary/AssetsLibrary.h>
@interface WALuaSocialProxy : NSObject<WASharingDelegate,WAAppInviteDialogDelegate,WAGameRequestDialogDelegate>
/*!
 #分享调用方法
 */
/*!
 @abstract 分享调用方法
 @param platform 平台
 @param shareContent 分享内容
 @param delegate 委托
 */
+(void)share:(NSDictionary*)dict;
/*!
 @abstract 应用邀请调用方法
 @param content 内容
 @param delegate 委托
 */
+(void)appInvite:(NSDictionary*)dict;
/*!
 @abstract Game Service - 获取可邀请好友列表
 @param duration 邀请有效时段,既是邀请好友成功之后,该好友在有效时段之内,不会再出现在可邀请好友列表之中.单位为分钟,不设置默认为0.
 @param platform 平台
 @param block 回调
 */
+(void)queryInvitableFriends:(NSDictionary*)dict;
/*!
 @abstract Game Service - 向好友发送邀请
 @param content 内容
 @param delegate 委托
 */
+(void)gameInviteWithDict:(NSDictionary*)dict;
/*!
 @abstract Game Service - 查询赠送/索要礼物的好友列表
 @param platform 平台
 @param block 回调
 */
+(void)queryFriends:(NSDictionary*)dict;
/*!
 @abstract 获取当前App所属的group
 @param platform 平台
 @param block 回调
 */
+(void)getCurrentAppLinkedGroup:(NSDictionary*)dict;
/*!
 @abstract 获取当前user所属的group
 @param platform 平台
 @param block 回调
 */
+(void)getCurrentUserGroup:(NSDictionary*)dict;

/*!
 @abstract 根据groupId查询对应的group
 @param platform 平台
 @param groupIds groupId数组
 @param block 回调
 */
+(void)getGroup:(NSDictionary*)dict;

/*!
 @abstract 返回当前应用推荐的所有group
 @param platform 平台
 @param extInfo 扩展字段
 @param block 回调
 */
+(void)getGroups:(NSDictionary*)dict;

/*!
 @abstract 加入group
 @param platform 平台
 @param groupId group标识
 @param extInfo 扩展信息
 @param block 回调
 */
+(void)joinGroup:(NSDictionary*)dict;

/*!
 @abstract 打开group
 @param platform 平台
 @param groupUri
 @param extInfo 扩展信息
 @param block 回调
 */
+(void)openGroupPage:(NSDictionary*)dict;

/*!
 @abstract Game Service - 查询礼物列表
 @param objectType 内容
 @param block 回调
 */
+(void)queryFBGraphObjects:(NSDictionary*)dict;
/*!
 @abstract Game Service - 赠送礼物
 @param content 内容
 @param delegate 委托
 */
+(void)fbSendGift:(NSDictionary*)dict;

/*!
 @abstract Game Service - 索要礼物
 @param content 内容
 @param delegate 委托
 */
+(void)fbAskForGift:(NSDictionary*)dict;
/*!
 @abstract Game Service - 查看收到的礼物
 @param block 回调
 */
+(void)fbQueryReceivedGifts:(NSDictionary*)dict;
/*!
 @abstract Game Service - 查看好友向自己索要礼物请求
 @param block 回调
 */
+(void)fbQueryAskForGiftRequests:(NSDictionary*)dict;
/*!
 @abstract Game Service - 删除请求
 @param block 回调
 */
+(void)fbDeleteRequest:(NSDictionary*)dict;


/*!
 @abstract 此方法用来取代gameInviteWithPlatform,fbSendGiftWithContent,fbAskForGiftWithContent
 @param platform 平台
 @param requestType 请求类型
 @param title 标题
 @param message 信息
 @param objectId
 @param receiptIds 接受者id
 @param delegate 委托
 */
+(void)sendRequest:(NSDictionary*)dict;

/*!
 @abstract 下面的三个方法是关于奖励机制的,邀请奖励,自定义奖励事件
 @discussion 此方法用来提交Facebook邀请信息
 @param platform 平台
 @param result 这是发完邀请请求成功在WAGameRequestDialogDelegate的方法:[- (void)gameRequestDialog:(WAGameRequestDialog *)gameRequestDialog platform:(NSString *const)platform didCompleteWithResults:(NSDictionary *)results]的results
 @param handler 回调block 当code为200时成功
 */
+(void)createInviteRecord:(NSDictionary*)dict;
/*!
 @discussion 触发Facebook被邀请人安装应用事件接口。在玩家登录facebook或者用facebook账号绑定的时候可以触发安装事件
 @param platform 平台
 @param tokenString facebook accesstoken
 @param handler 回调block 当code为200时成功
 */
+(void)inviteInstallReward:(NSDictionary*)dict;
/*!
 @discussion 发送Facebook邀请奖励事件统计接口
 @param platform 平台
 @param eventName 奖励事件名称
 @param handler 回调block 当code为200时成功
 */
+(void)inviteEventReward:(NSDictionary*)dict;
@end
