//
//  bnImageView.h
//  Lottery
//
//  Created by Berning on 2018/12/6.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

@class bnImageView;

typedef  void (^blcokImageView)(bnImageView *);
NS_ASSUME_NONNULL_BEGIN


@interface bnImageView : UIImageView

@property(nonatomic,copy)blcokImageView click;


@end

NS_ASSUME_NONNULL_END
