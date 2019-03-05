//
//  BNQuestionSQLite.m
//  Xcode8
//
//  Created by uBerning on 2017/3/16.
//  Copyright © 2017年 BN. All rights reserved.
//

#define cfilename [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"questions.sqlite"].UTF8String


#import "BNQuestionSQLite.h"
#import <sqlite3.h>
#import "BNQuestion.h"
static sqlite3 *_db;

@implementation BNQuestionSQLite

//打开数据库，创一张表单
+(void)sqliteInsertRecord:(BNQuestion *)record success:(void(^)(NSString *))success failure:(void (^)(NSString *))failure
{
    // 1.打开数据库（如果数据库文件不存在，sqlite3_open函数会自动创建数据库文件）
    int result = sqlite3_open(cfilename, &_db);
    if (result == SQLITE_OK)
    { // 打开成功
        
        // 2.创表  integer text blob
        const char *sql = "CREATE TABLE IF NOT EXISTS t_record (id integer PRIMARY KEY AUTOINCREMENT, question text NOT NULL,date text NOT NULL);";
        char *erroMsg = NULL;
        result = sqlite3_exec(_db, sql, NULL, NULL, &erroMsg);
        if (result == SQLITE_OK)
        {
            
            [self save:record success:^(NSString *successStr) {
                if (success) {
                    success(successStr);
                }
            } failure:^(NSString *failureStr) {
                if (failure) {
                    failure(failureStr);
                }
                
            }];
            
        }
        else
        {
        }
    } else
    {
        NSLog(@"打开数据库失败");
    }
}

//向数据库的表单插入一条记录
+(void)save:(BNQuestion *)record success:(void(^)(NSString *))success failure:(void (^)(NSString *))failure
{
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO t_record (question,date) VALUES ('%@','%@');", record.question,record.date];

//    INSERT INTO t_person (name, age) VALUES ('wbn', 12);
    
    // 2.执行SQL语句
    char *erroMsg = NULL;
    int result=sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &erroMsg);
    if (result==SQLITE_OK) {
        if(success)success(@"加入成功");
    } else {
        if(failure)failure(@"加入失败");
    }
}

+(void)sqliteRetrieveRecord:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
        // 1.打开数据库（如果数据库文件不存在，sqlite3_open函数会自动创建数据库文件）
        int result = sqlite3_open(cfilename, &_db);
        if (result == SQLITE_OK) { // 打开成功

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
    
//    NSString *sql = [NSString stringWithFormat:@"SELECT id, question, date FROM t_record WHERE num like '%%%@%%' ORDER BY date ASC;", condition];
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM t_record ORDER BY date ASC"];

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
            
            int ID=sqlite3_column_int(stmt, 0);

            const unsigned char *question = sqlite3_column_text(stmt, 1);
            
            const unsigned char *date = sqlite3_column_text(stmt, 2);

            // 创建JPPerson对象
            BNQuestion *aQuestion = [[BNQuestion alloc] init];
            aQuestion.ID = ID;
            aQuestion.question=[NSString stringWithFormat:@"%s",question];
            aQuestion.date=[NSString stringWithFormat:@"%s",date];
            [records addObject:aQuestion];
        }
    }
    
    else {
//        NSLog(@"查询语句有问题");
    }
    
    return records;
}

+(void)sqliteDeleteRecord:(BNQuestion *)record success :(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
//    DELETE FROM Person WHERE LastName = 'Wilson'
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM t_record WHERE ID='%ld'",record.ID];

    char *erroMsg = NULL;
    int result=sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &erroMsg);
    if (result==SQLITE_OK) {
        
        [self sqliteRetrieveRecord:^(NSArray *records) {
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
