//
//  WALuaUtil.h
//  WACocos2dxLua
//
//  Created by wuyx on 16/9/9.
//
//

#import <Foundation/Foundation.h>
//#import "cocos2d.h"
//#include "CCLuaEngine.h"
//#include "CCLuaBridge.h"
//#import <objc/runtime.h>
@interface WALuaUtil : NSObject
//+(cocos2d::LuaValueDict)assembleInfoObj:(NSObject*)obj;
//
//+(cocos2d::LuaValueArray)assembleInfoWithArr:(NSArray*)arr;
//
//+(cocos2d::LuaValueDict)assembleInfoWithObj:(NSObject*)obj subDict:(cocos2d::LuaValueDict*)subDict key:(NSString*)key isNew:(BOOL)isNew isStart:(BOOL)isStart;

+(NSDictionary*)assembleInfoWithError:(NSError*)error;

@end
