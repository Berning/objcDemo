//
//  BNThread.m
//  Xcode8
//
//  Created by uBerning on 2017/3/13.
//  Copyright © 2017年 BN. All rights reserved.
//

#import "BNThread.h"



@implementation BNThread

+(void)test
{
    NSLog(@"threadPriority:%ld",[NSThread currentThread].qualityOfService); //0x21
//    [self threadOpration];
    [self threadPerform];
}

+(void)threadOpration
{
    NSLog(@"------NSThread-------");
        [NSThread detachNewThreadWithBlock:^{

            NSThread *thread=[NSThread currentThread];
            thread.name=@"bn";

            BOOL isMulti=[NSThread isMultiThreaded];
            NSMutableDictionary *threadDict=thread.threadDictionary;

            [NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
            NSLog(@"already sleep 1s");

            [NSThread sleepForTimeInterval:1];

            //设置线程优先级,即将过期
            [NSThread setThreadPriority:0.5];
            double threadPriority=[NSThread threadPriority];

            thread.threadPriority=1;
            double threadPriority2=thread.threadPriority;

           //线程启动后无效
            thread.qualityOfService=NSQualityOfServiceUserInitiated;

            NSLog(@"\nthread:%@,\nthreadDict:%@\nthreadPriority1:%f\nthreadPriority2:%f\nqualityOfService:%ld\nisMultiThreaded:%d\nisMainThread:%d",[NSThread currentThread],threadDict,threadPriority,threadPriority2,thread.qualityOfService,isMulti,([NSThread isMainThread]&&[thread isMainThread]));

            [thread main];
            NSLog(@"---%@",[NSThread currentThread]);
            NSLog(@"stackSize:%ld",thread.stackSize);
            NSLog(@"callBack:%@,\n%@",[NSThread callStackReturnAddresses],[NSThread callStackSymbols]);
            NSLog(@"name:%@",thread.name);
            NSLog(@"isMainThread:%d,%d",[thread isMainThread],[NSThread isMainThread]);
            NSLog(@"status:%d,%d,%d",thread.executing,thread.cancelled,thread.finished);

            [thread cancel];
            NSLog(@"status2:%d,%d,%d",thread.executing,thread.cancelled,thread.finished);


            [NSThread exit];
            //不能在打印（执行操作）
            NSLog(@"status3:%d,%d,%d",thread.executing,thread.cancelled,thread.finished);


    }];
    
    
    
        [NSThread detachNewThreadSelector:@selector(threadRun:) toTarget:self withObject:@"nsthread1"];
    
#pragma mark alloc法创建
//    NSThread *thread=[[NSThread alloc]initWithBlock:^{
//        NSLog(@"%@",[NSThread currentThread]);
//
//    }];

    NSThread *thread=[[NSThread alloc]initWithTarget:self selector:@selector(threadRun:) object:@"nsthread2"];
    [thread setName:@"ss"];
    [thread setQualityOfService:NSQualityOfServiceUserInitiated];
    [thread start];
    NSLog(@"qualityOfService:%ld",thread.qualityOfService);
    NSLog(@"stackSize:%ld",thread.stackSize);
    NSLog(@"name:%@",thread.name);
    NSLog(@"isMainThread:%d",[thread isMainThread]);
    NSLog(@"status:%d,%d,%d",thread.executing,thread.cancelled,thread.finished);
    
    NSLog(@"%@",[NSThread currentThread]);
    
}


+(void)threadRun:(id)obj
{
    @autoreleasepool {
        NSLog(@"%@--%@",[NSThread currentThread],obj);
        
        //需要为新开启的线程启动runloop,否则线程退出
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        [runLoop run];

    }
}


#pragma mark NSObject(NSThread)

+(void)threadPerform
{
    [[self new] threadPerform];
}


// AFNetworking
+ (NSThread *)networkRequestThread {
    static NSThread *_networkRequestThread = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _networkRequestThread = [[NSThread alloc] initWithTarget:self selector:@selector(networkRequestThreadEntryPoint:) object:nil];
        [_networkRequestThread start];
    });
    
    return _networkRequestThread;
}

+ (void)networkRequestThreadEntryPoint:(id)__unused object {
    @autoreleasepool {
        [[NSThread currentThread] setName:@"AFNetworking"];
        
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        [runLoop run];
    }
}


//eatThread
+(NSThread *)eatThread
{
    NSThread *thread=[[NSThread alloc]initWithTarget:self selector:@selector(threadRun:) object:@"nsthread2"];
    [thread setName:@"eatThread"];
    [thread setQualityOfService:NSQualityOfServiceUserInitiated];
    [thread start];
    return  thread;
}

-(void)threadPerform
{
        
    [self performSelectorOnMainThread:@selector(run:) withObject:@"OnMainThread" waitUntilDone:YES];
    
    [self performSelectorOnMainThread:@selector(run:) withObject:@"OnMainThread+Mode" waitUntilDone:YES modes:
     @[NSRunLoopCommonModes]];

    
    
    [self performSelector:@selector(run:) onThread:[[self class] networkRequestThread] withObject:@"onThread" waitUntilDone:NO];
    
    [self performSelector:@selector(run:) onThread:[[self class]eatThread] withObject:@"onThread+Mode" waitUntilDone:NO modes:@[NSRunLoopCommonModes]];//qualityOfService=0x21
    
    
    [self performSelectorInBackground:@selector(run:) withObject:@"InBackground"];//qualityOfService=0x11
    
    NSLog(@"Done---%@",[NSThread currentThread]);

}

-(void)run:(id)object
{

    [NSThread sleepForTimeInterval:3];
    NSLog(@"%@===%@===%ld", [NSThread currentThread],object,[NSThread currentThread].qualityOfService);
}
@end
