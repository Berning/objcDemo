//
//  BNLotterySQLite.m
//  Xcode8
//
//  Created by uBerning on 2017/3/16.
//  Copyright © 2017年 BN. All rights reserved.
//

#import "BNLotterySQLite.h"
#import <sqlite3.h>
#import "BNRecord.h"
static sqlite3 *_db;

@implementation BNLotterySQLite

//打开数据库，创一张表单
+(void)bnSQLiteInsertRecord:(BNRecord *)record success:(void(^)(NSString *))success failure:(void (^)(NSString *))failure
{
    
    // 获得数据库文件的路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filename = [doc stringByAppendingPathComponent:@"records.sqlite"];
    // 将OC字符串 转成 C语言字符串
    
    const char *cfilename = filename.UTF8String;
    
    
    // 1.打开数据库（如果数据库文件不存在，sqlite3_open函数会自动创建数据库文件）
    int result = sqlite3_open(cfilename, &_db);
    if (result == SQLITE_OK) { // 打开成功
        NSLog(@"1-数据库打开成功");
        
        // 2.创表  integer text blob
        const char *sql = "CREATE TABLE IF NOT EXISTS t_record (id integer PRIMARY KEY AUTOINCREMENT, num text NOT NULL, date text NOT NULL);";
        char *erroMsg = NULL;
        result = sqlite3_exec(_db, sql, NULL, NULL, &erroMsg);
        if (result == SQLITE_OK) {
            NSLog(@"2-创表成功");
            
            [self save:record success:^(NSString *successStr) {
                if (success) {
                    success(successStr);
                }
            } failure:^(NSString *failureStr) {
                if (failure) {
                    failure(failureStr);
                }
                
            }];
            
        } else {
            NSLog(@"创表失败--%s", erroMsg);
        }
    } else {
        NSLog(@"打开数据库失败");
    }
}

//向数据库的表单插入一条记录
+(void)save:(BNRecord *)record success:(void(^)(NSString *))success failure:(void (^)(NSString *))failure
{
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO t_record (num, date) VALUES ('%@', '%@');", record.seriesNum, record.date];

//    INSERT INTO t_person (name, age) VALUES ('wbn', 12);
    
    // 2.执行SQL语句
    char *erroMsg = NULL;
    int result=sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &erroMsg);
    if (result==SQLITE_OK) {
        if(success)success(@"加入成功");
        NSLog(@"插入数据成功");
    } else {
        if(failure)failure(@"加入失败");
        NSLog(@"插入数据失败");
    }
}

+(void)bnSQLiteRetrieveRecord:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *filename = [doc stringByAppendingPathComponent:@"records.sqlite"];
        // 将OC字符串 转成 C语言字符串
        const char *cfilename = filename.UTF8String;
        
        // 1.打开数据库（如果数据库文件不存在，sqlite3_open函数会自动创建数据库文件）
        int result = sqlite3_open(cfilename, &_db);
        if (result == SQLITE_OK) { // 打开成功
            NSLog(@"1-数据库打开成功");
            
            NSArray *records=[self sQuery:@" "];
            if (success)success(records);
        }
        else
        {
            NSError *error=[NSError errorWithDomain:@"数据库打开失败" code:499 userInfo:nil];
            if(failure)failure(error);

        }

}




//从数据库的表单中查询记录
+ (NSArray *)sQuery:(NSString *)condition
{
    // 存放所有的联系人
    NSMutableArray *records = nil;
    
//    "select id, name, age from t_student where name = ?;";
    
    NSString *sql = [NSString stringWithFormat:@"SELECT id, num, date FROM t_record WHERE num like '%%%@%%' ORDER BY date ASC;", condition];
    
    sqlite3_stmt *stmt = NULL;
    
    int result=sqlite3_prepare_v2(_db, sql.UTF8String, -1, &stmt, NULL);
    if ( result== SQLITE_OK) { // SQL语句没有问题
//        NSLog(@"查询语句没有问题");
        
        // 创建数组
         records = [NSMutableArray array];
//
//        // 每调一次sqlite3_step函数，stmt就会指向下一条记录
        while (sqlite3_step(stmt) == SQLITE_ROW) { // 找到一条记录
            // 取出数据
            
            // 取出第0列字段的值（int类型的值）
            int ID = sqlite3_column_int(stmt, 0);
            
            // 取出第1列字段的值（tex类型的值）
            const unsigned char *num = sqlite3_column_text(stmt, 1);
            
            // 取出第2列字段的值（int类型的值）
            const unsigned char *date =sqlite3_column_text(stmt, 2);
            
            // 创建JPPerson对象
            BNRecord *record = [[BNRecord alloc] init];
            record.ID = ID;
            record.seriesNum = [NSString stringWithUTF8String:(const char *)num];
            record.date =[NSString stringWithUTF8String:(const char *)date];
            [records addObject:record];
        }
    }
    
    else {
//        NSLog(@"查询语句有问题");
    }
    
    return records;
}

+(void)bnSQLiteDeleteRecord:(BNRecord *)record success :(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
//    DELETE FROM Person WHERE LastName = 'Wilson'
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM t_record WHERE date='%@'",record.date];

    char *erroMsg = NULL;
    int result=sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &erroMsg);
    if (result==SQLITE_OK) {
        
        [self bnSQLiteRetrieveRecord:^(NSArray *records) {
            if(success)success(records);
        } failure:^(NSError *error) {
            if(failure)failure(error);
        }];
        
        NSLog(@"删除数据成功");
    } else {
        NSError *error=[NSError errorWithDomain:@"删除数据失败" code:499 userInfo:nil];
        if(failure)failure(error);
    }
    
}

@end
