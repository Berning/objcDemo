//
//  BNGroup.m
//  objcReview
//
//  Created by Berning on 2018/12/30.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "BNGroup.h"
#import "BNItem.h"

@implementation BNGroup

+ (instancetype)groupWithTpye:(BNGroupType)type
{
    switch (type) {
        case BNGroupTypeObjc:
            return [self objcMake];
            break;
        case BNGroupTypeC:
            return [self cMake];
            break;
        case BNGroupTypeWeb:
            return [self webMake];
            break;
        case BNGroupTypeAlgorithm:
            return [self AlgorithmMake];
            break;

            
        default:
            break;
    }
    return nil;
}

#pragma mark -objcMake
+ (instancetype)objcMake
{
    NSDictionary *dict1=@{@"name":@"Foundation",@"image":@"foundation"};
    BNItem *item1=[BNItem itemWithDictionary:dict1];
    NSDictionary *dict2=@{@"name":@"UI",@"image":@"ui"};
    BNItem *item2=[BNItem itemWithDictionary:dict2];

    NSDictionary *dict3=@{@"name":@"Tread",@"image":@"thread"};
    BNItem *item3=[BNItem itemWithDictionary:dict3];
    NSDictionary *dict4=@{@"name":@"NetWork",@"image":@"network"};
    BNItem *item4=[BNItem itemWithDictionary:dict4];
    NSDictionary *dict5=@{@"name":@"DataBase",@"image":@"database"};
    BNItem *item5=[BNItem itemWithDictionary:dict5];
    NSDictionary *dict6=@{@"name":@"RunTime",@"image":@"runtime"};
    BNItem *item6=[BNItem itemWithDictionary:dict6];
    
    //group
    BNGroup *group=[[BNGroup alloc] init];
    group.header=@"Objc";
    //    group.footer=@"Objc End";
    group.items=@[item1,item2,item3,item4,item5,item6];
    return group;

}

#pragma mark -cMake
+ (instancetype)cMake
{
    NSDictionary *dict1=@{@"name":@"C",@"image":@"c"};
    BNItem *item1=[BNItem itemWithDictionary:dict1];
    NSDictionary *dict2=@{@"name":@"C++",@"image":@"c++"};
    BNItem *item2=[BNItem itemWithDictionary:dict2];
    

    BNGroup *group=[[BNGroup alloc] init];
    group.header=@"C/C++";
    group.items=@[item1,item2];
    return group;

}

#pragma mark -webMake
+ (instancetype)webMake
{
    
    NSDictionary *dict0=@{@"name":@"Html",@"image":@"html"};
    BNItem *item0=[BNItem itemWithDictionary:dict0];
    

    NSDictionary *dict1=@{@"name":@"H5",@"image":@"h5"};
    BNItem *item1=[BNItem itemWithDictionary:dict1];
    NSDictionary *dict2=@{@"name":@"CSS",@"image":@"css"};
    BNItem *item2=[BNItem itemWithDictionary:dict2];
    
    NSDictionary *dict3=@{@"name":@"JavaScript",@"image":@"js"};
    BNItem *item3=[BNItem itemWithDictionary:dict3];
    BNGroup *group=[[BNGroup alloc] init];
    group.header=@"Web";
    group.items=@[item0,item1,item2,item3];
    return group;
}


#pragma mark -AlgorithmMake
+ (instancetype)AlgorithmMake
{
    NSDictionary *dict1=@{@"name":@"Algorithm",@"image":@"algorithm"};
    BNItem *item1=[BNItem itemWithDictionary:dict1];
    
    BNGroup *group=[[BNGroup alloc] init];
    group.header=@"Algorithm";
    group.items=@[item1];
    return group;
}

@end
