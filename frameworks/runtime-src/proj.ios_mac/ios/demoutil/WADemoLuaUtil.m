//
//  WADemoLuaUtil.m
//  WACocos2dxLua
//
//  Created by wuyx on 16/9/30.
//
//

#import "WADemoLuaUtil.h"

@implementation WADemoLuaUtil

+(UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow* window = (UIWindow*)[[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow* tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

@end
