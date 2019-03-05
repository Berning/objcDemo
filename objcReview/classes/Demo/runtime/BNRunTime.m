//
//  BNRunTime.m
//  Xcode8
//
//  Created by uBerning on 2017/3/16.
//  Copyright © 2017年 BN. All rights reserved.
//

#import "BNRunTime.h"
#import <objc/runtime.h>

#import "MJExtension.h"
//#import "NSMutableArray+SW.h"
#import "NSMutableArray+properties.h"

#import "BNPeople.h"
#import "BNDog.h"
#import "BNBall.h"


@implementation BNRunTime

+(void)rtRunTimeExecute
{
    [self runTimeMsgSend];
}

+(void)runTimeMsgSend
{
    void (*setDogType)(id,SEL,BOOL);

    BNDog *dog=[BNDog new];
    setDogType= (void(*)(id,SEL,BOOL))[dog methodForSelector:@selector(setDogType:)];
    
    for (int i=0; i<10; i++) {
//        setDogType(dog,@selector(setDogType:),YES);
        NSLog(@"%p",setDogType);
    }
    
//    struct List{};
    typedef struct {}*List;

    struct BNObject {
        Class isa;
        List propertyList;
        List methodList;
        List ivarList;
//        struct List *propertyList;
//        struct List *methodeList;
//        struct List *ivarList;
    };

    
}



+(void)rtMethodSwizzling
{
    NSMutableArray *arr=[NSMutableArray array];
    [arr addObject:@"obj1"];
    [arr addObject:nil];
    
    NSLog(@"%@",arr);
}

#pragma  mark add property

+(void)rtAddProperty
{
    NSMutableArray *arr=[NSMutableArray array];
    
    arr.dog=@"旺财";
    arr.height=190;
    NSLog(@"%f--%@",arr.height,arr.dog);
}



+(void)rtEnumarateClassIvars
{
    unsigned int count=0;
    Ivar *ivars= class_copyIvarList([BNDog class], &count);
    
    for (int i=0; i<count; i++) {
//        const char *name= ivar_getName(*(ivars+i));
        const char *name= ivar_getName(ivars[i]);
        const char *type=ivar_getTypeEncoding(ivars[i]);
        NSLog(@"%s ----%s",name,type);
    }

    free(ivars);
    
}

+(void)rtEnumarateClassProperties
{
    unsigned int count=0;
    objc_property_t *properties= class_copyPropertyList([NSArray class],&count);
    for (int i=0; i<count; i++) {
        //        const char *name= ivar_getName(*(ivars+i));
        const char *name= property_getName(properties[i]);
        const char *attr= property_getAttributes(properties[i]);
        
        
        NSLog(@"%s---%s",name,attr);
    }
    free(properties);
}


+(void)rtEnumarateClassMethods
{
    unsigned int count=0;
    Method *methods= class_copyMethodList([NSObject class], &count);
    for (int i=0; i<count; i++) {
        SEL name= method_getName(methods[i]);
        
        NSLog(@"%@",NSStringFromSelector(name));
    }

    free(methods);

}

+(void)rtEnumarateClassProtocols
{
    unsigned int count=0;

    Protocol *__unsafe_unretained *protocols= class_copyProtocolList([BNDog class], &count);
    
    for(int i=0;i<count;i++)
    {
        //遵循了哪些协议
        const char *protocol= protocol_getName(protocols[i]);
        NSLog(@"%s",protocol);
    }
    
}




+(void)rtKeyValuesTest
{
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    
    NSMutableDictionary *dogDict=[NSMutableDictionary dictionary];
    NSMutableDictionary *ballDict=[NSMutableDictionary dictionary];
    [ballDict setValue:@"basketBall" forKey:@"ballName"];
    [ballDict setValue:@"23" forKey:@"ballSize"];
    [ballDict setValue:@"橙色" forKey:@"ballColor"];
    
    [dogDict setValue:@"旺财" forKey:@"name"];
    [dogDict setValue:@"蓝色" forKey:@"dogColor"];
    [dogDict setValue:ballDict forKey:@"ball"];
    
    
    NSMutableDictionary *dict1=[NSMutableDictionary dictionary];
    [dict1 setValue:@"english" forKey:@"name"];
    [dict1 setValue:@"330" forKey:@"pages"];
    [dict1 setValue:@"bn ctd" forKey:@"publiser"];
    NSMutableDictionary *dict2=[NSMutableDictionary dictionary];
    [dict2 setValue:@"c++" forKey:@"name"];
    [dict2 setValue:@"630" forKey:@"pages"];
    [dict2 setValue:@"tsinghua" forKey:@"publiser"];
    NSMutableDictionary *dict3=[NSMutableDictionary dictionary];
    [dict3 setValue:@"高数" forKey:@"name"];
    [dict3 setValue:@"450" forKey:@"pages"];
    [dict3 setValue:@"tsinghua" forKey:@"publiser"];

    NSMutableArray *bookArr=[NSMutableArray array];
    [bookArr addObject:dict1];
    [bookArr addObject:dict2];
    [bookArr addObject:dict3];
    
    [dict setValue:@"wbn" forKey:@"name"];
    [dict setValue:@"20" forKey:@"age"];
    [dict setValue:@"js" forKey:@"gf"];
    [dict setValue:dogDict forKey:@"dog"];
    [dict setValue:bookArr forKey:@"books"];
    
    
    BNPeople *person=[BNPeople mj_objectWithKeyValues:dict];
    
    NSLog(@"%@",person.mj_keyValues);
    }


+(void)rtMethodForwardingTest
{
    BNBall *ball=[BNBall new];
    id something=[ball performSelector:@selector(eat)];

    NSString *num=[ball performSelector:@selector(compute)];
    NSLog(@"result:%@--eat:%@",num,something);
    
    NSLog(@"%@",NSStringFromSelector(_cmd));
    NSLog(@"%s",__FILE__);
    NSLog(@"%@",[@__FILE__ lastPathComponent]);
    NSLog(@"%d",__LINE__);
    
    
}




@end
