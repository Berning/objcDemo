//
//  BNNavigationBar.m
//  objcReview
//
//  Created by Berning on 2019/1/28.
//  Copyright © 2019年 Bien. All rights reserved.
//

#import "BNNavigationBar.h"

@interface BNNavigationBar ()

@property(nonatomic,weak)UILabel *titleLabel;

@end

@implementation BNNavigationBar

+ (instancetype)navigationBarWithStyle:(BNNavigationBarStyle)navigationBarStyle
{
    return [[BNNavigationBar alloc] initWithFrame:CGRectMake(0, 0,ckMainScreenWidth, ckNavigationBarHeight) navigationBarType:navigationBarStyle];
}

- (instancetype)initWithFrame:(CGRect)frame navigationBarType:(BNNavigationBarStyle)navigationBarStyle
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=BNNavigationBarColor;
        //navigationBar subViews
        
        switch (navigationBarStyle) {
        case BNNavigationBarStyleDefault:
            {
                

            }
            break;
        case BNNavigationBarStyleModal:
            {
                BNCloseView *close=[BNCloseView closeView];
                [self addSubview:close];
                self.close=close;
                
                BNOptionButton *rightBarItem=[BNOptionButton listView];
                [self addSubview:rightBarItem];
                self.rightBarItem=rightBarItem;
            }
            break;
        case BNNavigationBarStylePush:
            {
                BNBack *back=[[BNBack alloc ] initWithFrame:CGRectMake(0, ckApplicationStatusBarHeight, 55, ckNavBarHeight)];
                [self addSubview:back];
                self.back=back;
            }
            break;
        default :
            break;
                
        }
        
        CGFloat titleX=self.width-60;
        CGFloat titleW=self.width-2*titleX;
        CGFloat titleY=ckApplicationStatusBarHeight;
        CGFloat titleH=self.height-titleY;
        UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(titleX, titleY, titleW, titleH)];
        titleLabel.textAlignment=NSTextAlignmentCenter;
        [titleLabel setFont:[UIFont boldSystemFontOfSize:18.0f]];
        [self addSubview:titleLabel];
        self.titleLabel=titleLabel;

    }
    return self;
}


- (void)setTitle:(NSString *)title
{
    _title=title;
    self.titleLabel.text=title;
}
@end
