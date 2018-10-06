//
//  BNGCD.h
//  Xcode8
//
//  Created by uBerning on 2017/3/13.
//  Copyright © 2017年 BN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Singleton.h"

@interface BNGCD : NSObject
// 同步函数,会等block执行完毕, 才会执行后面的代码
+(void)syncWithSerial;
+(void)syncWithConcurrent;

+(void)asyncWithSerial;
+(void)asyncWithConcurrent;

//如果是在主线程中调用同步函数 + 主队列, 那么会导致死锁
//导致死锁的原因:
//sync函数是在主线程中执行的, 并且会等待block执行完毕. 先调用
//block是添加到主队列的, 也需要在主线程中执行. 后调用
+(void)syncWithMain;

//异步 + 主队列 : 不会创建新的线程, 并且任务是在主线程中执行
+(void)asyncWithMain;

//如果是在子线程中调用 同步函数 + 主队列, 那么没有任何问题
+(void)syncInAsync:(UIView *)view;


//其它5个函数

+(void)timeDelay:(int)option;

//apply:队列不能是主队列（锁死)
+(void)onceAndApply:(int)option;


//前面执行完才执行--barrier--执行完才执行后面
//queue不能是global queue
+(void)barrierAsync:(UIView *)view;

//dispatch_group_async全部完成，dispatch_group_notify()才会执行
+(void)groupAsync:(UIView *)view;

@property(class,readonly)void test;

SingletonH(Med)
//+(instancetype)shareData;

-(void)testSingle;

@end


/**
    blcok
 */

typedef  void (^eBlock)(void);

@interface BNBlock : NSObject


+(void)test;

@property(nonatomic,copy)void(^completion)(id obj);

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)eBlock block1;



@end
