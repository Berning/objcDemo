//
//  main.m
//  obcjDemo
//
//  Created by Berning on 2018/10/7.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "bnManager.h"



int main(int argc, const char * argv[]) {
    @autoreleasepool {
    
//        [[bnManager new] test];
        
        NSArray *arr=@[@"12",@"1",@"3",@"4",@"12",@"13",@"5",@"13"];

        [bnManager filterArr:arr];
        
        
    }
    return 0;
}
