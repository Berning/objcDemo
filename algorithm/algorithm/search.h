//
//  search.h
//  algorithm
//
//  Created by Berning on 2018/10/21.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface search : NSObject

int bnSeqSearch(int a[], int value, int n);

int bnBinarySearch(int a[], int value, int n);

int bnBinarySearchRecursion(int a[], int value, int low, int high);

int bnInsertionSearch(int a[], int value, int low, int high);

int bnFibnocciSearch(int a[],int value,int n);

@end

NS_ASSUME_NONNULL_END
