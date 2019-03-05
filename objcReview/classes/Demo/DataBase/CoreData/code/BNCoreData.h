//
//  BNCoreData.h
//  Xcode8
//
//  Created by uBerning on 2017/3/16.
//  Copyright © 2017年 BN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//CoreData是对SQLite3的封装，没有后者高效，但用起来方便
//CoreData提供了ORM功能:OC对象和数据互相转化
// 对象关系映射(Object Relational Mapping,简称ORM)模式是一种为了解决面向对象与关系数据库存在的互不匹配的现象的技术
//CoreData不需要编写sql语句 使用时倒入框架和相关头文件
//
// 三大对象
//NSManagedObjectContext --- 数据上下文:操作 -> 实际内容（操作持久层），进行增加删改操作。数据上下文初始化的后，NSPersistentStoreCoordinator

//NSManagedObjectModel --- 数据模型:数据库所有表格或数据结构，包含各实体的定义信息
//作用：添加实体的属性(attributes)，建立属性之间的关系(relationships)
//操作方法：视图编辑器，或代码初始化,通过文件创建，初始化必须依赖.momd文件路径，而.momd文件由.xcdatamodeld文件编译而来

//NSPersistentStoreCoordinator --- 持久化存储助理
//作用：设置数据存储的名字，位置，存储方式
//初始化：必须依赖NSManagedObjectModel，之后要指定持久化存储的数据类型，默认的是NSSQLiteStoreType，即SQLite数据库；并指定存储路径为Documents目录下，以及数据库名称



//NSFetchRequest 请求相当于查询语句
//NSEntityDescription 实体结构  相当于表格结构
//.xcdatamodeld 用数据模型编辑器编辑，编译后为.momd或.mom文件

#pragma mark see in coreDataTest proj

@interface BNCoreData : NSObject

@property(class,readonly)void test;


@end
