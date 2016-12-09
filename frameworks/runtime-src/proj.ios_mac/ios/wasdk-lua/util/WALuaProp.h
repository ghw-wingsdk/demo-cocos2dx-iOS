//
//  WALuaProp.h
//  test
//
//  Created by wuyx on 16/9/12.
//  Copyright © 2016年 GHW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WALuaProp : NSObject
@property(nonatomic)BOOL isRoot;
@property(nonatomic,strong)NSString* propName;
@property(nonatomic,strong)NSObject* value;
@property(nonatomic)BOOL isArr;
@property(nonatomic,strong)NSMutableArray* sonIndexs;
@end
