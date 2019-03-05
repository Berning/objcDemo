//
//  BNBaseCollectionViewCell.m
//  objcReview
//
//  Created by Berning on 2019/1/23.
//  Copyright © 2019年 Bien. All rights reserved.
//



#import "BNBaseCollectionViewCell.h"

@interface BNBaseCollectionViewCell ()

@property(nonatomic,weak)UILabel *titleLabel;

@end

@implementation BNBaseCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, self.height/3.0, self.width, self.height/3.0)];
        titleLabel.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:titleLabel];
        self.titleLabel=titleLabel;
        [self setBackgroundColor:[UIColor whiteColor]];
        
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title=title;
    self.titleLabel.text=title;
}

@end
