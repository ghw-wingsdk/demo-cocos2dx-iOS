//
//  WALuaSocialProxy.m
//  WACocos2dxLua
//
//  Created by wuyx on 16/9/19.
//
//

#import "WALuaSocialProxy.h"
#import "WALuaConstants.h"
#import "WALuaFuncIdManager.h"
#import "WALuaUtil.h"
#import "NSObject+BWJSONMatcher.h"

static WALuaSocialProxy* waLuaSocialSingleton;

typedef enum WALuaGameRequestOption{
    WALuaGameRequestOptionInvite = 1,
    WALuaGameRequestOptionSend,
    WALuaGameRequestOptionAsk,
    WALuaGameRequestOptionAll
}WALuaGameRequestOption;

@interface WALuaSocialProxy()
@property(nonatomic)WALuaGameRequestOption gameRequestOption;
@property(nonatomic,strong)NSString* shareWithPlatformKey;
@property(nonatomic,strong)NSString* appInviteWithPlatformKey;
@property(nonatomic,strong)NSString* queryInvitableFriendsWithDurationKey;
@property(nonatomic,strong)NSString* gameInviteWithPlatformKey;
@property(nonatomic,strong)NSString* queryFriendsWithPlatformKey;
@property(nonatomic,strong)NSString* getGroupByGidKey;
@property(nonatomic,strong)NSString* getCurrentAppLinkedGroupWithPlatfromKey;
@property(nonatomic,strong)NSString* getCurrentUserGroupWithPlatfromKey;
@property(nonatomic,strong)NSString* getGroupWithPlatformKey;
@property(nonatomic,strong)NSString* getGroupsWithPlatformKey_;
@property(nonatomic,strong)NSString* joinGroupWithPlatformKey;
@property(nonatomic,strong)NSString* queryFBGraphObjectsWithObjectTypeKey;
@property(nonatomic,strong)NSString* fbSendGiftWithContentKey;
@property(nonatomic,strong)NSString* fbAskForGiftWithContentKey;
@property(nonatomic,strong)NSString* sendRequestWithPlatformKey;
@property(nonatomic,strong)NSString* fbQueryReceivedGiftsWithCompleteBlockKey;
@property(nonatomic,strong)NSString* fbQueryAskForGiftRequestsWithCompleteBlockKey;
@property(nonatomic,strong)NSString* fbDeleteRequestWithRequestIdKey;
@property(nonatomic,strong)NSString* createInviteInfoWithPlatformKey;
@property(nonatomic,strong)NSString* inviteInstallRewardPlatformKey;
@property(nonatomic,strong)NSString* inviteEventRewardWithPlatformKey;

@property(nonatomic,strong)NSMutableArray* mPhotoArrAfter;
@property(nonatomic,strong)NSMutableArray* mPhotoArrBefore;
@end

@implementation WALuaSocialProxy

+(WALuaSocialProxy*)sharedInstance{
    if (!waLuaSocialSingleton) {
        waLuaSocialSingleton = [[WALuaSocialProxy alloc]init];
        waLuaSocialSingleton.shareWithPlatformKey = @"kShareWithPlatform";
        waLuaSocialSingleton.appInviteWithPlatformKey = @"kAppInviteWithPlatform";
        waLuaSocialSingleton.queryInvitableFriendsWithDurationKey = @"kQueryInvitableFriendsWithDuration";
        waLuaSocialSingleton.gameInviteWithPlatformKey = @"kGameInviteWithPlatformKey";
        waLuaSocialSingleton.queryFriendsWithPlatformKey = @"kQueryFriendsWithPlatform";
        waLuaSocialSingleton.getGroupByGidKey = @"kGetGroupByGidKey";
        waLuaSocialSingleton.getCurrentAppLinkedGroupWithPlatfromKey = @"kGetCurrentAppLinkedGroupWithPlatfrom";
        waLuaSocialSingleton.getCurrentUserGroupWithPlatfromKey = @"kGetCurrentUserGroupWithPlatfrom";
        waLuaSocialSingleton.getGroupWithPlatformKey = @"kGetGroupWithPlatform";
        waLuaSocialSingleton.getGroupsWithPlatformKey_ = @"kgetGroupsWithPlatform_";
        waLuaSocialSingleton.joinGroupWithPlatformKey = @"kJoinGroupWithPlatform";
        waLuaSocialSingleton.queryFBGraphObjectsWithObjectTypeKey = @"kQueryFBGraphObjectsWithObjectType";
        waLuaSocialSingleton.fbSendGiftWithContentKey = @"kFbSendGiftWithContent";
        waLuaSocialSingleton.fbAskForGiftWithContentKey = @"kfbAskForGiftWithContent";
        waLuaSocialSingleton.sendRequestWithPlatformKey = @"kSendRequestWithPlatform";
        waLuaSocialSingleton.fbQueryReceivedGiftsWithCompleteBlockKey = @"kFbQueryReceivedGiftsWithCompleteBlock";
        waLuaSocialSingleton.fbQueryAskForGiftRequestsWithCompleteBlockKey = @"kFbQueryAskForGiftRequestsWithCompleteBlock";
        waLuaSocialSingleton.fbDeleteRequestWithRequestIdKey = @"kFbDeleteRequestWithRequestId";
        waLuaSocialSingleton.createInviteInfoWithPlatformKey = @"kCreateInviteInfoWithPlatform";
        waLuaSocialSingleton.inviteInstallRewardPlatformKey = @"kInviteInstallRewardPlatform";
        waLuaSocialSingleton.inviteEventRewardWithPlatformKey = @"kInviteEventRewardWithPlatform";
        waLuaSocialSingleton.mPhotoArrAfter = [NSMutableArray array];
        waLuaSocialSingleton.mPhotoArrBefore = [NSMutableArray array];
        
    }
    return waLuaSocialSingleton;
}

#pragma mark 分享调用方法
+(void)share:(NSDictionary*)dict{
    NSString* paramStr = [dict objectForKey:WA_LUA_PARAM_PARAM];
    NSNumber* succFuncId = [dict objectForKey:WA_LUA_FUNC_SUCCESS];
    NSNumber* failFuncId = [dict objectForKey:WA_LUA_FUNC_FAILURE];
    NSNumber* cancelFuncId = [dict objectForKey:WA_LUA_FUNC_CANCEL];
    
    NSDictionary* paramDict = [NSDictionary fromJSONString:paramStr];
    NSString* platform = [paramDict objectForKey:WA_LUA_PARAM_PLATFORM];
    NSDictionary* shareContentDict = [paramDict objectForKey:WA_LUA_PARAM_SHARE_CONTENT];
    NSNumber* shareWithUI = [paramDict objectForKey:WA_LUA_PARAM_SHARE_WITH_UI];
    
    if (!shareContentDict) {
        WALog("shareContent没有传")
        return;
    }
    

    [self buildShareContentWithDict:shareContentDict completeBlock:^(NSObject<WASharingContent> *shareContent) {
        if (!shareContent) {
            WALog(@"shareContent构建错误")
            return;
        }
        
        [WALuaFuncIdManager addObjWithKey:[self sharedInstance].shareWithPlatformKey succFuncId:succFuncId failFuncId:failFuncId cancelFuncId:cancelFuncId];
        
        
        [WASocialProxy shareWithPlatform:platform shareContent:shareContent shareWithUI:shareWithUI.boolValue delegate:[self sharedInstance]];
    }];
    
    
    
}

