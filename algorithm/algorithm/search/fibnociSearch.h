//
//  fibnociSearch.h
//  algorithm
//
//  Created by Berning on 2018/10/21.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface fibnociSearch : NSObject

/*
 
 基本思想：也是二分查找的一种提升算法，通过运用黄金比例的概念在数列中选择查找点进行查找，提高查找效率。同样地，斐波那契查找也属于一种有序查找算法。
 相对于折半查找，一般将待比较的key值与第mid=（low+high）/2位置的元素比较，比较结果分三种情况：
 1）相等，mid位置的元素即为所求
 2）>，low=mid+1;
 3）<，high=mid-1。
 
 斐波那契查找与折半查找很相似，他是根据斐波那契序列的特点对有序表进行分割的。他要求开始表中记录的个数为某个斐波那契数小1，及n=F(k)-1;
 
 开始将k值与第F(k-1)位置的记录进行比较(及mid=low+F(k-1)-1),比较结果也分为三种
 1）相等，mid位置的元素即为所求
 2）>，low=mid+1,k-=2;
 说明：low=mid+1说明待查找的元素在[mid+1,high]范围内，k-=2 说明范围[mid+1,high]内的元素个数为n-(F(k-1))= Fk-1-F(k-1)=Fk-F(k-1)-1=F(k-2)-1个，所以可以递归的应用斐波那契查找。
 3）<，high=mid-1,k-=1。
 
 说明：low=mid+1说明待查找的元素在[low,mid-1]范围内，k-=1 说明范围[low,mid-1]内的元素个数为F(k-1)-1个，所以可以递归 的应用斐波那契查找。
 */


//复杂度分析：最坏情况下，时间复杂度为O(log2(n))，且其期望复杂度也为O(log2(n))。


int Fibonacci_Search(int *a, int n, int key);

@end

NS_ASSUME_NONNULL_END
