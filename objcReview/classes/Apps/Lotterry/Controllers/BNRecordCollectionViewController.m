//
//  BNRecordCollectionViewController.m
//  Lottery
//
//  Created by Berning on 2018/12/6.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "BNRecordCollectionViewController.h"

@interface BNRecordCollectionViewController ()

@end

@implementation BNRecordCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    self.collectionView.backgroundColor=[UIColor whiteColor];
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    // Do any additional setup after loading the view.
}

-(instancetype)init
{
    CGFloat line=1;
    NSUInteger columns=3;
    CGFloat width=([UIScreen mainScreen].bounds.size.width-(columns-1)*line)/columns;
    CGFloat hight=width;

    UICollectionViewFlowLayout *collectionViewlayout=[[UICollectionViewFlowLayout alloc] init];
    collectionViewlayout.minimumLineSpacing=line;
    collectionViewlayout.minimumInteritemSpacing=line;
    collectionViewlayout.itemSize=CGSizeMake(width,hight);
    // 5.设置四周的内边距
//    collectionViewlayout.sectionInset = UIEdgeInsetsMake(10, 0, 0, 0);

    return [super initWithCollectionViewLayout:collectionViewlayout];
    
}

/*
#pragma mark - Navigation

z- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    cell.backgroundColor=BNRandomColor;
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
