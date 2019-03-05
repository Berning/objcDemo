//
//  bnLabel.h
//  Lottery
//
//  Created by Berning on 2018/12/6.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <UIKit/UIKit.h>
@class bnLabel;
typedef  void(^blockLabel)(bnLabel *);

NS_ASSUME_NONNULL_BEGIN

@interface bnLabel : UILabel

@property(nonatomic,copy)blockLabel click;


@end

NS_ASSUME_NONNULL_END
