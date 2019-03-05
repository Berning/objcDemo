//
//  BNViewManager.h
//  objcReview
//
//  Created by Berning on 2019/1/26.
//  Copyright © 2019年 Bien. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNNavigationManager;

NS_ASSUME_NONNULL_BEGIN

@interface BNViewManager : UIResponder

/** self view  */
@property(nonatomic,strong)UIView *view;

@property(nonatomic,strong)UIView *maskView;

- (void)loadView;// This is where subclasses should create their custom view hierarchy if they aren't using a nib. Should never be called directly.
- (void)viewDidLoad; // Called after the view has been loaded. For view controllers created in code, this is after -loadView. For view controllers unarchived from a nib, this is after the view is set.
- (void)viewWillAppear:(BOOL)animated;    // Called when the view is about to made visible. Default does nothing
- (void)viewDidAppear:(BOOL)animated;     // Called when the view has been fully transitioned onto the screen. Default does nothing
- (void)viewWillDisappear:(BOOL)animated; // Called when the view is dismissed, covered or otherwise hidden. Default does nothing
- (void)viewDidDisappear:(BOOL)animated;  // Called after the view was dismissed, covered or otherwise hidden. Default does nothing
- (void)viewWillLayoutSubviews;     // Called just before the view controller's view's layoutSubviews method is invoked. Subclasses can implement as necessary. The default is a nop.
- (void)viewDidLayoutSubviews;   // Called just after the view controller's view's layoutSubviews method is invoked. Subclasses can implement as necessary. The default is a nop.


#pragma mark -presentedViewManager
- (void)presentViewManager:(BNViewManager *)presentedViewManager Animated:(BOOL)animated completion:(void( ^__nullable)(void))completion;

- (void)presentViewManager:(BNViewManager *)presentedViewManager duration:(CGFloat)duration completion:(void( ^__nullable)(void))completion;;

@property(nullable, nonatomic,readonly)BNViewManager *presentedViewManager  NS_AVAILABLE_IOS(5_0);// The view manager that was presented by this view manager or its nearest ancestor.

/**
 If this view manager is a child of a containing view manager (e.g. a navigation manager or tab bar
 manager,) this is the containing view v.  Note that as of 5.0 this no longer will return the
 presenting view manager.
 */
@property(nonatomic,strong)BNViewManager *parentViewManager;

@end



NS_ASSUME_NONNULL_END
