//
//  BNFoundationController.m
//  objcReview
//
//  Created by Berning on 2019/1/23.
//  Copyright © 2019年 Bien. All rights reserved.
//

#import "BNFoundationController.h"
#import "BNFoundationCell.h"

//test
#import "NSBundleTest.h"
#import "NSStringTest.h"
#import "NSArrayTest.h"
#import "NSDictionaryTest.h"
#import "NSSetTest.h"


static NSString *const cellID=@"foundation";

@interface BNFoundationController ()
@property(nonatomic,strong)NSMutableArray *datas;

@end

@implementation BNFoundationController

- (NSMutableArray *)datas
{
    if (!_datas) {
        _datas=[NSMutableArray array];
        [_datas addObject:NSStringFromClass([UIDeivceTest class])];
        [_datas addObject:NSStringFromClass([UIScreenTest class])];
        [_datas addObject:NSStringFromClass([UIApplicationTest class])];
        [_datas addObject:NSStringFromClass([NSBundleTest class])];
        [_datas addObject:NSStringFromClass([NSStringTest class])];
        [_datas addObject:NSStringFromClass([NSArrayTest class])];
        [_datas addObject:NSStringFromClass([NSDictionaryTest class])];
        [_datas addObject:NSStringFromClass([NSSetTest class])];

    }
    return _datas;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.collectionView registerClass:[BNFoundationCell class] forCellWithReuseIdentifier:cellID];
    
}


#pragma mark -collection View datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BNFoundationCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    NSUInteger loc=[self.datas[indexPath.item] rangeOfString:@"Test"].location;
    cell.title=[self.datas[indexPath.item] substringWithRange:NSMakeRange(0, loc)];
    return cell;
}

#pragma mark -collection View delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Class class= NSClassFromString(self.datas[indexPath.item]);
    
    //NSProxy (respondsToSelector:)
    if ([class respondsToSelector:@selector(test)]) {
        [class test];
    }else
    {
        [class setTest];
    }
}

@end
