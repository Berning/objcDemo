//
//  BNNavigationController.h
//  Xcode8
//
//  Created by uBerning on 2017/3/13.
//  Copyright © 2017年 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNNavigationController : UINavigationController

@property(nullable, nonatomic,strong,readonly) UIGestureRecognizer *fullInteractivePopGestureRecognizer;

@end