#pragma mark 实现协议WASharingDelegate
- (void)sharer:(NSObject<WASharing>*)sharer platform:(NSString *const)platform didCompleteWithResults:(NSDictionary *)results{
    if (![WALuaFuncIdManager getObjWithKey:[WALuaSocialProxy sharedInstance].shareWithPlatformKey option:WALuaExecOptionSucc]) {
        WALog(@"没有传分享成功的回调函数")
    }
    
    NSMutableDictionary* mDict = [NSMutableDictionary dictionary];
    if (sharer) {
        [mDict setObject:sharer forKey:WA_LUA_PARAM_SHARER];
        ;
    }
    
    if (platform) {
        [mDict setObject:platform forKey:WA_LUA_PARAM_PLATFORM];
    }
    
    if (results) {
        [mDict setObject:results forKey:WA_LUA_PARAM_RESULT];
    }
    
    [WALuaFuncIdManager execWithKey:[WALuaSocialProxy sharedInstance].shareWithPlatformKey option:WALuaExecOptionSucc result:mDict];
}


- (void)sharer:(NSObject<WASharing>*)sharer platform:(NSString *const)platform didFailWithError:(NSError *)error{
    if (![WALuaFuncIdManager getObjWithKey:[WALuaSocialProxy sharedInstance].shareWithPlatformKey option:WALuaExecOptionFail]) {
        WALog(@"没有传分享失败的回调函数")
    }
    
    NSMutableDictionary* mDict = [NSMutableDictionary dictionary];
    if (sharer) {
        [mDict setObject:sharer forKey:WA_LUA_PARAM_SHARER];
        ;
    }
    
    if (platform) {
        [mDict setObject:platform forKey:WA_LUA_PARAM_PLATFORM];
    }
    
    if (error) {
        
        NSDictionary* errDict = [WALuaUtil assembleInfoWithError:error];
        [mDict setObject:errDict forKey:WA_LUA_PARAM_ERROR];
    }
    
    [WALuaFuncIdManager execWithKey:[WALuaSocialProxy sharedInstance].shareWithPlatformKey option:WALuaExecOptionFail result:mDict];
}


- (void)sharerDidCancel:(NSObject<WASharing>*)sharer platform:(NSString *const)platform{
    if (![WALuaFuncIdManager getObjWithKey:[WALuaSocialProxy sharedInstance].shareWithPlatformKey option:WALuaExecOptionFail]) {
        WALog(@"没有传分享取消的回调函数")
    }
    
    NSMutableDictionary* mDict = [NSMutableDictionary dictionary];
    if (sharer) {
        [mDict setObject:sharer forKey:WA_LUA_PARAM_SHARER];
        ;
    }
    
    if (platform) {
        [mDict setObject:platform forKey:WA_LUA_PARAM_PLATFORM];
    }
    
    [WALuaFuncIdManager execWithKey:[WALuaSocialProxy sharedInstance].shareWithPlatformKey option:WALuaExecOptionCancel result:mDict];
}
#pragma 构建ShareContent
+(void)buildShareContentWithDict:(NSDictionary*)dict completeBlock:(void(^)(NSObject<WASharingContent>* shareContent))completeBlock{
    
    NSString* shareType = [dict objectForKey:WA_LUA_PARAM_SHARE_TYPE];
    if (!shareType) {
        return;
    }
    
    
    NSString* contentURL = [dict objectForKey:WA_LUA_PARAM_CONTENT_URL];
    NSString* peopleIds = [dict objectForKey:WA_LUA_PARAM_PEOPLE_IDS];
    
    
    NSMutableArray* peopleIdArr =[NSMutableArray arrayWithArray:[peopleIds componentsSeparatedByString:@","]];
    NSMutableArray* tempArr = [NSMutableArray arrayWithArray:peopleIdArr];

    [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:@""]) {
            [peopleIdArr removeObject:obj];
        }
    }];
    
    
    
    NSString* placeId = [dict objectForKey:WA_LUA_PARAM_PLACE_ID];
    NSString* ref = [dict objectForKey:WA_LUA_PARAM_REF];
    
    if ([shareType isEqualToString:WA_LUA_PARAM_LINK_CONTENT]) {
        WAShareLinkContent* linkContent = [[WAShareLinkContent alloc]init];
        linkContent.contentURL = [NSURL URLWithString:contentURL];
        linkContent.peopleIDs = peopleIdArr;
        linkContent.placeID = placeId;
        linkContent.ref = ref;
        
        NSString* contentDescription = [dict objectForKey:WA_LUA_PARAM_CONTENT_DESCRIPTION];
        NSString* contentTitle = [dict objectForKey:WA_LUA_PARAM_CONTENT_TITLE];
        NSString* imageURL = [dict objectForKey:WA_LUA_PARAM_IMAGE_URL];
        
        linkContent.contentDescription = contentDescription;
        linkContent.contentTitle = contentTitle;
        linkContent.imageURL = [NSURL URLWithString:imageURL];
        
        
        completeBlock(linkContent);
        return ;
        
    }else if ([shareType isEqualToString:WA_LUA_PARAM_PHOTO_CONTENT]) {
        
        NSArray* photoArr = [dict objectForKey:WA_LUA_PARAM_PHOTOS];
        
        [self dealWithPhotoArr:photoArr isStart:YES completeBlock:^(NSArray *photos) {
            WASharePhotoContent* photoContent = [[WASharePhotoContent alloc]init];
            photoContent.contentURL = [NSURL URLWithString:contentURL];
            photoContent.peopleIDs = peopleIdArr;
            photoContent.placeID = placeId;
            photoContent.ref = ref;
            photoContent.photos = photos;
            
            completeBlock(photoContent);
            
            return ;
        }];
        
        
    }else if ([shareType isEqualToString:WA_LUA_PARAM_VIDEO_CONTENT]) {
        WAShareVideoContent* videoContent = [[WAShareVideoContent alloc]init];
        
        videoContent.contentURL = [NSURL URLWithString:contentURL];
        videoContent.peopleIDs = peopleIdArr;
        videoContent.placeID = placeId;
        videoContent.ref = ref;
        
        NSDictionary* previewPhotoDict = [dict objectForKey:WA_LUA_PARAM_PREVIEW_PHOTO];
        NSString* imageURL = [previewPhotoDict objectForKey:WA_LUA_PARAM_IMAGE_URL];
        NSNumber* userGenerated = [previewPhotoDict objectForKey:WA_LUA_PARAM_USER_GENERATED];
        NSString* caption = [previewPhotoDict objectForKey:WA_LUA_PARAM_CAPTION];
        
        WASharePhoto* previewPhoto = [[WASharePhoto alloc]init];
        previewPhoto.imageURL = [NSURL URLWithString:imageURL];
        previewPhoto.caption = caption;
        if (userGenerated) {
            previewPhoto.userGenerated = userGenerated.boolValue;
        }
//        WAShareVideo
        NSDictionary* videoDict = [dict objectForKey:WA_LUA_PARAM_VIDEO];
        NSString* videoURL = [videoDict objectForKey:WA_LUA_PARAM_VIDEO_URL];
        
        
        WAShareVideo* video = [[WAShareVideo alloc]init];
        video.videoURL = [NSURL URLWithString:videoURL];
        
        videoContent.previewPhoto = previewPhoto;
        videoContent.video = video;
        
        completeBlock(videoContent);
        return;
        
    }
    
}


