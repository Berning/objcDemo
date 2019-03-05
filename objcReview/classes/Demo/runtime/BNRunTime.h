//
//  BNRunTime.h
//  Xcode8
//
//  Created by uBerning on 2017/3/16.
//  Copyright © 2017年 BN. All rights reserved.
//
//clang -rewrite-objc xxx.m

#import <Foundation/Foundation.h>

@interface BNRunTime : NSObject

+(void)rtRunTimeExecute;

//方法交换
+(void)rtMethodSwizzling;

//添加属性
+(void)rtAddProperty;

//get
+(void)rtEnumarateClassIvars;
+(void)rtEnumarateClassProperties;
+(void)rtEnumarateClassMethods;
+(void)rtEnumarateClassProtocols;

//apply
+(void)rtKeyValuesTest;

//消息转发
+(void)rtMethodForwardingTest;

@end
