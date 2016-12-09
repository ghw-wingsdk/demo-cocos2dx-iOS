//
//  WADemoLuaAlertViewAdapter.m
//  WACocos2dxLua
//
//  Created by wuyx on 16/9/27.
//
//

#import "WADemoLuaAlertViewAdapter.h"
#import "WALuaFuncIdManager.h"
@implementation WADemoLuaAlertViewAdapter
+(void)show:(NSDictionary*)dict{
    
    NSString* title = [dict objectForKey:@"title"];
    NSString* message = [dict objectForKey:@"message"];
    NSString* cancelButtonTitle = [dict objectForKey:@"cancelButtonTitle"];
    NSString* otherButtonTitle = [dict objectForKey:@"otherButtonTitle"];
    NSNumber* cancelFunc = [dict objectForKey:@"cancelFunc"];
    NSNumber* otherFunc = [dict objectForKey:@"otherFunc"];
    
    
    [WALuaFuncIdManager addObjWithKey:@"WADemoLuaAlertViewAdapter" succFuncId:otherFunc failFuncId:nil cancelFuncId:cancelFunc];
    WADemoLuaAlertView* alert = [[WADemoLuaAlertView alloc]initWithTitle:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitle block:^(WADemoLuaAlertViewClicked click) {
        if (click == WADemoLuaAlertViewClickedButtonCancel) {
            [WALuaFuncIdManager execWithKey:@"WADemoLuaAlertViewAdapter" option:WALuaExecOptionCancel result:@{@"cancel":@YES}];
        }else{
            [WALuaFuncIdManager execWithKey:@"WADemoLuaAlertViewAdapter" option:WALuaExecOptionSucc result:@{@"success":@YES}];
        }
        
    }];
    [alert show];
}
@end