+(void)dealWithPhotoArr:(NSArray*)photoArr isStart:(BOOL)isStart completeBlock:(void(^)(NSArray* photos))completeBlock{


    if (isStart) {
        if ([self sharedInstance].mPhotoArrAfter.count) {
            [[self sharedInstance].mPhotoArrAfter removeAllObjects];
        }
        if ([self sharedInstance].mPhotoArrBefore.count) {
            [[self sharedInstance].mPhotoArrBefore removeAllObjects];
        }
        
        [self sharedInstance].mPhotoArrBefore = [NSMutableArray arrayWithArray:photoArr];

    }
    
    NSDictionary* photoObj = [[self sharedInstance].mPhotoArrBefore firstObject];
    
    if (!photoObj) {
        completeBlock([self sharedInstance].mPhotoArrAfter);
        return;
    }
    
    NSString* imageURL = [photoObj objectForKey:WA_LUA_PARAM_IMAGE_URL];
    NSNumber* userGenerated = [photoObj objectForKey:WA_LUA_PARAM_USER_GENERATED];
    NSString* caption = [photoObj objectForKey:WA_LUA_PARAM_CAPTION];
    
    
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    [assetsLibrary assetForURL:[NSURL URLWithString:imageURL] resultBlock:^(ALAsset *asset) {
        
        WASharePhoto* photo = [[WASharePhoto alloc]init];
        photo.imageURL = [NSURL URLWithString:imageURL];
        photo.caption = caption;
        if (userGenerated) {
            photo.userGenerated = userGenerated.boolValue;
        }

        CGImageRef imageRef = [asset aspectRatioThumbnail];
        UIImage* image = [UIImage imageWithCGImage:imageRef];
        photo.image = image;
        [[self sharedInstance].mPhotoArrAfter addObject:photo];
        [[self sharedInstance].mPhotoArrBefore removeObjectAtIndex:0];
        [self dealWithPhotoArr:photoArr isStart:NO completeBlock:completeBlock];
    } failureBlock:^(NSError *error) {
        [[self sharedInstance].mPhotoArrBefore removeObjectAtIndex:0];
        [self dealWithPhotoArr:photoArr isStart:NO completeBlock:completeBlock];
    }];
    
    
}

#pragma mark 应用邀请调用方法
+(void)appInvite:(NSDictionary*)dict{
    NSString* platform = [dict objectForKey:WA_LUA_PARAM_PLATFORM];
    NSString* appInvitePreviewImageURL = [dict objectForKey:WA_LUA_PARAM_APP_INVITE_PREVIEW_IMAGE_URL];
    NSString* appLinkURL = [dict objectForKey:WA_LUA_PARAM_APP_LINK_URL];
    
    NSNumber* succFuncId = [dict objectForKey:WA_LUA_FUNC_SUCCESS];
    NSNumber* failFuncId = [dict objectForKey:WA_LUA_FUNC_FAILURE];
    
    if (!appInvitePreviewImageURL||!appLinkURL) {
        WALog(@"appInvitePreviewImageURL或者appLinkURL不能为空")
        return;
    }
    WAAppInviteContent* inviteContent = [[WAAppInviteContent alloc]init];
    inviteContent.appInvitePreviewImageURL = [NSURL URLWithString:appInvitePreviewImageURL];
    inviteContent.appLinkURL = [NSURL URLWithString:appLinkURL];
    
    [WALuaFuncIdManager addObjWithKey:[self sharedInstance].appInviteWithPlatformKey succFuncId:succFuncId failFuncId:failFuncId cancelFuncId:nil];
    
    [WASocialProxy appInviteWithPlatform:platform Content:inviteContent delegate:[self sharedInstance]];
}

#pragma 实现协议WAAppInviteDialogDelegate

- (void)appInviteDialog:(WAAppInviteDialog *)appInviteDialog platform:(NSString *const)platform didCompleteWithResults:(NSDictionary *)results{
    if (![WALuaFuncIdManager getObjWithKey:[WALuaSocialProxy sharedInstance].appInviteWithPlatformKey option:WALuaExecOptionSucc]) {
        WALog(@"没有传应用邀请成功的回调函数")
    }
    
    NSMutableDictionary* mDict = [NSMutableDictionary dictionary];
    if (appInviteDialog) {
        [mDict setObject:appInviteDialog forKey:WA_LUA_PARAM_APP_INVITE_DIALOG];
    }
    
    if (platform) {
        [mDict setObject:platform forKey:WA_LUA_PARAM_PLATFORM];
    }
    
    if (results) {
        [mDict setObject:results forKey:WA_LUA_PARAM_RESULT];
    }
    
    [WALuaFuncIdManager execWithKey:[WALuaSocialProxy sharedInstance].appInviteWithPlatformKey option:WALuaExecOptionSucc result:mDict];
}

- (void)appInviteDialog:(WAAppInviteDialog *)appInviteDialog platform:(NSString *const)platform didFailWithError:(NSError *)error{
    if (![WALuaFuncIdManager getObjWithKey:[WALuaSocialProxy sharedInstance].appInviteWithPlatformKey option:WALuaExecOptionFail]) {
        WALog(@"没有传应用邀请失败的回调函数")
    }
    
    NSMutableDictionary* mDict = [NSMutableDictionary dictionary];
    if (appInviteDialog) {
        [mDict setObject:appInviteDialog forKey:WA_LUA_PARAM_APP_INVITE_DIALOG];
    }
    
    if (platform) {
        [mDict setObject:platform forKey:WA_LUA_PARAM_PLATFORM];
    }
    
    if (error) {
        NSDictionary* errDict = [WALuaUtil assembleInfoWithError:error];
        [mDict setObject:errDict forKey:WA_LUA_PARAM_ERROR];
    }
    
    [WALuaFuncIdManager execWithKey:[WALuaSocialProxy sharedInstance].appInviteWithPlatformKey option:WALuaExecOptionSucc result:mDict];
}

#pragma mark 获取可邀请好友列表
+(void)queryInvitableFriends:(NSDictionary*)dict{
    NSNumber* durationNum = [dict objectForKey:WA_LUA_PARAM_DURATION];
    NSString* platform = [dict objectForKey:WA_LUA_PARAM_PLATFORM];

    NSNumber* succFuncId = [dict objectForKey:WA_LUA_FUNC_SUCCESS];
    NSNumber* failFuncId = [dict objectForKey:WA_LUA_FUNC_FAILURE];
    
    [WALuaFuncIdManager addObjWithKey:[self sharedInstance].queryInvitableFriendsWithDurationKey succFuncId:succFuncId failFuncId:failFuncId cancelFuncId:nil];
    
    [WASocialProxy queryInvitableFriendsWithDuration:durationNum.floatValue platform:platform completeBlock:^(NSArray *friends, NSError *error) {
        if (error) {
            if (!failFuncId) {
                WALog(@"没有传可邀请好友列表的失败回调函数")
            }
            NSMutableDictionary* mDict = [NSMutableDictionary dictionary];
            [mDict setObject:platform forKey:WA_LUA_PARAM_PLATFORM];
            NSDictionary* errDict = [WALuaUtil assembleInfoWithError:error];
            [mDict setObject:errDict forKey:WA_LUA_PARAM_ERROR];
            [WALuaFuncIdManager execWithKey:[self sharedInstance].queryInvitableFriendsWithDurationKey option:WALuaExecOptionFail result:mDict];
        }else{
            if (!succFuncId) {
                WALog(@"没有传可邀请好友列表的成功回调函数")
            }
            [WALuaFuncIdManager execWithKey:[self sharedInstance].queryInvitableFriendsWithDurationKey option:WALuaExecOptionSucc result:friends];
        }
    }];
}

