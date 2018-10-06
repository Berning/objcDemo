
//
//  BNCoreData.m
//  Xcode8
//
//  Created by uBerning on 2017/3/16.
//  Copyright © 2017年 BN. All rights reserved.
//

#define dPath  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#import "BNCoreData.h"
#import <CoreData/CoreData.h>
#import "BNEmployee.h"

static NSManagedObjectContext *_context;

@implementation BNCoreData

//+(void)load    早于 application--willFinishLaunchingWithOptions/ application--didFinishLaunchingWithOptions
//{
//    NSLog(@"load");
//}

//+(void)initialize  早于  application--applicationDidBecomeActive
//{
//    NSLog(@"initialize");
//}

+(void)test
{
    [self addEmployee];
    
    
    
}



+(void)initialize
{
    NSLog(@"initialize");
    
    //1.初始化上下文
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    //2.添加持久化存储

    //2.1模型文件 描述表结构的文件 也就是(Company.xcdatamodeld)这个文件
#warning 补充 ,如bundles传nil 会从主bundle加载所有的模型文件,把里面表结构都放在一个数据库文件
#warning to learn
    //code build
    NSEntityDescription *entity=[NSEntityDescription new];
    entity.name=@"BNEmployee";
//    [entity setValue:<#(nullable id)#> forKey:<#(nonnull NSString *)#>];
    NSMutableArray *entities=[NSMutableArray array];
    [entities addObject:entity];
    NSManagedObjectModel *companyModel = [NSManagedObjectModel new];
    companyModel.entities=entities;
    
    //2.2持久化存储调用器
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:companyModel];
    
    
    //数据库的完整文件路径
    NSString *sqlitePath = [dPath stringByAppendingPathComponent:@"company.sqlite"];
    
    //保存一个sqite文件的话,必要知道表结构和sqlite的文件路径
    //2.3 告诉coredate数据存储在一个sqlite文件
    NSError *error = nil;
    [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:sqlitePath] options:nil error:&error];
    
    if (error) {
        NSLog(@"%@",error);
    }
    
    context.persistentStoreCoordinator = psc;
    _context = context;

    NSLog(@"end");
}


#pragma mark --增加
+(void)addEmployee {
    
    //添加员工
    //1.创建一个员工对象
    //用coredata创建对象不能使用下面的方法
    //Employee *emp = [[Employee alloc] init];
    
    
    //注意，entityName 和插入类名相同
    BNEmployee *emp = [NSEntityDescription insertNewObjectForEntityForName:@"BNEmployee" inManagedObjectContext:_context];
    emp.name = @"wbn";
    emp.height = @"180";
    emp.createDate = [NSDate date];
    
    //保存员工信息
    
    NSError *error = nil;
    if (_context.hasChanges) {
        [_context save:&error];
    }

    if (error) {
            NSLog(@"CoreData insert data error:%@",error);
    }
}

#pragma mark  --删除员工信息
+ (void)deleteEmployee {
    //查找数据
    //1.创建请求对象,指定要查找的表
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    
    //2.时间排序
    NSSortDescriptor *dateSort = [NSSortDescriptor sortDescriptorWithKey:@"createDate" ascending:YES];//YES代表升序 NO 降序
    request.sortDescriptors = @[dateSort];
    
    
    //过滤条件 只想查找 zhangsan8
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name = %@",@"zhangsan8"];
    request.predicate = pre;
    
    
    //3.执行请求
    NSArray *allEmployee =  [_context executeFetchRequest:request error:nil];
    
    NSLog(@"%@",allEmployee);
    //删除zhangsan8的信息
    for (BNEmployee *emp in allEmployee) {
        [_context deleteObject:(NSManagedObject *)emp];
    }
    
}

#pragma mark --改员工信息
+ (void)updateEmployee {
    
    //查找数据
    //1.创建请求对象,指定要查找的表
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    
    //2.时间排序
    NSSortDescriptor *dateSort = [NSSortDescriptor sortDescriptorWithKey:@"createDate" ascending:YES];//YES代表升序 NO 降序
    request.sortDescriptors = @[dateSort];
    
    
    //过滤条件 只想查找 zhangsan8
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name = %@",@"zhangsan8"];
    request.predicate = pre;
    
    
    //3.执行请求
    NSArray *allEmployee =  [_context executeFetchRequest:request error:nil];
    
    NSLog(@"%@",allEmployee);
    //更新zhangsan8的身高为2米
    for (BNEmployee *emp in allEmployee) {
        emp.height = @"190";
    }
    
    //保存更改的信息
    [_context save:nil];
}

#pragma mark --查找员工信息
+(void)queryEmployee {
    
    //查找数据
    //1.创建请求对象,指定要查找的表
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    
    //2.时间排序
    NSSortDescriptor *dateSort = [NSSortDescriptor sortDescriptorWithKey:@"createDate" ascending:YES];//YES代表升序 NO 降序
    request.sortDescriptors = @[dateSort];
    
    
    //3.过滤条件 只想查找 zhangsan8
    //    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name = %@",@"zhangsan8"];
    //    request.predicate = pre;
    
    
    //分页语句 10 5条 (0 ,5) (5,10)
    //    request.fetchOffset = 5;
    //    request.fetchLimit = 5;
    
    //3.执行请求
    NSError *error = nil;
    NSArray *allEmployee =  [_context executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    
    //NSLog(@"%@",allEmployee);
    for (BNEmployee *emp in allEmployee) {
        NSLog(@"%@ %@ %@",emp.name,emp.height,emp.createDate);
    }
}



#pragma mark 复杂查询
+(void)complexibleQuery {
    //查找数据
    //1.创建请求对象,指定要查找的表
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    
    //2.时间排序
    NSSortDescriptor *dateSort = [NSSortDescriptor sortDescriptorWithKey:@"createDate" ascending:YES];//YES代表升序 NO 降序
    request.sortDescriptors = @[dateSort];
    
    
    //3.过滤条件 只想查找 zhangsan8
    //a 查找名为zhangsan 并且身高大于等1.9
    //NSPredicate *pre = [NSPredicate predicateWithFormat:@"name = %@ AND height >= %lf",@"zhangsan",1.30];
    
    //b.查找名字以zh开头 并且身高大于1.3
    //以什么BEGINSWITH
    //c代表不区分大小写
    //NSPredicate *pre = [NSPredicate predicateWithFormat:@"name BEGINSWITH[c] %@ AND height >= %lf",@"abc",1.30];
    
    //c.查找名字以san结尾 ,并用身高大于1.3
    //NSPredicate *pre = [NSPredicate predicateWithFormat:@"name ENDSWITH[c] %@ AND height >= %lf",@"cent",1.30];
    
    //4.模糊查询
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name like[c] %@",@"Li*"];
    
    request.predicate = pre;
    
    //4.执行请求
    NSError *error = nil;
    NSArray *allEmployee =  [_context executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    
    //NSLog(@"%@",allEmployee);
    for (BNEmployee *emp in allEmployee) {
        NSLog(@"%@ %@ %@",emp.name,emp.height,emp.createDate);
    }
}

@end
