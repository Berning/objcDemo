//
//  NSMutableArray+Sort.m
//  Lottery
//
//  Created by Berning on 2018/12/5.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "NSMutableArray+Sort.h"

@implementation NSMutableArray (Sort)

-(instancetype)arraySortArrayByAscend:(NSMutableArray *)array
{
    [array sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2)
     {
         int value1 = [obj1 intValue];
         int value2 = [obj2 intValue];
         
         // 升序，即从小到大
         if (value1 > value2)
         {
             return (NSComparisonResult)NSOrderedDescending;
         }
         else if (value1 < value2)
         {
             return (NSComparisonResult)NSOrderedAscending;
         }
         else
         {
             return (NSComparisonResult)NSOrderedSame;
         }
         
         
     }];
    
    return array;
}

@end