#pragma mark 向好友发送邀请
+(void)gameInvite:(NSDictionary *)dict{
    [self gameRequestWithDict:dict gameRequestOpt:WALuaGameRequestOptionInvite];
}

#pragma mark 实现协议WAGameRequestDialogDelegate
- (void)gameRequestDialog:(WAGameRequestDialog *)gameRequestDialog platform:(NSString *const)platform didCompleteWithResults:(NSDictionary *)results{

    NSMutableDictionary* mDict = [NSMutableDictionary dictionary];
    if (gameRequestDialog) {
        [mDict setObject:gameRequestDialog forKey:WA_LUA_PARAM_GAME_REQUEST_DIALOG];
    }
    
    if (platform) {
        [mDict setObject:platform forKey:WA_LUA_PARAM_PLATFORM];
    }
    
    if (results) {
        [mDict setObject:results forKey:WA_LUA_PARAM_RESULT];
    }
    [self dealGameRequestWithDict:mDict execOpt:WALuaExecOptionSucc];
}

- (void)gameRequestDialog:(WAGameRequestDialog *)gameRequestDialog platform:(NSString *const)platform didFailWithError:(NSError *)error{

    NSMutableDictionary* mDict = [NSMutableDictionary dictionary];
    if (gameRequestDialog) {
        [mDict setObject:gameRequestDialog forKey:WA_LUA_PARAM_GAME_REQUEST_DIALOG];
    }
    
    if (platform) {
        [mDict setObject:platform forKey:WA_LUA_PARAM_PLATFORM];
    }
    
    if (error) {
        NSDictionary* errDict = [WALuaUtil assembleInfoWithError:error];
        [mDict setObject:errDict forKey:WA_LUA_PARAM_ERROR];
    }
    
    [self dealGameRequestWithDict:mDict execOpt:WALuaExecOptionFail];
}

- (void)gameRequestDialogDidCancel:(WAGameRequestDialog *)gameRequestDialog platform:(NSString *const)platform{

    NSMutableDictionary* mDict = [NSMutableDictionary dictionary];
    if (gameRequestDialog) {
        [mDict setObject:gameRequestDialog forKey:WA_LUA_PARAM_GAME_REQUEST_DIALOG];
    }
    
    if (platform) {
        [mDict setObject:platform forKey:WA_LUA_PARAM_PLATFORM];
    }
    
    [self dealGameRequestWithDict:mDict execOpt:WALuaExecOptionCancel];
}

-(void)dealGameRequestWithDict:(NSDictionary*)dict execOpt:(WALuaExecOption)execOpt{
    if (_gameRequestOption == WALuaGameRequestOptionAsk) {
        [WALuaFuncIdManager execWithKey:[WALuaSocialProxy sharedInstance].fbAskForGiftWithContentKey option:execOpt result:dict];
    }else if(_gameRequestOption == WALuaGameRequestOptionSend){
        [WALuaFuncIdManager execWithKey:[WALuaSocialProxy sharedInstance].fbSendGiftWithContentKey option:execOpt result:dict];
    }else if(_gameRequestOption == WALuaGameRequestOptionInvite){
        [WALuaFuncIdManager execWithKey:[WALuaSocialProxy sharedInstance].gameInviteWithPlatformKey option:execOpt result:dict];
    }else if(_gameRequestOption == WALuaGameRequestOptionAll){
        [WALuaFuncIdManager execWithKey:[WALuaSocialProxy sharedInstance].sendRequestWithPlatformKey option:execOpt result:dict];
    }
    
}

#pragma mark 查询赠送/索要礼物的好友列表
+(void)queryFriends:(NSDictionary*)dict{
    
    NSString* platform = [dict objectForKey:WA_LUA_PARAM_PLATFORM];
    NSNumber* succFuncId = [dict objectForKey:WA_LUA_FUNC_SUCCESS];
    NSNumber* failFuncId = [dict objectForKey:WA_LUA_FUNC_FAILURE];
    
    [WALuaFuncIdManager addObjWithKey:[self sharedInstance].queryFriendsWithPlatformKey succFuncId:succFuncId failFuncId:failFuncId cancelFuncId:nil];
    
    [WASocialProxy queryFriendsWithPlatform:platform completeBlock:^(NSArray *friends, NSError *error) {
        if (error) {
            if (!failFuncId) {
                WALog(@"queryFriendsWithPlatform没有传失败回调函数")
            }
            NSMutableDictionary* mDict = [NSMutableDictionary dictionary];
            [mDict setObject:platform forKey:WA_LUA_PARAM_PLATFORM];
            NSDictionary* errDict = [WALuaUtil assembleInfoWithError:error];
            [mDict setObject:errDict forKey:WA_LUA_PARAM_ERROR];
            [WALuaFuncIdManager execWithKey:[self sharedInstance].queryFriendsWithPlatformKey option:WALuaExecOptionFail result:mDict];
            
        }else{
            if (!succFuncId) {
                WALog(@"queryFriendsWithPlatform没有传成功回调函数")
            }

            [WALuaFuncIdManager execWithKey:[self sharedInstance].queryFriendsWithPlatformKey option:WALuaExecOptionSucc result:friends];
        }
    }];
}

+(void)getGroupByGid:(NSDictionary*)dict{
    NSString* platform = [dict objectForKey:WA_LUA_PARAM_PLATFORM];
    NSString* extInfo = [dict objectForKey:WA_LUA_PARAM_EXT_INFO];
    NSString* gids = [dict objectForKey:WA_LUA_PARAM_GROUP_IDS];
    NSNumber* succFuncId = [dict objectForKey:WA_LUA_FUNC_SUCCESS];
    NSNumber* failFuncId = [dict objectForKey:WA_LUA_FUNC_FAILURE];
    
    [WALuaFuncIdManager addObjWithKey:[self sharedInstance].getGroupByGidKey succFuncId:succFuncId failFuncId:failFuncId cancelFuncId:nil];
    
    
    NSMutableArray* gidArr = [NSMutableArray array];
    if (gids) {
        gidArr =[NSMutableArray arrayWithArray:[gids componentsSeparatedByString:@","]] ;
        NSArray* temtArr = [NSArray arrayWithArray:gidArr];
        [temtArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isEqualToString:@""]) {
                [gidArr removeObject:obj];
            }
        }];
    }
    
    
    [WASocialProxy getGroupWithPlatform:platform groupIds:gidArr extInfo:extInfo completeBlock:^(NSArray *groups, NSError *error) {
        if (error) {
            if (!failFuncId) {
                WALog(@"getGroupByGidKey没有传失败回调函数")
            }
            NSMutableDictionary* mDict = [NSMutableDictionary dictionary];
            [mDict setObject:platform forKey:WA_LUA_PARAM_PLATFORM];
            NSDictionary* errDict = [WALuaUtil assembleInfoWithError:error];
            [mDict setObject:errDict forKey:WA_LUA_PARAM_ERROR];
            [WALuaFuncIdManager execWithKey:[self sharedInstance].getGroupByGidKey option:WALuaExecOptionFail result:mDict];
            
        }else{
            if (!succFuncId) {
                WALog(@"getGroupByGidKey没有传成功回调函数")
            }
            
            [WALuaFuncIdManager execWithKey:[self sharedInstance].getGroupByGidKey option:WALuaExecOptionSucc result:groups];
        }
    }];
}



