//
//  BNQuestionSQLite.h
//  Xcode8
//
//  Created by uBerning on 2017/3/16.
//  Copyright © 2017年 BN. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <UIKit/UIKit.h>

@class BNQuestion;

@interface BNQuestionSQLite : NSObject

//插入数据
+(void)sqliteInsertRecord:(BNQuestion *)record success:(void(^)(NSString *))success failure:(void (^)(NSString *))failure;

//检索数据
+(void)sqliteRetrieveRecord:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure;

//删除数据
+(void)sqliteDeleteRecord:(BNQuestion *)record success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure;

@end
