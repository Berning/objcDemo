//
//  BNHomeDelegate.h
//  objcReview
//
//  Created by Berning on 2018/12/30.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^BNOption)(NSUInteger section,NSUInteger item);

NS_ASSUME_NONNULL_BEGIN

@interface BNHomeDelegate : NSObject

+ (instancetype)homeDelegateOfView:(UICollectionView *)view data:(NSArray *)data selectIndex:(BNOption)option;
@end

NS_ASSUME_NONNULL_END
