//
//  BNNavigationManager.h
//  objcReview
//
//  Created by Berning on 2019/1/27.
//  Copyright © 2019年 Bien. All rights reserved.
//

#import "BNViewManager.h"

@class BNNavigationBar;

NS_ASSUME_NONNULL_BEGIN

@interface BNContainerView : UIView

@end

@interface BNNavigationManager : BNViewManager

- (instancetype)initWithRootViewManager:(BNViewManager *)rootViewManager; // Convenience method pushes the root view controller without animation.

/** navigationBar  */
@property(nonatomic,weak)BNNavigationBar *navigationBar;

/** push */
- (void)pushViewManager:(nullable BNViewManager *)viewManager animated:(BOOL)animated;


@property(nullable,nonatomic,readonly,strong)BNViewManager *topViewManager;// The top view manager on the stack.

@property(nullable, nonatomic,readonly,strong) BNViewManager *visibleViewManager; // Return modal view manager if it exists. Otherwise the top view manager.


@end


@interface BNViewManager (BNNavigation)

@property(nullable,nonatomic,strong)BNNavigationManager *navigationManager;

@end

NS_ASSUME_NONNULL_END
