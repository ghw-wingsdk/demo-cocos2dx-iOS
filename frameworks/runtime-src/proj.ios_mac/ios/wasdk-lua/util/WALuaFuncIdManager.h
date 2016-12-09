//
//  WALuaFuncIdManager.h
//  WACocos2dxLua
//
//  Created by wuyx on 16/9/9.
//
//

#import <Foundation/Foundation.h>
typedef enum WALuaExecOption{
    WALuaExecOptionSucc,
    WALuaExecOptionFail,
    WALuaExecOptionCancel
}WALuaExecOption;

typedef enum WALuaReleaseOption{
    WALuaReleaseOptionNone,
    WALuaReleaseOptionSingle,
    WALuaReleaseOptionAll
}WALuaReleaseOption;

@interface WALuaFuncIdManager : NSObject
+(WALuaFuncIdManager*)sharedInstance;
+(void)addObjWithKey:(NSString*)aKey succFuncId:(NSNumber*)succFuncId failFuncId:(NSNumber*)failFuncId cancelFuncId:(NSNumber*)cancelFuncId;
+(void)execWithKey:(NSString*)key option:(WALuaExecOption)option result:(NSObject*)result;
+(void)execWithKey:(NSString*)key option:(WALuaExecOption)option releaseOption:(WALuaReleaseOption)releaseOption result:(NSObject*)result;
+(NSNumber*)getObjWithKey:(NSString*)key option:(WALuaExecOption)option;
@end
