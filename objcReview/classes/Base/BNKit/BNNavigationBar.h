//
//  BNNavigationBar.h
//  objcReview
//
//  Created by Berning on 2019/1/28.
//  Copyright © 2019年 Bien. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNCloseView,BNBack;
@class BNOptionButton;

typedef enum :NSUInteger{
    BNNavigationBarStyleDefault,
    BNNavigationBarStyleModal,
    BNNavigationBarStylePush,
}BNNavigationBarStyle;

NS_ASSUME_NONNULL_BEGIN

@interface BNNavigationBar : UIView

@property(nonatomic,assign)BNNavigationBarStyle navigationBarStyle;

+ (instancetype)navigationBarWithStyle:(BNNavigationBarStyle)navigationBarStyle;

@property(nonatomic,weak)BNCloseView *close;

@property(nonatomic,weak)BNBack *back;

/** navigationBar title  */
@property(nonatomic,weak)NSString *title;

/** navigationBar rightBarItem  */
@property(nonatomic,weak)BNOptionButton *rightBarItem;


@end

NS_ASSUME_NONNULL_END
