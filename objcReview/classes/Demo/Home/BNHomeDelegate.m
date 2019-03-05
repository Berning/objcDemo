//
//  BNHomeDelegate.m
//  objcReview
//
//  Created by Berning on 2018/12/30.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BNHomeDelegate.h"
#import "BNCollectionViewCell.h"
#import "BNGroup.h"
#import "BNItem.h"

static NSString * const cellID=@"cell";
static NSString * const headID=@"head";
static NSString * const footID=@"foot";
#define kHeaderFooterHeight 44


@interface BNHomeDelegate ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong)NSArray *data;
@property(nonatomic,copy)BNOption option;

@end

@implementation BNHomeDelegate

+ (instancetype)homeDelegateOfView:(UICollectionView *)collectionView data:(NSArray *)data selectIndex:(BNOption)option
{
    return [[self alloc]initWithView:collectionView data:data selectIndex:option];
}

- (instancetype)initWithView:(UICollectionView *)collectionView data:(NSArray *)data  selectIndex:(BNOption)option

{
    if (self=[super init]) {
        
        collectionView.delegate=self;
        collectionView.dataSource=self;
        
        [collectionView registerClass:[BNCollectionViewCell class] forCellWithReuseIdentifier:cellID];
        [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headID];
        [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footID];

        self.data=data;
        self.option=option;
    }
    return self;
}


#pragma mark -collectionView datasource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.data.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    BNGroup *group=self.data[section];

    return group.items.count;
    
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //1.创建
    BNCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    //2.设置数据
    BNGroup *group=self.data[indexPath.section] ;
    cell.item=[group items][indexPath.item];
    
    //3.返回
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    BNGroup *group=self.data[indexPath.section];
    
    if (kind==UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headID forIndexPath:indexPath];
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 1, headView.width, kHeaderFooterHeight-2)];
        label.backgroundColor=[UIColor whiteColor];
        label.text=[NSString stringWithFormat:@"  %@",group.header];
        [headView addSubview:label];
        return headView;
        
    }
    else if(kind==UICollectionElementKindSectionFooter) {
        UICollectionReusableView *footView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footID forIndexPath:indexPath];
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 1, footView.width, kHeaderFooterHeight-2)];
        label.backgroundColor=[UIColor whiteColor];
        label.text=group.footer;
        [footView addSubview:label];
        return footView;
    }
    return nil;
}


#pragma mark -CollectionView Delegate FlowLayout

/**
 区头大小
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(kMainScreenWidth, kHeaderFooterHeight);
}
/**
 区尾大小
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(kMainScreenWidth, 0);
}


#pragma mark -collectionView delegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    self.option(indexPath.section, indexPath.item);
}


@end