#pragma mark 获取当前App所属的group
+(void)getCurrentAppLinkedGroup:(NSDictionary*)dict{
    NSString* platform = [dict objectForKey:WA_LUA_PARAM_PLATFORM];
    NSString* extInfo = [dict objectForKey:WA_LUA_PARAM_EXT_INFO];
    NSNumber* succFuncId = [dict objectForKey:WA_LUA_FUNC_SUCCESS];
    NSNumber* failFuncId = [dict objectForKey:WA_LUA_FUNC_FAILURE];
    
    [WALuaFuncIdManager addObjWithKey:[self sharedInstance].getCurrentAppLinkedGroupWithPlatfromKey succFuncId:succFuncId failFuncId:failFuncId cancelFuncId:nil];
    
    
    [WASocialProxy getCurrentAppLinkedGroupWithPlatfrom:platform extInfo:extInfo completeBlock:^(NSArray *groups, NSError *error) {
        if (error) {
            if (!failFuncId) {
                WALog(@"getCurrentAppLinkedGroupWithPlatfrom没有传失败回调函数")
            }
            NSMutableDictionary* mDict = [NSMutableDictionary dictionary];
            [mDict setObject:platform forKey:WA_LUA_PARAM_PLATFORM];
            NSDictionary* errDict = [WALuaUtil assembleInfoWithError:error];
            [mDict setObject:errDict forKey:WA_LUA_PARAM_ERROR];
            [WALuaFuncIdManager execWithKey:[self sharedInstance].getCurrentAppLinkedGroupWithPlatfromKey option:WALuaExecOptionFail result:mDict];
            
        }else{
            if (!succFuncId) {
                WALog(@"getCurrentAppLinkedGroupWithPlatfrom没有传成功回调函数")
            }
            
            [WALuaFuncIdManager execWithKey:[self sharedInstance].getCurrentAppLinkedGroupWithPlatfromKey option:WALuaExecOptionSucc result:groups];
        }
    }];
}

#pragma mark 获取当前user所属的group
+(void)getCurrentUserGroup:(NSDictionary*)dict{
    NSString* platform = [dict objectForKey:WA_LUA_PARAM_PLATFORM];
    NSString* extInfo = [dict objectForKey:WA_LUA_PARAM_EXT_INFO];
    NSNumber* succFuncId = [dict objectForKey:WA_LUA_FUNC_SUCCESS];
    NSNumber* failFuncId = [dict objectForKey:WA_LUA_FUNC_FAILURE];
    
    [WALuaFuncIdManager addObjWithKey:[self sharedInstance].getCurrentUserGroupWithPlatfromKey succFuncId:succFuncId failFuncId:failFuncId cancelFuncId:nil];
    
    [WASocialProxy getCurrentUserGroupWithPlatfrom:platform extInfo:extInfo completeBlock:^(NSArray *groups, NSError *error) {
        if (error) {
            if (!failFuncId) {
                WALog(@"getCurrentUserGroupWithPlatfrom没有传失败回调函数")
            }
            NSMutableDictionary* mDict = [NSMutableDictionary dictionary];
            [mDict setObject:platform forKey:WA_LUA_PARAM_PLATFORM];
            NSDictionary* errDict = [WALuaUtil assembleInfoWithError:error];
            [mDict setObject:errDict forKey:WA_LUA_PARAM_ERROR];
            [WALuaFuncIdManager execWithKey:[self sharedInstance].getCurrentUserGroupWithPlatfromKey option:WALuaExecOptionFail result:mDict];
            
        }else{
            if (!succFuncId) {
                WALog(@"getCurrentUserGroupWithPlatfrom没有传成功回调函数")
            }
            
            [WALuaFuncIdManager execWithKey:[self sharedInstance].getCurrentUserGroupWithPlatfromKey option:WALuaExecOptionSucc result:groups];
        }
    }];
    
}

#pragma 根据groupId查询对应的group;
+(void)getGroup:(NSDictionary*)dict{
    NSString* platform = [dict objectForKey:WA_LUA_PARAM_PLATFORM];
    NSString* extInfo = [dict objectForKey:WA_LUA_PARAM_EXT_INFO];
    NSNumber* succFuncId = [dict objectForKey:WA_LUA_FUNC_SUCCESS];
    NSNumber* failFuncId = [dict objectForKey:WA_LUA_FUNC_FAILURE];
    
    NSString* groupIds = [dict objectForKey:WA_LUA_PARAM_GROUP_IDS];
    
    NSMutableArray* groupIdArr = [NSMutableArray array];
    NSArray* tempArr = [groupIds componentsSeparatedByString:@","];
    [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj isEqualToString:@""]) {
            [groupIdArr addObject:obj];
        }
    }];
    
    [WALuaFuncIdManager addObjWithKey:[self sharedInstance].getGroupWithPlatformKey succFuncId:succFuncId failFuncId:failFuncId cancelFuncId:nil];
    
    [WASocialProxy getGroupWithPlatform:platform groupIds:groupIdArr extInfo:extInfo completeBlock:^(NSArray *groups, NSError *error) {
        if (error) {
            if (!failFuncId) {
                WALog(@"getGroupWithPlatform没有传失败回调函数")
            }
            NSMutableDictionary* mDict = [NSMutableDictionary dictionary];
            [mDict setObject:platform forKey:WA_LUA_PARAM_PLATFORM];
            NSDictionary* errDict = [WALuaUtil assembleInfoWithError:error];
            [mDict setObject:errDict forKey:WA_LUA_PARAM_ERROR];
            [WALuaFuncIdManager execWithKey:[self sharedInstance].getGroupWithPlatformKey option:WALuaExecOptionFail result:mDict];
            
        }else{
            if (!succFuncId) {
                WALog(@"getGroupWithPlatform没有传成功回调函数")
            }
            
            [WALuaFuncIdManager execWithKey:[self sharedInstance].getGroupWithPlatformKey option:WALuaExecOptionSucc result:groups];
        }
    }];
    
}

#pragma mark 返回当前应用推荐的所有group
+(void)getGroups:(NSDictionary*)dict{
    NSString* platform = [dict objectForKey:WA_LUA_PARAM_PLATFORM];
    NSString* extInfo = [dict objectForKey:WA_LUA_PARAM_EXT_INFO];
    NSNumber* succFuncId = [dict objectForKey:WA_LUA_FUNC_SUCCESS];
    NSNumber* failFuncId = [dict objectForKey:WA_LUA_FUNC_FAILURE];
    
    [WALuaFuncIdManager addObjWithKey:[self sharedInstance].getGroupsWithPlatformKey_ succFuncId:succFuncId failFuncId:failFuncId cancelFuncId:nil];
    
    
    [WASocialProxy getGroupsWithPlatform:platform extInfo:extInfo completeBlock:^(NSArray *groups, NSError *error) {
        if (error) {
            if (!failFuncId) {
                WALog(@"getGroupsWithPlatform没有传失败回调函数")
            }
            NSMutableDictionary* mDict = [NSMutableDictionary dictionary];
            [mDict setObject:platform forKey:WA_LUA_PARAM_PLATFORM];
            NSDictionary* errDict = [WALuaUtil assembleInfoWithError:error];
            [mDict setObject:errDict forKey:WA_LUA_PARAM_ERROR];
            [WALuaFuncIdManager execWithKey:[self sharedInstance].getGroupsWithPlatformKey_ option:WALuaExecOptionFail result:mDict];
            
        }else{
            if (!succFuncId) {
                WALog(@"getGroupsWithPlatform没有传成功回调函数")
            }
            
            [WALuaFuncIdManager execWithKey:[self sharedInstance].getGroupsWithPlatformKey_ option:WALuaExecOptionSucc result:groups];
        }
    }];
    
}

