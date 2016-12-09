WASocialProxy = {}

function WASocialProxy.share(platform,shareContent,shareWithApi,extInfo,callback)
	local param = {platform = platform ,shareContent = shareContent , shareWithApi = shareWithApi ,extInfo = extInfo ,callback = callback}
	luaoc.callStaticMethod("WALuaSocialProxy","share",param)
end


function WASocialProxy.appInvite(platform, appLinkUrl, previewImageUrl, callback)
	local param = {platform = platform ,appLinkUrl = appLinkUrl , previewImageUrl = previewImageUrl ,callback = callback}
	luaoc.callStaticMethod("WALuaSocialProxy","appInvite",param)
end

function WASocialProxy.queryInvitableFriends(platform, duration, callback)
	local param = {platform = platform ,duration = duration , callback = callback}
	luaoc.callStaticMethod("WALuaSocialProxy","queryInvitableFriends",param)
end

function WASocialProxy.gameInvite(platform, title, message, ids, callback)
	local param = {platform = platform ,title = title , message = message ,ids,callback = callback}
	luaoc.callStaticMethod("WALuaSocialProxy","gameInvite",param)
end

function WASocialProxy.createInviteRecord(platform, result,callback)
	local param = {platform = platform ,result = result , callback = callback}
	luaoc.callStaticMethod("WALuaSocialProxy","createInviteRecord",param)
end

function WASocialProxy.inviteInstallReward(platform,token,callback)
	local param = {platform = platform ,token = token , callback = callback}
	luaoc.callStaticMethod("WALuaSocialProxy","inviteInstallReward",param)
end

function WASocialProxy.inviteEventReward(platform, eventName, callback)
	local param = {platform = platform ,eventName = eventName , callback = callback}
	luaoc.callStaticMethod("WALuaSocialProxy","inviteEventReward",param)
end


function WASocialProxy.queryFriends(platform,callback)
	local param = {platform = platform ,callback = callback}
	luaoc.callStaticMethod("WALuaSocialProxy","queryFriends",param)
end

function WASocialProxy.queryFBGraphObjects(objectType,callback)
	local param = {objectType = objectType ,callback = callback}
	luaoc.callStaticMethod("WALuaSocialProxy","queryFBGraphObjects",param)
end

function WASocialProxy.fbSendGift(title, message, objectId, receipts,callback)
	local param = {title = title ,message = message,objectId = objectId, receipts = receipts ,callback = callback}
	luaoc.callStaticMethod("WALuaSocialProxy","fbSendGift",param)
end

function WASocialProxy.fbAskForGift(title,message,objectId, receipts, callback)
	local param = {title = title ,message = message,objectId = objectId,receipts = receipts,callback = callback}
	luaoc.callStaticMethod("WALuaSocialProxy","fbSendGift",param)
end


function WASocialProxy.fbQueryReceivedGifts(callback)
	local param = {callback = callback}
	luaoc.callStaticMethod("WALuaSocialProxy","fbQueryReceivedGifts",param)
end

function WASocialProxy.fbQueryAskForGiftRequests(callback)
	local param = {callback = callback}
	luaoc.callStaticMethod("WALuaSocialProxy","fbQueryAskForGiftRequests",param)
end

function WASocialProxy.fbDeleteRequest(requestId, callback)
	local param = {requestId = requestId , callback = callback}
	luaoc.callStaticMethod("WALuaSocialProxy","fbDeleteRequest",param)
end


function WASocialProxy.getGroupByGid(platform, gids, extInfo,callback)
	local param = {platform = platform , gids = gids ,extInfo = extInfo ,callback = callback}
	luaoc.callStaticMethod("WALuaSocialProxy","getGroupByGid",param)
end

function WASocialProxy.getCurrentAppLinkedGroup(platform,extInfo,callback)
	local param = {platform = platform , extInfo = extInfo ,callback = callback}
	luaoc.callStaticMethod("WALuaSocialProxy","getCurrentAppLinkedGroup",param)
end


function WASocialProxy.getCurrentUserGroup(platform,  extInfo,callback)
	local param = {platform = platform , extInfo = extInfo ,callback = callback}
	luaoc.callStaticMethod("WALuaSocialProxy","getCurrentUserGroup",param)
end

function WASocialProxy.getGroups(platform,extInfo, callback)
	local param = {platform = platform , extInfo = extInfo ,callback = callback}
	luaoc.callStaticMethod("WALuaSocialProxy","getGroups",param)
end

function WASocialProxy.joinGroup(platform, groupId,extInfo,callback)
	local param = {platform = platform ,groupId = groupId, extInfo = extInfo ,callback = callback}
	luaoc.callStaticMethod("WALuaSocialProxy","joinGroup",param)
end

function WASocialProxy.openGroupPage(platform, groupUri, extInfo)
	local param = {platform = platform ,groupUri = groupUri, extInfo = extInfo}
	luaoc.callStaticMethod("WALuaSocialProxy","openGroupPage",param)
end

function WASocialProxy.sendRequest(platform, requestType, title, message, objectId, receiptIds, extInfo,callback)
	local param = {platform = platform , requestType = requestType , title = title ,message = message ,objectId = objectId ,receiptIds = receiptIds , extInfo = extInfo ,callback = callback}
	luaoc.callStaticMethod("WALuaSocialProxy","sendRequest",param)
end







