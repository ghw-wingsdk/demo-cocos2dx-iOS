//
//  WALuaCoreProxy.m
//  WACocos2dxLua
//
//  Created by wuyx on 16/9/8.
//
//

#import "WALuaCoreProxy.h"
#import "WALuaConstants.h"
@implementation WALuaCoreProxy

+(void)init{
    [WACoreProxy init];
}

+(void)initAppEventTracker{
    [WACoreProxy initAppEventTracker];
}

+(NSNumber*)isDebugMode{
    BOOL isDebug = [WACoreProxy isDebugMode];
    return [NSNumber numberWithBool:isDebug];
}

+(void)setDebugMode:(NSDictionary*)dict{
    NSNumber* debugMode = [dict objectForKey:WA_LUA_PARAM_DEBUG_MODE];
    if (debugMode) {
        [WACoreProxy setDebugMode:debugMode.boolValue];
    }
}

+(NSString*)getUserId{
    return [WACoreProxy getUserId];
}

+(void)setServerId:(NSDictionary *)dict{
    NSString* serverId = [dict objectForKey:WA_LUA_PARAM_SERVER_ID];
    [WACoreProxy setServerId:serverId];
}


+(NSString*)getServerId{
    return [WACoreProxy getServerId];
}

+(void)setLevel:(NSDictionary*)dict{
    NSNumber* level = [dict objectForKey:WA_LUA_PARAM_LEVEL];
    if (level) {
        [WACoreProxy setLevel:level.intValue];
    }
}

+(NSNumber*)getLevel{
    int level = [WACoreProxy getLevel];
    return [NSNumber numberWithInt:level];
}

+(void)setGameUserId:(NSDictionary*)dict{
    NSString* gameUserId = [dict objectForKey:WA_LUA_PARAM_GAME_USER_ID];
    [WACoreProxy setGameUserId:gameUserId];
}

+(NSString*)getGameUserId{
    return [WACoreProxy getGameUserId];
}

@end
