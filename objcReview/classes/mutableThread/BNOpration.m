//
//  BNOpration.m
//  Xcode8
//
//  Created by uBerning on 2017/3./15.
//  Copyright © 2017年 BN. All rights reserved.
//

#import "BNOpration.h"
#import "BNGCD.h"
@implementation BNOpration

+(void)test
{
//    [self operationForInvocationHandle];
//    [self operationForBlockHandle];
    [self operationForQueueHandle];
}

+(void)operationForInvocationHandle
{
    //创建operation
#pragma --NSInvocationOperation
    NSString *string=[NSString stringWithFormat:@"123"];
    NSInvocationOperation *op1=[[NSInvocationOperation alloc]initWithTarget:self selector:@selector(run:) object:string];
    NSInvocationOperation *op2=[[NSInvocationOperation alloc]initWithTarget:self selector:@selector(run:) object:string];

    op1.name=@"op1";
    [op2 addDependency:op1];


    NSLog(@"queuePriority:%ld",op1.queuePriority);
    NSLog(@"qualityOfService:%ld",op1.qualityOfService);
    NSLog(@"isExecuting:%d",op1.isExecuting);
    NSLog(@"isCancelled:%d",op1.isCancelled);
    NSLog(@"isFinished:%d",op1.isFinished);
    NSLog(@"isConcurrent:%d",op1.isConcurrent);
    NSLog(@"isAsynchronous:%d",op1.isAsynchronous);
    NSLog(@"isReady:%d",op1.isReady);
    
    NSLog(@"dependencies:%ld",op2.dependencies.count);
    //    [op1 waitUntilFinished];

    //只能在start前,retain的
    //两个属性
    NSLog(@"out2:%@",op1.result);         //out:null
    NSLog(@"out:%@",op1.invocation );
    
    [op1 start];

    
//    NSInvocationOperation *op2=[[NSInvocationOperation alloc] initWithInvocation:[NSInvocation invocationWithMethodSignature:<#(nonnull NSMethodSignature *)#>]]
}

#pragma --NSBlockOperation

+(void)operationForBlockHandle
{
    
        NSBlockOperation *op1=[NSBlockOperation blockOperationWithBlock:^{
            NSLog(@"output1:%@",[NSThread currentThread]);
    
        }];
    
        //添加额外任务，开启xin
        [op1 addExecutionBlock:^{
            NSLog(@"output2:%@",[NSThread currentThread]);
        }];
        [op1 addExecutionBlock:^{
            NSLog(@"output3:%@",[NSThread currentThread]);
        }];
    
        NSLog(@"output:%ld\n%@",op1.executionBlocks.count,op1.executionBlocks);
    
        [op1 start];
}

+(void)run:(id)object
{
    NSLog(@"output2:%@\n%@",[NSThread currentThread],object);
}

+(void)operationForQueueHandle
{
    NSOperationQueue *queue=[[NSOperationQueue alloc]init];
    queue.maxConcurrentOperationCount=1;//1.串行执行 2.以上是并发执行
    
    NSBlockOperation *op1=[NSBlockOperation blockOperationWithBlock:^{
        [NSThread currentThread].name=@"op1";
        NSLog(@"output1:%@",[NSThread currentThread]);

    }];

    NSInvocationOperation *op2=[[NSInvocationOperation alloc]initWithTarget:self selector:@selector(run:) object:@"obj123"];
    
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperationWithBlock:^{
        [NSThread currentThread].name=@"op3";

        NSLog(@"output3:%@",[NSThread currentThread]);
    }];
    
    //其它方法：
    queue.name=@"myq";
    NSLog(@"qualityOfService:%ld",  queue.qualityOfService);
    
    NSLog(@"name:%@",  queue.name);
    NSLog(@"isSuspend:%d",  queue.isSuspended);

    

}


@end
