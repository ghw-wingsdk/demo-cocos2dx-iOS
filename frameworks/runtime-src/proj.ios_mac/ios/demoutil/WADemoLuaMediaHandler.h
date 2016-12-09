//
//  WADemoLuaMediaHandler.h
//  WACocos2dxLua
//
//  Created by wuyx on 16/9/30.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface WADemoLuaMediaHandler : NSObject<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
+(void)presentViewController:(NSDictionary*)dict;
@end
