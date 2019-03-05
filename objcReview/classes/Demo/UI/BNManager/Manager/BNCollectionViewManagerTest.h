//
//  BNCollectionViewManagerTest.h
//  objcReview
//
//  Created by Berning on 2019/1/24.
//  Copyright © 2019年 Bien. All rights reserved.
//

#import "BNViewManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface BNCollectionViewManagerTest : BNViewManager

/**
 you should initial "margin" in your controller before [super viewDidLoad] invoked,if not,default is 1.0f
 */
@property(nonatomic,assign) CGFloat margin;

/**
 you should initial "colomns" in your controller before [super viewDidLoad] invoked,,if not,default is 3
 */
@property(nonatomic,assign)NSUInteger colomns;


/**
 you can register your custom collectionViewCell class
 */
@property(nonatomic,strong)UICollectionView *collectionView;


@end

NS_ASSUME_NONNULL_END
