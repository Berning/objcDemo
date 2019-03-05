//
//  UIWindow+BN.h
//  objcReview
//
//  Created by Berning on 2019/1/26.
//  Copyright © 2019年 Bien. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class BNViewManager;

NS_ASSUME_NONNULL_BEGIN

@interface UIWindow (BN)

@property(nullable,nonatomic,strong)BNViewManager *rootViewManager;

- (void)makeMainAndVisible;

@end

NS_ASSUME_NONNULL_END