+(void)joinGroup:(NSDictionary*)dict{
    NSString* platform = [dict objectForKey:WA_LUA_PARAM_PLATFORM];
    NSString* extInfo = [dict objectForKey:WA_LUA_PARAM_EXT_INFO];
    NSNumber* succFuncId = [dict objectForKey:WA_LUA_FUNC_SUCCESS];
    NSNumber* failFuncId = [dict objectForKey:WA_LUA_FUNC_FAILURE];
    NSString* groupId = [dict objectForKey:WA_LUA_PARAM_GROUP_ID];
    
    [WALuaFuncIdManager addObjWithKey:[self sharedInstance].joinGroupWithPlatformKey succFuncId:succFuncId failFuncId:failFuncId cancelFuncId:nil];
    
    
    [WASocialProxy joinGroupWithPlatform:platform groupId:groupId extInfo:extInfo completeBlock:^(NSError *error) {
        if (error) {
            if (!failFuncId) {
                WALog(@"joinGroupWithPlatform没有传失败回调函数")
            }
            
            NSMutableDictionary* mDict = [NSMutableDictionary dictionary];
            [mDict setObject:platform forKey:WA_LUA_PARAM_PLATFORM];
            NSDictionary* errDict = [WALuaUtil assembleInfoWithError:error];
            [mDict setObject:errDict forKey:WA_LUA_PARAM_ERROR];
            
            [WALuaFuncIdManager execWithKey:[self sharedInstance].joinGroupWithPlatformKey option:WALuaExecOptionFail result:mDict];
            
        }else{
            if (!succFuncId) {
                WALog(@"joinGroupWithPlatform没有传成功回调函数")
            }
            
            [WALuaFuncIdManager execWithKey:[self sharedInstance].joinGroupWithPlatformKey option:WALuaExecOptionSucc result:@{@"success":@YES}];
        }
    }];
    
    
}

+(void)openGroupPage:(NSDictionary*)dict{
    NSString* platform = [dict objectForKey:WA_LUA_PARAM_PLATFORM];
    NSString* extInfo = [dict objectForKey:WA_LUA_PARAM_EXT_INFO];
    NSString* groupUri = [dict objectForKey:WA_LUA_PARAM_GROUP_URI];
    [WASocialProxy openGroupPageWithPlatform:platform groupUri:groupUri extInfo:extInfo];
    
}

+(void)queryFBGraphObjects:(NSDictionary*)dict{

    NSNumber* succFuncId = [dict objectForKey:WA_LUA_FUNC_SUCCESS];
    NSNumber* failFuncId = [dict objectForKey:WA_LUA_FUNC_FAILURE];
    NSString* objectType = [dict objectForKey:WA_LUA_PARAM_OBJECT_TYPE];
    
    [WALuaFuncIdManager addObjWithKey:[self sharedInstance].queryFBGraphObjectsWithObjectTypeKey succFuncId:succFuncId failFuncId:failFuncId cancelFuncId:nil];
    
    [WASocialProxy queryFBGraphObjectsWithObjectType:objectType completeBlock:^(NSArray<WAFBObject *> *objects, NSError *error) {
        if (error) {
            if (!failFuncId) {
                WALog(@"queryFBGraphObjectsWithObjectType没有传失败回调函数")
            }
            NSMutableDictionary* mDict = [NSMutableDictionary dictionary];
            [mDict setObject:WA_PLATFORM_FACEBOOK forKey:WA_LUA_PARAM_PLATFORM];
            NSDictionary* errDict = [WALuaUtil assembleInfoWithError:error];
            [mDict setObject:errDict forKey:WA_LUA_PARAM_ERROR];
            [WALuaFuncIdManager execWithKey:[self sharedInstance].queryFBGraphObjectsWithObjectTypeKey option:WALuaExecOptionFail result:mDict];
            
        }else{
            if (!succFuncId) {
                WALog(@"queryFBGraphObjectsWithObjectType没有传成功回调函数")
            }
            
            [WALuaFuncIdManager execWithKey:[self sharedInstance].queryFBGraphObjectsWithObjectTypeKey option:WALuaExecOptionSucc result:objects];
        }
    }];
    
}

+(void)fbSendGift:(NSDictionary*)dict{
   [self gameRequestWithDict:dict gameRequestOpt:WALuaGameRequestOptionSend];
}

+(void)fbAskForGift:(NSDictionary*)dict{
    [self gameRequestWithDict:dict gameRequestOpt:WALuaGameRequestOptionAsk];
}



