//
//  BNBaseCollectionController.m
//  objcReview
//
//  Created by Berning on 2019/1/8.
//  Copyright © 2019年 BN. All rights reserved.
//

#import "BNCollectionViewController.h"
#import "BNBaseCollectionViewCell.h"

static NSString * const cellID=@"cellBase";
static NSString * const headID=@"headBase";
static NSString * const footID=@"footBase";


@interface BNCollectionViewController ()

@property(nonatomic,strong)UICollectionViewLayout *layout;

@end

@implementation BNCollectionViewController



- (void)createCollectionViewIfNeed
{
    CGFloat margin;
    NSUInteger colomns;
    (self.margin==0)?(margin=1.0f):(margin=self.margin);
    (self.colomns==0)?(colomns=3):(colomns=self.colomns);
    CGFloat itemWidth=(self.view.width-(colomns-1)*margin)/colomns;
    CGFloat itemHeight=itemWidth;
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing=margin;
    layout.minimumInteritemSpacing=margin;
    layout.itemSize=CGSizeMake(itemWidth, itemHeight);

    //collectionView
    _collectionView=[[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    _collectionView.dataSource=self;
    _collectionView.delegate=self;
    [self.view addSubview:_collectionView];
    
    [self.collectionView registerClass:[BNBaseCollectionViewCell class] forCellWithReuseIdentifier:cellID];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headID];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footID];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createCollectionViewIfNeed];

}



#pragma mark -collectionView datasource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark -collectionView delegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"section-%lu,row-%lu",indexPath.section,indexPath.row);
}

@end
