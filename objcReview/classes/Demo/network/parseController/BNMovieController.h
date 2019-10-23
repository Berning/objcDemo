//
//  BNMovieController.h
//  objcReview
//
//  Created by aBerning on 2019/9/30.
//  Copyright © 2019 Bien. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BNMoviePlayerViewControllerDelegate <NSObject>

- (void)moviePlayerDidFinished;
- (void)moviePlayerDidCapturedWithImage:(UIImage *)image;

- (void)moviePlayerSeekingForward;
- (void)moviePlayerSeekingBackward;

@end


@interface BNMovieController : UIViewController

@property(nonatomic,strong)NSURL *movieUrl;

@property(nonatomic,weak)id<BNMoviePlayerViewControllerDelegate> delegate;

- (void)captureImageWithInterval:(float)interval;


@end

NS_ASSUME_NONNULL_END
