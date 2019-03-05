//
//  BNLotterySQLite.h
//  Xcode8
//
//  Created by uBerning on 2017/3/16.
//  Copyright © 2017年 BN. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <UIKit/UIKit.h>

@class BNRecord;

@interface BNLotterySQLite : NSObject

//1.打开数据库，2.创表
+(void)bnSQLiteInsertRecord:(BNRecord *)record success:(void(^)(NSString *))success failure:(void (^)(NSString *))failure;
+(void)bnSQLiteRetrieveRecord:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure;

+(void)bnSQLiteDeleteRecord:(BNRecord *)record success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure;

@end
