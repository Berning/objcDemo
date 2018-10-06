//
//  BNSQLite.m
//  Xcode8
//
//  Created by uBerning on 2017/3/16.
//  Copyright © 2017年 BN. All rights reserved.
//

#import "BNSQLite.h"
#import <sqlite3.h>
#import "BNPerson.h"

static sqlite3 *_db;

@implementation BNSQLite

//打开数据库，创一张表单
+(void)executeSQLite
{
    BNPerson *person=[BNPerson person];
    person.name=@"wang";
    person.age=12;
    
    // 获得数据库文件的路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filename = [doc stringByAppendingPathComponent:@"persons.sqlite"];
    // 将OC字符串 转成 C语言字符串
    
    const char *cfilename = filename.UTF8String;
    
    
    // 1.打开数据库（如果数据库文件不存在，sqlite3_open函数会自动创建数据库文件）
    int result = sqlite3_open(cfilename, &_db);
    if (result == SQLITE_OK) { // 打开成功
        NSLog(@"1-数据库打开成功");
        
        // 2.创表  integer text blob
        const char *sql = "CREATE TABLE IF NOT EXISTS t_person (id integer PRIMARY KEY AUTOINCREMENT,name text NOT NULL, age integer NOT NULL);";
        char *erroMsg = NULL;
        result = sqlite3_exec(_db, sql, NULL, NULL, &erroMsg);
        if (result == SQLITE_OK) {
            NSLog(@"2-创表成功");
            
            [self save:person];
            
        } else {
            NSLog(@"创表失败--%s", erroMsg);
        }
    } else {
        NSLog(@"打开数据库失败");
    }
}

//向数据库的表单插入一条记录
+(void)save:(BNPerson *)person
{
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO t_person (name, age) VALUES ('%@', %d);", person.name, person.age];

//    INSERT INTO t_person (name, age) VALUES ('wbn', 12);
    
    // 2.执行SQL语句
    char *erroMsg = NULL;
    int result=sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &erroMsg);
    if (result==SQLITE_OK) {
        NSLog(@"插入数据成功");
        NSArray *persons=[self query:@"w"];
        int i=1;
        for (BNPerson *p in persons) {
            NSLog(@"record:{第%d条:%@,%d}\n",i,p.name,p.age);
            i++;
        }
    } else {
    }

}

//从数据库的表单中查询记录
+ (NSArray *)query:(NSString *)condition
{
    // 存放所有的联系人
    NSMutableArray *persons = nil;
    
//    "select id, name, age from t_student where name = ?;";
    
    NSString *sql = [NSString stringWithFormat:@"SELECT id, name, age FROM t_person WHERE name like '%%%@%%' ORDER BY age ASC;", condition];
    
    sqlite3_stmt *stmt = NULL;
    
    int result=sqlite3_prepare_v2(_db, sql.UTF8String, -1, &stmt, NULL);
    if ( result== SQLITE_OK) { // SQL语句没有问题
        NSLog(@"查询语句没有问题");
        
        // 创建数组
         persons = [NSMutableArray array];
//
//        // 每调一次sqlite3_step函数，stmt就会指向下一条记录
        while (sqlite3_step(stmt) == SQLITE_ROW) { // 找到一条记录
            // 取出数据
            
            // 取出第0列字段的值（int类型的值）
            int ID = sqlite3_column_int(stmt, 0);
            
            // 取出第1列字段的值（tex类型的值）
            const unsigned char *name = sqlite3_column_text(stmt, 1);
            
            // 取出第2列字段的值（int类型的值）
            int age = sqlite3_column_int(stmt, 2);
            
            // 创建JPPerson对象
            BNPerson *p = [[BNPerson alloc] init];
            p.ID = ID;
            p.name = [NSString stringWithUTF8String:(const char *)name];
            p.age = age;
            [persons addObject:p];
        }
    }
    
    else {
        NSLog(@"查询语句有问题");
    }
    
    return persons;



}


+(void)update
{
    
}

+(void)delete
{
    
}




@end
