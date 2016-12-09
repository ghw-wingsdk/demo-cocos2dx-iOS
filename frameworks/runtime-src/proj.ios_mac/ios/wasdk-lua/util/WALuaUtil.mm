//
//  WALuaUtil.m
//  WACocos2dxLua
//
//  Created by wuyx on 16/9/9.
//
//

#import "WALuaUtil.h"
//#import "WALuaProp.h"

@implementation WALuaUtil


//+(cocos2d::LuaValueDict)assembleInfoObj:(NSObject*)obj{
//    NSDictionary* dict = [self traversePropertyWithObj:obj];
//    
//    return [self assembleInfoWithObj:dict subDict:NULL key:nil isNew:YES isStart:YES];
////    return [self assembleInfoWithDict:dict];
//}
//
//+(cocos2d::LuaValueArray)assembleInfoWithArr:(NSArray*)arr{
//    cocos2d::LuaValueArray resultArr;
//    for (NSObject* obj in arr) {
//        cocos2d::LuaValueDict valueDict = [self assembleInfoObj:obj];
//        cocos2d::LuaValue luaValue = cocos2d::LuaValue::dictValue(valueDict);
//        resultArr.insert(resultArr.end(), luaValue);
//    }
//    return resultArr;
//}



//+(cocos2d::LuaValueDict)assembleInfoWithDict:(NSDictionary*)dict{
//    cocos2d::LuaValueDict table;
//    for (NSString *key in dict) {
//        if ([dict[key] isKindOfClass:[NSNumber class]]) {
//            NSNumber* numObj = dict[key];
//            table.insert(table.end(), cocos2d::LuaValueDict::value_type([key UTF8String], cocos2d::LuaValue::intValue(numObj.intValue)));
//        }else if([dict[key] isKindOfClass:[NSString class]]){
//            
//            
//            table.insert(table.end(),cocos2d::LuaValueDict::value_type([key UTF8String],cocos2d::LuaValue::stringValue([dict[key] UTF8String])));
//        }else if([dict[key] isKindOfClass:[NSArray class]]){
//            
//        }
//        
//    }
//    
//    return table;
//}

//+(cocos2d::LuaValueDict)assembleInfoWithDict:(NSDictionary*)dict isNew:(BOOL)isNew isStart:(BOOL)isStart  subTable:(cocos2d::LuaValueDict)subTable{
//    static cocos2d::LuaValueDict waLuaUtilTable;
//    if (isNew) {
//        delete &waLuaUtilTable;
//    }
//    
//    if (isStart) {
//        waLuaUtilTable = cocos2d::LuaValueDict();
//    }
//    
//    for (NSString *key in dict) {
//        if ([dict[key] isKindOfClass:[NSNumber class]]) {
//            NSNumber* numObj = dict[key];
//            waLuaUtilTable.insert(waLuaUtilTable.end(), cocos2d::LuaValueDict::value_type([key UTF8String], cocos2d::LuaValue::intValue(numObj.intValue)));
//        }else if([dict[key] isKindOfClass:[NSString class]]){
//            
//            
//            waLuaUtilTable.insert(waLuaUtilTable.end(),cocos2d::LuaValueDict::value_type([key UTF8String],cocos2d::LuaValue::stringValue([dict[key] UTF8String])));
//        }else if([dict[key] isKindOfClass:[NSArray class]]){
//            
//        }
//        
//    }
//    
//    return waLuaUtilTable;
//    
//}


