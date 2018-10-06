//
//  bnDataManager.m
//  coreDataTest
//
//  Created by Berning on 2018/10/6.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "bnDataManager.h"
#import "bnViewContainer.h"


@interface bnDataManager ()

@end

@implementation bnDataManager
+(void)crudWithView:(UIView *)view
{
    bnViewContainer *viewContainer=[[bnViewContainer alloc] initWithFrame:CGRectMake(0, 60, [[UIScreen mainScreen] bounds].size.width, 400)];
    [view addSubview:viewContainer];
}


@end
