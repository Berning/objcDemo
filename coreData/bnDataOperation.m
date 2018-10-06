//
//  bnDataOperation.m
//  coreDataTest
//
//  Created by Berning on 2018/10/6.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "bnDataOperation.h"
#import <CoreData/CoreData.h>
#import "Employee+CoreDataClass.h"


static NSManagedObjectContext * _context;

#define dPath  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

@implementation bnDataOperation

+(void)initialize
{
    NSLog(@"MOC initialize");
    
    //1.初始化上下文
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    //2.添加持久化存储
    
    //2.1模型文件 描述表结构的文件 也就是(Company.xcdatamodeld)这个文件
    
    NSURL *urlPath= [[NSBundle mainBundle]URLForResource:@"company" withExtension:@"momd"];
    NSManagedObjectModel *companyModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:urlPath];
    
    //2.2持久化存储调用器
    NSPersistentStoreCoordinator *store = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:companyModel];
    
    
    //数据库的完整文件路径
    NSString *sqlitePath = [dPath stringByAppendingPathComponent:@"company.sqlite"];
    
    //保存一个sqite文件的话,必要知道表结构和sqlite的文件路径
    //2.3 告诉coredate数据存储在一个sqlite文件
    NSError *error = nil;
    [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:sqlitePath] options:nil error:&error];
    
    if (error) {
        NSLog(@"%@",error);
    }
    
    context.persistentStoreCoordinator = store;
    _context = context;
    
}

-(void)addEmployee {
    
    //添加员工
    //1.创建一个员工对象
    //用coredata创建对象不能使用下面的方法
    //Employee *emp = [[Employee alloc] init];
    
    
    //注意，entityName 和插入类名相同
    Employee *emp = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:_context];
    
    int i =arc4random_uniform(10);
    i%2==0?(emp.name =@"wbn"):
    (emp.name = [NSString stringWithFormat:@"%ibn",i]);
    emp.height=160+arc4random_uniform(20);
    emp.birthday = [self  date];
    
    
    //保存员工信息
    
    NSError *error = nil;
    if (_context.hasChanges) {
        [_context save:&error];
    }
    
    if (error) {
        NSLog(@"CoreData insert data error:%@",error);
    }
    NSLog(@"add done");
    
}


#pragma mark --查找员工信息
-(void)queryEmployee {
    
    //查找数据
    //1.创建请求对象,指定要查找的表
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    
    //2.时间排序
    NSSortDescriptor *dateSort = [NSSortDescriptor sortDescriptorWithKey:@"height" ascending:YES];//YES代表升序 NO 降序
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
    NSLog(@"-------------------------------------------------------");
    for (Employee *emp in allEmployee) {
        NSLog(@"name:%@  height:%.f  birthday:%@",emp.name,emp.height,emp.birthday);
    }
    NSLog(@"-------------------------------------------------------");
    
}
#pragma mark --改员工信息
-(void)updateEmployee:(UITextField *)textF{

    //查找数据
    //1.创建请求对象,指定要查找的表
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    
    //2.时间排序
    NSSortDescriptor *dateSort = [NSSortDescriptor sortDescriptorWithKey:@"height" ascending:YES];//YES代表升序 NO 降序
    request.sortDescriptors = @[dateSort];
    
    
    //过滤条件 只想查找 wbn
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name = %@",@"wbn"];
    request.predicate = pre;
    
    
    //3.执行请求
    NSArray *allEmployee =  [_context executeFetchRequest:request error:nil];
    
    NSLog(@"%@",allEmployee);
    //更新wbn的身高为2米
    for (Employee *emp in allEmployee) {
        emp.height = [textF.text floatValue];
    }
    
    //保存更改的信息
    [_context save:nil];
    
    NSLog(@"update done");
}


#pragma mark  --删除员工信息
-(void)deleteEmployee:(UITextField *)textF
 {
    //查找数据
    //1.创建请求对象,指定要查找的表
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    
    //2.时间排序
    NSSortDescriptor *dateSort = [NSSortDescriptor sortDescriptorWithKey:@"height" ascending:YES];//YES代表升序 NO 降序
    request.sortDescriptors = @[dateSort];
    
    
    //过滤条件 只想查找 wbn
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name like[c] %@",textF.text];
    
    //    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name = %@",@"wbn"];
    request.predicate = pre;
    
    
    //3.执行请求
    NSArray *allEmployee =  [_context executeFetchRequest:request error:nil];
    
    NSLog(@"%@",allEmployee);
    //删除zhangsan8的信息
    for (Employee *emp in allEmployee) {
        [_context deleteObject:emp];
    }
    
}


-(void)queryComplexEmployee:(UITextField *)textF
{
    //查找数据
    //1.创建请求对象,指定要查找的表
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    
    //2.时间排序
    NSSortDescriptor *dateSort = [NSSortDescriptor sortDescriptorWithKey:@"height" ascending:YES];//YES代表升序 NO 降序
    request.sortDescriptors = @[dateSort];
    
    
    //3.过滤条件 只想查找 zhangsan8
    //a 查找名为zhangsan 并且身高大于等1.30
    //NSPredicate *pre = [NSPredicate predicateWithFormat:@"name = %@ AND height >= %lf",@"zhangsan",1.30];
    
    //b.查找名字以zh开头 并且身高大于1.3
    //以什么BEGINSWITH
    //c代表不区分大小写
    //NSPredicate *pre = [NSPredicate predicateWithFormat:@"name BEGINSWITH[c] %@ AND height >= %lf",@"abc",1.30];
    
    //c.查找名字以san结尾 ,并用身高大于1.3
    //NSPredicate *pre = [NSPredicate predicateWithFormat:@"name ENDSWITH[c] %@ AND height >= %lf",@"cent",1.30];
    
    //4.模糊查询
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name like[c] %@",textF.text];
    
    request.predicate = pre;
    
    //4.执行请求
    NSError *error = nil;
    NSArray *allEmployee =  [_context executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    
    //NSLog(@"%@",allEmployee);
    NSLog(@"-------------------------------------------------------");
    for (Employee *emp in allEmployee) {
        NSLog(@"name:%@  height:%.f  birthday:%@",emp.name,emp.height,emp.birthday);
    }
    NSLog(@"-------------------------------------------------------");
    
}


-(NSString *)date
{
    NSDateFormatter *fmt=[NSDateFormatter new];
    fmt.dateFormat=@"yyyy-MM-dd";
    return [fmt stringFromDate:[NSDate date]];
}

-(void)dealloc
{
    NSLog(@"operation dealloc");
}


@end