//+(cocos2d::LuaValueDict)assembleInfoWithObj:(NSObject*)obj subDict:(cocos2d::LuaValueDict*)subDict key:(NSString*)key isNew:(BOOL)isNew isStart:(BOOL)isStart{
//    static cocos2d::LuaValueDict waLuaUtilTable;
////    if (isNew) {
////        if ((&waLuaUtilTable) != NULL) {
////            delete (&waLuaUtilTable);
////        }
////        
////    }
//    
//    
//    
//    if (isStart) {
//        waLuaUtilTable = cocos2d::LuaValueDict();
//    }
//    
//    if ([obj isKindOfClass:[NSDictionary class]]) {
//        
//        
//        NSDictionary* dict = (NSDictionary*)obj;
//        for (NSString *key in dict) {
//            
//            if ([key isEqualToString:@"payChannels"]) {
//                NSLog(@"dfdfdfdfd");
//            }
//            
//            if ([dict[key] isKindOfClass:[NSDictionary class]]) {
//                NSDictionary* dictObj = (NSDictionary*)dict[key];
//                cocos2d::LuaValueDict luaValueDict;
//                if (subDict) {
//                    (*subDict).insert((*subDict).end(), cocos2d::LuaValueDict::value_type([key UTF8String],cocos2d::LuaValue::dictValue(luaValueDict)));
//                    [self assembleInfoWithObj:dictObj subDict:&luaValueDict key:key isNew:NO isStart:NO];
//                }else{
//                    waLuaUtilTable.insert(waLuaUtilTable.end(), cocos2d::LuaValueDict::value_type([key UTF8String],cocos2d::LuaValue::dictValue(luaValueDict)));
//                    [self assembleInfoWithObj:dictObj subDict:&luaValueDict key:key isNew:NO isStart:NO];
//                }
//                
//            }else if([dict[key] isKindOfClass:[NSArray class]]){
//                NSArray* arrObj = (NSArray*)dict[key];
//                cocos2d::LuaValueArray waLuaValueArr;
//                for (NSObject* subObj in arrObj) {
//                    cocos2d::LuaValueDict luaValueDict;
//                    waLuaValueArr.insert(waLuaValueArr.end(), cocos2d::LuaValue::dictValue(luaValueDict));
//                    [self assembleInfoWithObj:subObj subDict:&luaValueDict key:key isNew:NO isStart:NO];
//                }
//            }else{
//                if (subDict) {
//                    [self assembleInfoWithObj:dict[key] subDict:subDict key:key isNew:NO isStart:NO];
//                }else{
//                    [self assembleInfoWithObj:dict[key] subDict:&waLuaUtilTable key:key isNew:NO isStart:NO];
//                }
//            }
//            
//        }
//    }else if([obj isKindOfClass:[NSString class]]){
//        NSString* objStr = (NSString*)obj;
//        if (subDict != NULL) {
//            (*subDict).insert((*subDict).end(), cocos2d::LuaValueDict::value_type([key UTF8String], cocos2d::LuaValue::stringValue([objStr UTF8String])));
//        }
//    }else if([obj isKindOfClass:[NSNumber class]]){
//        NSNumber* numObj = (NSNumber*)obj;
//        
//        if ((strcmp([numObj objCType], @encode(float)) == 0)||(strcmp([numObj objCType], @encode(double)) == 0)){
//            if (subDict != NULL) {
//                (*subDict).insert((*subDict).end(), cocos2d::LuaValueDict::value_type([key UTF8String], cocos2d::LuaValue::intValue(numObj.intValue)));
//            }
//        }else{
//            if (subDict != NULL) {
//                (*subDict).insert((*subDict).end(), cocos2d::LuaValueDict::value_type([key UTF8String], cocos2d::LuaValue::intValue(numObj.intValue)));
//            }
//        }
//    }
//    
//    
//    return waLuaUtilTable;
//}
//
//+(NSDictionary*)traversePropertyWithObj:(NSObject*)obj{
//    return [self traversePropertyWithObj:obj isNew:YES prop:nil mainDict:nil fromArr:NO];
//}
//
//+(NSDictionary*)traversePropertyWithObj:(NSObject*)obj isNew:(BOOL)isNew prop:(WALuaProp*)luaProp mainDict:(NSMutableDictionary*)mainDict fromArr:(BOOL)fromArr{
//    
//    static NSMutableDictionary* waTraversePropertyDict;
//    static NSMutableArray* waTraversePropertyArray;
//    
//    
//    if([luaProp.propName isEqualToString:@"payChannels"]){
//        NSLog(@"dfdfd");
//    }
////    if (isNew) {
////        if (waTraversePropertyDict.count) {
//////            [waTraversePropertyDict removeAllObjects];
////            waTraversePropertyDict = nil;
////        }
////        if (waTraversePropertyArray.count) {
//////            [waTraversePropertyArray removeAllObjects];
////            waTraversePropertyArray = nil;
////        }
////        
////    }
//    
//    if (!luaProp) {
//        waTraversePropertyDict = [NSMutableDictionary dictionary];
//        mainDict = waTraversePropertyDict;
//        waTraversePropertyArray = [self traversePropertyWithObj:obj isNew:YES isStart:YES propName:nil];
//        luaProp = waTraversePropertyArray.firstObject;
//    }
//    
//    
//    if (luaProp.isRoot) {
//        [luaProp.sonIndexs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            NSNumber* index = obj;
//            WALuaProp* sonProp = waTraversePropertyArray[index.integerValue];
//            [self traversePropertyWithObj:obj isNew:NO prop:sonProp mainDict:mainDict fromArr:NO];
//        }];
//    }else{
//        //末节点
//        if (!luaProp.isArr&&!luaProp.sonIndexs.count) {
//            [mainDict setObject:luaProp.value forKey:luaProp.propName];
//        }else{
//            if (luaProp.isArr) {
//                NSMutableArray* mArr = [NSMutableArray array];
//                [mainDict setObject:mArr forKey:luaProp.propName];
//                [luaProp.sonIndexs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                    NSNumber* index = obj;
//                    NSMutableDictionary* subDict = [NSMutableDictionary dictionary];
//                    [mArr addObject:subDict];
//                    WALuaProp* sonProp = waTraversePropertyArray[index.integerValue];
//                    [self traversePropertyWithObj:obj isNew:NO prop:sonProp mainDict:subDict fromArr:YES];
//                    
//                }];
//            }else{
//                if (fromArr) {
//                    [luaProp.sonIndexs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                        NSNumber* index = obj;
//                        WALuaProp* sonProp = waTraversePropertyArray[index.integerValue];
//                        [self traversePropertyWithObj:obj isNew:NO prop:sonProp mainDict:mainDict fromArr:NO];
//                    }];
//                }else{
//                    NSMutableDictionary* mDict = [NSMutableDictionary dictionary];
//                    [mainDict setObject:mDict forKey:luaProp.propName];
//                    [luaProp.sonIndexs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                        NSNumber* index = obj;
//                        WALuaProp* sonProp = waTraversePropertyArray[index.integerValue];
//                        NSMutableDictionary* subDict = [NSMutableDictionary dictionary];
//                        [mDict setObject:subDict forKey:sonProp.propName];
//                        [self traversePropertyWithObj:obj isNew:NO prop:sonProp mainDict:mDict fromArr:NO];
//                    }];
//                }
//                
//            }
//        }
//        
//    }
//    
//    return waTraversePropertyDict;
//    
//    
//}
//
//
//+(NSMutableArray*)traversePropertyWithObj:(NSObject*)obj isNew:(BOOL)isNew isStart:(BOOL)isStart propName:(NSString*)propName{
//    static NSMutableArray* waTraverseObjPropArr;
////    if (isNew&&waTraverseObjPropArr.count) {
////        [waTraverseObjPropArr removeAllObjects];
////        waTraverseObjPropArr = nil;
////    }
//    
//    WALuaProp* luaProp = [[WALuaProp alloc]init];
//    luaProp.sonIndexs = [NSMutableArray array];
//    luaProp.propName = propName;
//    luaProp.isArr = NO;
//    
//    if (isStart) {
//        waTraverseObjPropArr = [NSMutableArray array];
//    }
//    if ([obj isKindOfClass:[NSString class]]||[obj isKindOfClass:[NSNumber class]]) {
//        luaProp.value = obj;
//        [waTraverseObjPropArr addObject:luaProp];
//    }else if([obj isKindOfClass:[NSData class]]){
//        NSString* dataString = [[NSString alloc]initWithData:(NSData*)obj encoding:NSUTF8StringEncoding];
//        luaProp.value = dataString;
//        [waTraverseObjPropArr addObject:luaProp];
//    }else if (obj&&[obj isKindOfClass:[NSArray class]]) {
//        
//        if (propName) {
//            NSArray* arrObj = (NSArray*)obj;
//            luaProp.propName = propName;
//            luaProp.isArr = YES;
//            [waTraverseObjPropArr addObject:luaProp];
//            [arrObj enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                [luaProp.sonIndexs addObject:[NSNumber numberWithInteger:waTraverseObjPropArr.count]];
//                [self traversePropertyWithObj:obj isNew:NO isStart:NO propName:[NSString stringWithFormat:@"arrObj%d",(int)idx]];
//            }];
//        }
//        
//    }else if([obj isKindOfClass:[NSDictionary class]]){
//        
//        if (propName) {
//            NSDictionary* dictObj = (NSDictionary*)obj;
//            luaProp.propName = propName;
//            [waTraverseObjPropArr addObject:luaProp];
//            [dictObj enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//                [luaProp.sonIndexs addObject:[NSNumber numberWithInteger:waTraverseObjPropArr.count]];
//                [self traversePropertyWithObj:obj isNew:NO isStart:NO propName:key];
//            }];
//        }
//        
//    }else{
//        unsigned int outCount, i;
//        objc_property_t *properties = class_copyPropertyList([obj class], &outCount);
//        
//        WALuaProp* rootPropOut = [[WALuaProp alloc]init];
//        rootPropOut.isRoot = YES;
//        rootPropOut.sonIndexs = [NSMutableArray array];
//        if (isStart) {
//            [waTraverseObjPropArr addObject:rootPropOut];
//        }
//        
//        WALuaProp* luaPropOut = [[WALuaProp alloc]init];
//        luaPropOut.sonIndexs = [NSMutableArray array];
//        if (propName) {
//            luaPropOut.propName = propName;
//            [waTraverseObjPropArr addObject:luaPropOut];
//        }
//        
//        for (i = 0; i<outCount; i++)
//        {
//            objc_property_t property = properties[i];
//            const char* char_f =property_getName(property);
//            NSString *propertyName = [NSString stringWithUTF8String:char_f];
//            id propertyValue = [obj valueForKey:(NSString *)propertyName];
//            NSString* className =[NSString stringWithUTF8String:object_getClassName(propertyValue)] ;
//            
//            if (propertyValue) {
//                
//                NSObject* propObj = (NSObject*)propertyValue;
//                if (propObj&&([propObj isKindOfClass:[NSArray class]]||[propObj isKindOfClass:[NSDictionary class]])) {
//                    if (isStart) {
//                        [rootPropOut.sonIndexs addObject:[NSNumber numberWithInteger:waTraverseObjPropArr.count]];
//                    }
//                    [luaPropOut.sonIndexs addObject:[NSNumber numberWithInteger:waTraverseObjPropArr.count]];
//                    [self traversePropertyWithObj:propObj isNew:NO isStart:NO propName:propertyName];
//                }else{
//                    if (![[className substringWithRange:NSMakeRange(0, 4)]isEqualToString:@"__NS"]&&![[className substringWithRange:NSMakeRange(0, 2)]isEqualToString:@"NS"]) {
//                        if (isStart) {
//                            [rootPropOut.sonIndexs addObject:[NSNumber numberWithInteger:waTraverseObjPropArr.count]];
//                        }
//                        [luaPropOut.sonIndexs addObject:[NSNumber numberWithInteger:waTraverseObjPropArr.count]];
//                        [self traversePropertyWithObj:propObj isNew:NO isStart:NO propName:propertyName];
//                    }else{
//                        if (isStart) {
//                            [rootPropOut.sonIndexs addObject:[NSNumber numberWithInteger:waTraverseObjPropArr.count]];
//                        }
//                        [luaPropOut.sonIndexs addObject:[NSNumber numberWithInteger:waTraverseObjPropArr.count]];
//                        WALuaProp* luaProp = [[WALuaProp alloc]init];
//                        luaProp.propName = propertyName;
//                        if ([propObj isKindOfClass:[NSData class]]) {
//                            NSData* dataProp = (NSData*)propObj;
//                            NSString* dataStr = [[NSString alloc]initWithData:dataProp encoding:NSUTF8StringEncoding];
//                            luaProp.value = dataStr;
//                            
//                            
//                        }else if([propObj isKindOfClass:[NSNumber class]]){
//                            NSNumber* numProp = (NSNumber*)propObj;
//                            
//                            if (strcmp([numProp objCType], @encode(float)) == 0){
//                                luaProp.value = [NSString stringWithFormat:@"%f",numProp.floatValue];
//                            }
//                            else if (strcmp([numProp objCType], @encode(double)) == 0){
//                                luaProp.value = [NSString stringWithFormat:@"%f",numProp.doubleValue];
//                            }
//                            else if (strcmp([numProp objCType], @encode(int)) == 0){
//                                luaProp.value = [NSString stringWithFormat:@"%d",numProp.intValue];
//                            }else {
//                                luaProp.value = [NSString stringWithFormat:@"%d",numProp.intValue];
//                            }
//                            
//                            
//                        }else if ([propObj isKindOfClass:[NSString class]]){
//                            luaProp.value = propObj;
//                        }
//                        
//                        [waTraverseObjPropArr addObject:luaProp];
//                    }
//                }
//                
//            }
//            
//        }
//        free(properties);
//    }
//    
//    
//    return waTraverseObjPropArr;
//}


+(NSDictionary*)assembleInfoWithError:(NSError*)error{
    return @{@"code":[NSNumber numberWithInteger:error.code],@"userInfo":error.userInfo.description,@"domain":error.domain};
}

@end
