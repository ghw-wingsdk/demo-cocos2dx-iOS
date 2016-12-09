//
//  WALuaTrackProxy.m
//  WACocos2dxLua
//
//  Created by wuyx on 16/9/8.
//
//

#import "WALuaTrackProxy.h"
#import "WALuaConstants.h"
#import "NSObject+BWJSONMatcher.h"
@implementation WALuaTrackProxy
+(void)trackEvent:(NSDictionary*)dict{
    
    NSString* jsonString = [dict objectForKey:@"param"];
    
    NSDictionary* paramDict = [NSDictionary fromJSONString:jsonString];
    
    if ([paramDict isKindOfClass:[NSDictionary class]]) {
        NSString* eventName = [paramDict objectForKey:WA_LUA_PARAM_EVENT_NAME];
        NSNumber* valueNum = [paramDict objectForKey:WA_LUA_PARAM_VALUE];
        NSDictionary* param = [paramDict objectForKey:WA_LUA_PARAM_EVENT_PARAM];
        if (!eventName) {
            WALog("发送事件eventName不能为空")
            return;
        }
        
        double value;
        if (!valueNum) {
            value = 0;
        }else{
            value = valueNum.doubleValue;
        }
        
        [WATrackProxy trackWithEventName:eventName valueToSum:value params:param];
    }else{
        WALog(@"数据收集传递过来的参数不是json字符串")
    }
    
    
}

+(void)trackEventExt:(NSDictionary*)dict{
    
    NSString* jsonString = [dict objectForKey:@"param"];
    
    NSDictionary* paramDict = [NSDictionary fromJSONString:jsonString];
    
    if ([paramDict isKindOfClass:[NSDictionary class]]) {
        NSString* defaultEventName = [paramDict objectForKey:WA_LUA_PARAM_DEFAULT_EVENT_NAME];
        NSNumber* defaultValue = [paramDict objectForKey:WA_LUA_PARAM_DEFAULT_VALUE];
        NSDictionary* defaultParamValues = [paramDict objectForKey:WA_LUA_PARAM_DEFAULT_PARAM_VALUES];
        NSDictionary* channelSwitcherDict = [paramDict objectForKey:WA_LUA_PARAM_CHANNEL_SWITCHER_DICT];
        NSDictionary* eventNameDict = [paramDict objectForKey:WA_LUA_PARAM_EVENT_NAME_DICT];
        NSDictionary* valueDict = [paramDict objectForKey:WA_LUA_PARAM_VALUE_DICT];
        NSDictionary* paramValuesDict = [paramDict objectForKey:WA_LUA_PARAM_PARAM_VALUES_DICT];
        
        WAEvent* event = [[WAEvent alloc]init];
        if (defaultEventName) {
            event.defaultEventName = defaultEventName;
        }
        if (defaultValue) {
            event.defaultValue = defaultValue.doubleValue;
        }
        if (defaultParamValues) {
            event.defaultParamValues = defaultParamValues;
        }
        
        if (channelSwitcherDict) {
            event.channelSwitcherDict = channelSwitcherDict;
        }
        if (eventNameDict) {
            event.eventNameDict = eventNameDict;
        }
        if (valueDict) {
            event.valueDict = valueDict;
        }
        
        if (paramValuesDict) {
            event.paramValuesDict = paramValuesDict;
        }
        
        [event trackEvent];
    }else{
        WALog(@"数据收集传递过来的参数不是json字符串")
    }
    
    
}

+(void)autoTriggerAfterPayment:(NSDictionary *)dict{
    NSNumber* autoTrigger = [dict objectForKey:WA_LUA_PARAM_AUTO_TRIGGER_AFTER_PAYMENT];
    if (autoTrigger) {
        [WATrackProxy autoTriggerAfterPayment:autoTrigger.boolValue];
    }
}
@end