+(void)gameRequestWithDict:(NSDictionary*)dict gameRequestOpt:(WALuaGameRequestOption)gameRequestOpt{
    
    [self sharedInstance].gameRequestOption = gameRequestOpt;
    
    NSString* platform = [dict objectForKey:WA_LUA_PARAM_PLATFORM];
    NSString* data = [dict objectForKey:WA_LUA_PARAM_DATA];
    NSString* message = [dict objectForKey:WA_LUA_PARAM_MESSAGE];
    NSString* objectID = [dict objectForKey:WA_LUA_PARAM_OBJECT_ID];
    NSString* title = [dict objectForKey:WA_LUA_PARAM_TITLE];
    NSNumber* actionType = [dict objectForKey:WA_LUA_PARAM_ACTION_TYPE];
    NSString* recipients = [dict objectForKey:WA_LUA_PARAM_RECIPIENTS];
    NSString* recipientSuggestions = [dict objectForKey:WA_LUA_PARAM_RECIPIENT_SUGGESTIONS];
    NSString* requestType = [dict objectForKey:WA_LUA_PARAM_REQUEST_TYPE];
    
    NSMutableArray* recipientArr = [NSMutableArray array];
    if (recipients) {
        recipientArr =[NSMutableArray arrayWithArray:[recipients componentsSeparatedByString:@","]] ;
        NSArray* temtArr = [NSArray arrayWithArray:recipientArr];
        [temtArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isEqualToString:@""]) {
                [recipientArr removeObject:obj];
            }
        }];
    }
    
    
    
    NSMutableArray* recipientSuggestionsArr = [NSMutableArray array];
    if (recipientSuggestions) {
        recipientSuggestionsArr =[NSMutableArray arrayWithArray:[recipientSuggestions componentsSeparatedByString:@","]] ;
        NSArray* temtArr = [NSArray arrayWithArray:recipientSuggestionsArr];
        [temtArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isEqualToString:@""]) {
                [recipientSuggestionsArr removeObject:obj];
            }
        }];
    }
    
    WAGameRequestContent* gameRequestContent = [[WAGameRequestContent alloc]init];
    if (actionType) {
        gameRequestContent.actionType = (WAGameRequestActionType)actionType.intValue;
    }else{
        if (gameRequestOpt == WALuaGameRequestOptionInvite) {
            gameRequestContent.actionType = WAGameRequestActionInvite;
        }else if(gameRequestOpt == WALuaGameRequestOptionSend){
            gameRequestContent.actionType = WAGameRequestActionTypeSend;
        }else if(gameRequestOpt == WALuaGameRequestOptionAsk){
            gameRequestContent.actionType = WAGameRequestActionTypeAskFor;
        }
    }
    gameRequestContent.data = data;
    gameRequestContent.message = message;
    gameRequestContent.objectID = objectID;
    gameRequestContent.title = title;
    if (recipientArr.count) {
        gameRequestContent.recipients = recipientArr;
    }
    if (recipientSuggestionsArr.count) {
        gameRequestContent.recipientSuggestions = recipientSuggestionsArr;
    }
    
    
    NSNumber* succFuncId = [dict objectForKey:WA_LUA_FUNC_SUCCESS];
    NSNumber* failFuncId = [dict objectForKey:WA_LUA_FUNC_FAILURE];
    NSNumber* cancelFuncId = [dict objectForKey:WA_LUA_FUNC_CANCEL];
    
    if (gameRequestOpt == WALuaGameRequestOptionInvite) {
        [WALuaFuncIdManager addObjWithKey:[self sharedInstance].gameInviteWithPlatformKey succFuncId:succFuncId failFuncId:failFuncId cancelFuncId:cancelFuncId];
        [WASocialProxy gameInviteWithPlatform:platform Content:gameRequestContent delegate:[self sharedInstance]];
    }else if(gameRequestOpt == WALuaGameRequestOptionSend){
        [WALuaFuncIdManager addObjWithKey:[self sharedInstance].fbSendGiftWithContentKey succFuncId:succFuncId failFuncId:failFuncId cancelFuncId:cancelFuncId];
        [WASocialProxy fbSendGiftWithContent:gameRequestContent delegate:[self sharedInstance]];
    }else if (gameRequestOpt == WALuaGameRequestOptionAsk){
        [WALuaFuncIdManager addObjWithKey:[self sharedInstance].fbAskForGiftWithContentKey succFuncId:succFuncId failFuncId:failFuncId cancelFuncId:cancelFuncId];
        [WASocialProxy fbAskForGiftWithContent:gameRequestContent delegate:[self sharedInstance]];
    }else if (gameRequestOpt == WALuaGameRequestOptionAll){
        [WALuaFuncIdManager addObjWithKey:[self sharedInstance].sendRequestWithPlatformKey succFuncId:succFuncId failFuncId:failFuncId cancelFuncId:cancelFuncId];
        [WASocialProxy sendRequestWithPlatform:platform requestType:requestType title:title message:message objectId:objectID receiptIds:recipientArr delegate:[self sharedInstance]];
    }
    
   
}

+(void)fbQueryReceivedGifts:(NSDictionary*)dict{
   
    NSNumber* succFuncId = [dict objectForKey:WA_LUA_FUNC_SUCCESS];
    NSNumber* failFuncId = [dict objectForKey:WA_LUA_FUNC_FAILURE];
    
    [WALuaFuncIdManager addObjWithKey:[self sharedInstance].fbQueryReceivedGiftsWithCompleteBlockKey succFuncId:succFuncId failFuncId:failFuncId cancelFuncId:nil];
    
    
    [WASocialProxy fbQueryReceivedGiftsWithCompleteBlock:^(NSArray<WAFBAppRequest *> *gifts, NSError *error) {
        if (error) {
            if (!failFuncId) {
                WALog(@"fbQueryReceivedGiftsWithCompleteBlock没有传失败回调函数")
            }
            NSMutableDictionary* mDict = [NSMutableDictionary dictionary];
            [mDict setObject:WA_PLATFORM_FACEBOOK forKey:WA_LUA_PARAM_PLATFORM];
            NSDictionary* errDict = [WALuaUtil assembleInfoWithError:error];
            [mDict setObject:errDict forKey:WA_LUA_PARAM_ERROR];
            [WALuaFuncIdManager execWithKey:[self sharedInstance].fbQueryReceivedGiftsWithCompleteBlockKey option:WALuaExecOptionFail result:mDict];
            
        }else{
            if (!succFuncId) {
                WALog(@"fbQueryReceivedGiftsWithCompleteBlock没有传成功回调函数")
            }
            
            [WALuaFuncIdManager execWithKey:[self sharedInstance].fbQueryReceivedGiftsWithCompleteBlockKey option:WALuaExecOptionSucc result:gifts];
        }
    }];
    
}

+(void)fbQueryAskForGiftRequests:(NSDictionary*)dict{
    NSNumber* succFuncId = [dict objectForKey:WA_LUA_FUNC_SUCCESS];
    NSNumber* failFuncId = [dict objectForKey:WA_LUA_FUNC_FAILURE];
    
    [WALuaFuncIdManager addObjWithKey:[self sharedInstance].fbQueryAskForGiftRequestsWithCompleteBlockKey succFuncId:succFuncId failFuncId:failFuncId cancelFuncId:nil];
    
    [WASocialProxy fbQueryAskForGiftRequestsWithCompleteBlock:^(NSArray<WAFBAppRequest *> *requests, NSError *error) {
        if (error) {
            if (!failFuncId) {
                WALog(@"fbQueryAskForGiftRequestsWithCompleteBlockKey没有传失败回调函数")
            }
            NSMutableDictionary* mDict = [NSMutableDictionary dictionary];
            [mDict setObject:WA_PLATFORM_FACEBOOK forKey:WA_LUA_PARAM_PLATFORM];
            NSDictionary* errDict = [WALuaUtil assembleInfoWithError:error];
            [mDict setObject:errDict forKey:WA_LUA_PARAM_ERROR];
            [WALuaFuncIdManager execWithKey:[self sharedInstance].fbQueryAskForGiftRequestsWithCompleteBlockKey option:WALuaExecOptionFail result:mDict];
            
        }else{
            if (!succFuncId) {
                WALog(@"fbQueryAskForGiftRequestsWithCompleteBlockKey没有传成功回调函数")
            }
            
            [WALuaFuncIdManager execWithKey:[self sharedInstance].fbQueryAskForGiftRequestsWithCompleteBlockKey option:WALuaExecOptionSucc result:requests];
        }
    }];
    
}

+(void)fbDeleteRequest:(NSDictionary*)dict{
    NSNumber* succFuncId = [dict objectForKey:WA_LUA_FUNC_SUCCESS];
    NSNumber* failFuncId = [dict objectForKey:WA_LUA_FUNC_FAILURE];
    NSString* requestId = [dict objectForKey:WA_LUA_PARAM_REQUEST_ID];
    
    [WALuaFuncIdManager addObjWithKey:[self sharedInstance].fbDeleteRequestWithRequestIdKey succFuncId:succFuncId failFuncId:failFuncId cancelFuncId:nil];
    
    [WASocialProxy fbDeleteRequestWithRequestId:requestId completeBlock:^(id result, NSError *error) {
        if (error) {
            if (!failFuncId) {
                WALog(@"fbDeleteRequestWithRequestIdKey没有传失败回调函数")
            }
            NSMutableDictionary* mDict = [NSMutableDictionary dictionary];
            [mDict setObject:WA_PLATFORM_FACEBOOK forKey:WA_LUA_PARAM_PLATFORM];
            NSDictionary* errDict = [WALuaUtil assembleInfoWithError:error];
            [mDict setObject:errDict forKey:WA_LUA_PARAM_ERROR];
            [WALuaFuncIdManager execWithKey:[self sharedInstance].fbDeleteRequestWithRequestIdKey option:WALuaExecOptionFail result:mDict];
            
        }else{
            if (!succFuncId) {
                WALog(@"fbDeleteRequestWithRequestIdKey没有传成功回调函数")
            }
            
            [WALuaFuncIdManager execWithKey:[self sharedInstance].fbDeleteRequestWithRequestIdKey option:WALuaExecOptionSucc result:result];
        }
    }];
    
}

