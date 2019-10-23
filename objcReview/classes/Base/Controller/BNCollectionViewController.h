//
//  BNBaseCollectionController.h
//  objcReview
//
//  Created by Berning on 2019/1/8.
//  Copyright © 2019年 BN. All rights reserved.
//

#import "BNViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BNCollectionViewController : BNViewController<UICollectionViewDataSource,UICollectionViewDelegate>

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
