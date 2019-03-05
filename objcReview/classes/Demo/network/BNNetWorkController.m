//
//  BNNetWorkController.m
//  objcReview
//
//  Created by Berning on 2019/1/15.
//  Copyright © 2019年 Bien. All rights reserved.
//
static NSString * const CellID=@"netWork";

#import "BNNetWorkController.h"
#import "BNNetWorkCell.h"

#import "NSURLTest.h"
#import "NSURLRequestTest.h"
#import "NSURLResponseTest.h"
#import "NSURLConnectionTest.h"
#import "NSURLSessionTest.h"
#import "AFNetworkingTest.h"

@interface BNNetWorkController ()
@property(nonatomic,strong)NSMutableArray *netWorks;

@end

@implementation BNNetWorkController

- (NSMutableArray *)netWorks
{
    if (!_netWorks) {
        _netWorks=[NSMutableArray array];
        [_netWorks addObject:NSStringFromClass([NSURLTest class])];
        [_netWorks addObject:NSStringFromClass([NSURLRequestTest class])];
        [_netWorks addObject:NSStringFromClass([NSURLResponseTest class])];
        [_netWorks addObject:NSStringFromClass([NSURLConnectionTest class])];
        [_netWorks addObject:NSStringFromClass([NSURLSessionTest class])];
        [_netWorks addObject:NSStringFromClass([AFNetworkingTest class])];

    }
    return _netWorks;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.collectionView registerClass:[BNNetWorkCell class] forCellWithReuseIdentifier:CellID];
    
}


#pragma mark -collection View datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.netWorks.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BNNetWorkCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
    
    NSUInteger loc=[self.netWorks[indexPath.item] rangeOfString:@"Test"].location;
    cell.title=[self.netWorks[indexPath.item] substringWithRange:NSMakeRange(0, loc)];
    return cell;
}

#pragma mark -collection View delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Class class=NSClassFromString(self.netWorks[indexPath.item]);
    [class test];
}

@end
