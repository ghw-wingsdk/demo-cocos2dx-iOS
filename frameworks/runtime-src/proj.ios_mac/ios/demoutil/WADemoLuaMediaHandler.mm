//
//  WADemoLuaMediaHandler.m
//  WACocos2dxLua
//
//  Created by wuyx on 16/9/30.
//
//

#import "WADemoLuaMediaHandler.h"
#import "WADemoLuaUtil.h"
#import "WALuaFuncIdManager.h"
#import "UIImagePickerController+WADemoLuaAutorotate.h"

static WADemoLuaMediaHandler* luaMediaHandlerSingleton;
@implementation WADemoLuaMediaHandler

+(WADemoLuaMediaHandler*)sharedInstance{
    if (!luaMediaHandlerSingleton) {
        luaMediaHandlerSingleton = [[WADemoLuaMediaHandler alloc]init];
    }
    
    return luaMediaHandlerSingleton;
}


+(void)presentViewController:(NSDictionary*)dict{
    
    
    NSString* mediaTypes = [dict objectForKey:@"mediaTypes"];//"public.image" "public.movie"
    
    NSNumber* succFuncId = [dict objectForKey:@"onSuccess"];
    
    NSNumber* cancelFuncId = [dict objectForKey:@"onCancel"];
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //资源类型为图片库
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.mediaTypes = [NSArray arrayWithObjects:mediaTypes, nil];
    picker.delegate = [self sharedInstance];
    
    [WALuaFuncIdManager addObjWithKey:@"presentViewController" succFuncId:succFuncId failFuncId:nil cancelFuncId:cancelFuncId];
    
    [[WADemoLuaUtil getCurrentVC] presentViewController:picker animated:YES completion:^{
    }];
}

- (BOOL)shouldAutorotate
{
    return NO;
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString* mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    if ([mediaType isEqualToString:@"public.image"]) {
        
        NSURL* imageURL = info[UIImagePickerControllerReferenceURL];
        
        [dict setObject:imageURL.description forKey:@"mediaURL"];
        
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
    if ([mediaType isEqualToString:@"public.movie"]) {
        NSURL* videoURL = [info objectForKey:UIImagePickerControllerReferenceURL];
        
        [dict setObject:videoURL.description forKey:@"mediaURL"];
        [picker dismissViewControllerAnimated:YES completion:nil];
        
    }
    
    
    [WALuaFuncIdManager execWithKey:@"presentViewController" option:WALuaExecOptionSucc result:dict];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [WALuaFuncIdManager execWithKey:@"presentViewController" option:WALuaExecOptionCancel result:@{@"onCancel":@YES}];
}

@end
