//
//  BNCollectionViewCell.h
//  objcReview
//
//  Created by Berning on 2018/12/30.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BNItem;

NS_ASSUME_NONNULL_BEGIN

@interface BNCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)BNItem *item;

@end

NS_ASSUME_NONNULL_END
