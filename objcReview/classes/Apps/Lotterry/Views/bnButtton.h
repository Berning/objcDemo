//
//  bnButtton.h
//  Lottery
//
//  Created by Berning on 2018/12/6.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

@class bnButtton;

NS_ASSUME_NONNULL_BEGIN

typedef void (^blockBtn)(bnButtton *);

@interface bnButtton : UIButton

@property(nonatomic,copy)blockBtn click;


@end

NS_ASSUME_NONNULL_END
