//
//  bnManager.m
//  obcjDemo
//
//  Created by Berning on 2018/10/7.
//  Copyright © 2018年 BN. All rights reserved.
//



#import "bnManager.h"
#import "bnPerson.h"
#import "bnMachine.h"

#if !__has_feature(objc_arc)

int a=10;
void(^gBlock) (void)=^(){
    printf("%d",a);
};

@implementation bnManager

- (void)delegateTest
{
    bnPerson *person=[bnPerson new];
    NSLog(@"p:%lu",[person retainCount]);  //1

    bnMachine *machine=[bnMachine new];
    NSLog(@"m:%lu",[machine retainCount]); //1
   
    
    person.delegate=machine;
    
    NSLog(@"p:%lu",[person retainCount]); //1
    NSLog(@"m:%lu",[machine retainCount]);//2

    [person release];
    [machine release];
    
//    NSLog(@"p:%lu",[person retainCount]);   //0 只是描述，实际person已被释放，会造成野指针，但Xcode有时不会报错。？？？
//    NSLog(@"m:%lu",[machine retainCount]); //strong 1  weak 0


}

-(void)test
{
    [self testBlock];
}



- (void)testBlock
{

    //堆区block 循环引用示例
    __weak __typeof(self) weakSelf=self;

    self.option=^(){
        NSLog(@"option-weakSelf:%lu",weakSelf.retainCount);

//        NSLog(@"option-self:%lu",self.retainCount);  //会有retain cycle
    };
    self.option();
    
    NSLog(@"self:%lu",self.retainCount);
    
    NSLog(@"option:%@", self.option);  //option:<__NSMallocBlock__: 0x101806870>
    
    
#pragma mark - stackBlock

    void(^stackBlock)(void)=^(){
        NSLog(@"stackBlock-self-%lu",self.retainCount);
    };
    stackBlock();

    NSLog(@"stackBlock:%@",stackBlock);        //       stackBlock:<__NSStackBlock__: 0x7ffeefbff410>

#pragma mark - mallockBlock
    //手动copy
    void (^mallockBlock)(void)=[^(){
        NSLog(@"mallockBlock-self:%lu",self.retainCount);
    } copy];
    
    mallockBlock();
    
    NSLog(@"mallockBlock:%@",mallockBlock);  //    mallockBlock:<__NSMallocBlock__: 0x1007276c0>

    
    
#pragma mark - globalBlock
    //定义在局部\
     但不调用外部变量的block为全局block
    void(^globalBlock)(void)=^(){};
    globalBlock();
    NSLog(@"globalBlock:%@",globalBlock);    //globalBlock:<__NSGlobalBlock__: 0x100005318>

    
    //定义在全局d
    gBlock();
    NSLog(@"gBlock:%@",gBlock); //gBlock:<__NSGlobalBlock__: 0x1000052c0>


}

- (void)dealloc
{
    NSLog(@"self:%lu",self.retainCount);

    [super dealloc];

    NSLog(@"manager released");
}


@end

#endif
