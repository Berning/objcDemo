//
//  UIWindow+BN.m
//  objcReview
//
//  Created by Berning on 2019/1/26.
//  Copyright © 2019年 Bien. All rights reserved.
//
#import "UIWindow+BN.h"

@implementation UIWindow (BN)

static const double key;

- (void)setRootViewManager:(BNViewManager *)rootViewManager
{
    if(rootViewManager)
    {
        [self addSubview:rootViewManager.maskView];
        [self addSubview:rootViewManager.view];
        if (rootViewManager.view)
        {
            if ([rootViewManager isMemberOfClass:[BNNavigationManager class]])
            {
                BNNavigationManager *aRootViewManager=(BNNavigationManager *)rootViewManager;
                [aRootViewManager.visibleViewManager viewDidLoad];
            }
            else
            {
                [rootViewManager viewDidLoad];
            }
        }
    }
    
//    rootViewManager.topViewManager=self;
    objc_setAssociatedObject(self,&key,rootViewManager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BNViewManager *)rootViewManager
{
    return  (BNViewManager *)objc_getAssociatedObject(self,&key);
}

- (void)makeMainAndVisible
{
    self.hidden=NO;
    [self addSubview:self.rootViewController.view];
    [[UIApplication sharedApplication] delegate].window=self;
}



@end
