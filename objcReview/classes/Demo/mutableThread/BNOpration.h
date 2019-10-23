//
//  BNOpration.h
//  Xcode8
//
//  Created by uBerning on 2017/3/15.
//  Copyright © 2017年 BN. All rights reserved.
//

#import "BNBaseTest.h"

/*
                生命周期    创建线程    有无队列概念   可否控制线程
 
 NSThread:      手动        手动        无           可以
 
   GCD          自动        自动        有           否
 
NSOperation     自动        自动        有           可以
 
 
*/


//    NSOperation
//    NSBlockOperation
//    NSInvocationOperation
//    NSOperationQueue


@interface BNOpration : BNBaseTest



@end
