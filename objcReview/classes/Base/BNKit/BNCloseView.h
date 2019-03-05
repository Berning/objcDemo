//
//  BNCloseView.h
//  objcReview
//
//  Created by Berning on 2019/1/24.
//  Copyright © 2019年 Bien. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNCloseView : UIView

+ (instancetype)closeView;

- (void)addTarget:(id)target action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
