//
//  BNDog.m
//  Xcode8
//
//  Created by uBerning on 2017/3/22.
//  Copyright © 2017年 BN. All rights reserved.
//

#import "BNDog.h"
#import <objc/runtime.h>

@implementation BNDog


+(void)load
{
    Method md1=class_getInstanceMethod(self, @selector(run));
    Method md2=class_getInstanceMethod(self, @selector(walk));
    
    method_exchangeImplementations(md1, md2);
    
}

-(void)run
{
    NSLog(@"run");
}


-(void)walk
{
    NSLog(@"walk");
}


-(id)eat
{
   return @"bone";
}

#pragma mark -解归档

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    
    if (self=[super init]) {
        unsigned int count=0;
        Ivar *ivars= class_copyIvarList([self class], &count);
        
        for (int i=0; i<count; i++) {
            //        const char *name= ivar_getName(*(ivars+i));
            const char *name= ivar_getName(ivars[i]);
            
            NSString *key = [NSString stringWithUTF8String:name];
            id value= [aDecoder decodeObjectForKey:key];
            NSLog(@"value:%@",value);
        
            [self setValue:value forKey:key];
            
    
        }
        
        free(ivars);
    }
    
    return self;
}


- (void)encodeWithCoder:(NSCoder *)encoder
{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i<count; i++) {
        // 取得i位置的成员变量
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        [encoder encodeObject:[self valueForKeyPath:key] forKey:key];
    }
}




@end
