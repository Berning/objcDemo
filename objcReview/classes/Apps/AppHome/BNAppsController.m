//
//  BNAppsController.m
//  objcReview
//
//  Created by Berning on 2019/1/1.
//  Copyright © 2019年 BN. All rights reserved.
//

#import "BNAppsController.h"
#import "BNAppCollectionViewCell.h"
#import "BNLotteryController.h"


static NSString * const cellID=@"cell";

@interface BNAppsController ()

@property(nonatomic,strong)NSMutableArray *viewControllers;

@end

@implementation BNAppsController

-(NSMutableArray *)viewControllers
{
    if(!_viewControllers)
    {
        _viewControllers=[NSMutableArray array];
    }
    return _viewControllers;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.viewControllers addObject:NSStringFromClass([BNLotteryController class])];

    [self.collectionView registerClass:[BNAppCollectionViewCell class] forCellWithReuseIdentifier:cellID];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.viewControllers.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BNAppCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    NSUInteger len=[self.viewControllers[indexPath.item] rangeOfString:@"BN"].length;
    NSUInteger loc=[self.viewControllers[indexPath.item] rangeOfString:@"Con"].location;
    NSString *name=[self.viewControllers[indexPath.item] substringWithRange:NSMakeRange(len, loc-len)];
    
    cell.title=name;
    return cell;
}


#pragma mark -collectionView delegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Class class=NSClassFromString(self.viewControllers[indexPath.item]);
    [self.navigationController pushViewController:[class new] animated:YES];
}



@end