+(void)sendRequest:(NSDictionary*)dict{
    [self gameRequestWithDict:dict gameRequestOpt:WALuaGameRequestOptionAll];
}


+(void)createInviteRecord:(NSDictionary*)dict{
    NSString* platform = [dict objectForKey:WA_LUA_PARAM_PLATFORM];
    NSNumber* succFuncId = [dict objectForKey:WA_LUA_FUNC_SUCCESS];
    NSNumber* failFuncId = [dict objectForKey:WA_LUA_FUNC_FAILURE];
    NSString* resultStr = [dict objectForKey:WA_LUA_PARAM_RESULT];
    NSDictionary* results = [NSDictionary fromJSONString:resultStr];
    [WALuaFuncIdManager addObjWithKey:[self sharedInstance].createInviteInfoWithPlatformKey succFuncId:succFuncId failFuncId:failFuncId cancelFuncId:nil];
    
    [WASocialProxy createInviteInfoWithPlatform:platform results:results handler:^(NSUInteger code, NSString *msg, NSError *error) {
        if (error) {
            if (!failFuncId) {
                WALog(@"createInviteInfoWithPlatform没有传失败回调函数")
            }
            NSMutableDictionary* errDict = [NSMutableDictionary dictionaryWithDictionary:[WALuaUtil assembleInfoWithError:error]];
            if (code) {
                [errDict setObject:[NSNumber numberWithInteger:code] forKey:WA_LUA_PARAM_CODE];
            }
            if (msg) {
                [errDict setObject:msg forKey:WA_LUA_PARAM_MSG];
            }
            
            NSMutableDictionary* mDict = [NSMutableDictionary dictionary];
            
            if (platform) {
                [mDict setObject:platform forKey:WA_LUA_PARAM_PLATFORM];
            }
            
            [mDict setObject:errDict forKey:WA_LUA_PARAM_ERROR];
            
            [WALuaFuncIdManager execWithKey:[self sharedInstance].createInviteInfoWithPlatformKey option:WALuaExecOptionFail result:mDict];
            
        }else{
            if (!succFuncId) {
                WALog(@"createInviteInfoWithPlatform没有传成功回调函数")
            }
            
            [WALuaFuncIdManager execWithKey:[self sharedInstance].createInviteInfoWithPlatformKey option:WALuaExecOptionSucc result:@{@"success":@YES}];
        }
    }];
}

+(void)inviteInstallReward:(NSDictionary*)dict{
    NSString* platform = [dict objectForKey:WA_LUA_PARAM_PLATFORM];
    NSNumber* succFuncId = [dict objectForKey:WA_LUA_FUNC_SUCCESS];
    NSNumber* failFuncId = [dict objectForKey:WA_LUA_FUNC_FAILURE];
    NSString* tokenString = [dict objectForKey:WA_LUA_PARAM_TOKEN_STRING];
    [WALuaFuncIdManager addObjWithKey:[self sharedInstance].inviteInstallRewardPlatformKey succFuncId:succFuncId failFuncId:failFuncId cancelFuncId:nil];
    
    [WASocialProxy inviteInstallRewardPlatform:platform TokenString:tokenString handler:^(NSUInteger code, NSString *msg, NSError *error) {
        if (error) {
            if (!failFuncId) {
                WALog(@"inviteInstallRewardPlatform没有传失败回调函数")
            }
            NSMutableDictionary* errDict = [NSMutableDictionary dictionaryWithDictionary:[WALuaUtil assembleInfoWithError:error]];
            if (code) {
                [errDict setObject:[NSNumber numberWithInteger:code] forKey:WA_LUA_PARAM_CODE];
            }
            if (msg) {
                [errDict setObject:msg forKey:WA_LUA_PARAM_MSG];
            }
            
            NSMutableDictionary* mDict = [NSMutableDictionary dictionary];
            
            if (platform) {
                [mDict setObject:platform forKey:WA_LUA_PARAM_PLATFORM];
            }
            
            [mDict setObject:errDict forKey:WA_LUA_PARAM_ERROR];
            
            [WALuaFuncIdManager execWithKey:[self sharedInstance].inviteInstallRewardPlatformKey option:WALuaExecOptionFail result:mDict];
            
        }else{
            if (!succFuncId) {
                WALog(@"inviteInstallRewardPlatform没有传成功回调函数")
            }
            
            [WALuaFuncIdManager execWithKey:[self sharedInstance].inviteInstallRewardPlatformKey option:WALuaExecOptionSucc result:@{@"success":@YES}];
        }
    }];
    
}

+(void)inviteEventReward:(NSDictionary*)dict{
    NSString* platform = [dict objectForKey:WA_LUA_PARAM_PLATFORM];
    NSNumber* succFuncId = [dict objectForKey:WA_LUA_FUNC_SUCCESS];
    NSNumber* failFuncId = [dict objectForKey:WA_LUA_FUNC_FAILURE];
    NSString* eventName = [dict objectForKey:WA_LUA_PARAM_EVENT_NAME];
    [WALuaFuncIdManager addObjWithKey:[self sharedInstance].inviteEventRewardWithPlatformKey succFuncId:succFuncId failFuncId:failFuncId cancelFuncId:nil];
    
    [WASocialProxy inviteEventRewardWithPlatform:platform eventName:eventName handler:^(NSUInteger code, NSString *msg, NSError *error) {
        if (error) {
            if (!failFuncId) {
                WALog(@"inviteEventRewardWithPlatformKey没有传失败回调函数")
            }
            NSMutableDictionary* errDict = [NSMutableDictionary dictionaryWithDictionary:[WALuaUtil assembleInfoWithError:error]];
            if (code) {
                [errDict setObject:[NSNumber numberWithInteger:code] forKey:WA_LUA_PARAM_CODE];
            }
            if (msg) {
                [errDict setObject:msg forKey:WA_LUA_PARAM_MSG];
            }
            
            NSMutableDictionary* mDict = [NSMutableDictionary dictionary];
            
            if (platform) {
                [mDict setObject:platform forKey:WA_LUA_PARAM_PLATFORM];
            }
            
            [mDict setObject:errDict forKey:WA_LUA_PARAM_ERROR];
            
            [WALuaFuncIdManager execWithKey:[self sharedInstance].inviteEventRewardWithPlatformKey option:WALuaExecOptionFail result:mDict];
            
        }else{
            if (!succFuncId) {
                WALog(@"inviteEventRewardWithPlatformKey没有传成功回调函数")
            }
            
            [WALuaFuncIdManager execWithKey:[self sharedInstance].inviteEventRewardWithPlatformKey option:WALuaExecOptionSucc result:@{@"success":@YES}];
        }
    }];
    
}



@end
