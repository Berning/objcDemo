//
//  BNDemoController.m
//  Xcode8
//
//  Created by uBerning on 2017/3/12.
//  Copyright © 2017年 BN. All rights reserved.
//

#import "BNDemoController.h"
#import "BNHomeDelegate.h"
#import "BNGroup.h"

//controllers
#import "BNFoundationController.h"
#import "BNUIController.h"
#import "BNThreadController.h"
#import "BNDataBaseController.h"
#import "BNNetWorkController.h"

#import "BNHtmlController.h"

@interface BNDemoController ()

@property(nonatomic,strong)BNHomeDelegate *delegate;

@end

@implementation BNDemoController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=@"必恩";

    BNGroup *group1=[BNGroup groupWithTpye:BNGroupTypeObjc];
    BNGroup *group2=[BNGroup groupWithTpye:BNGroupTypeC];
    BNGroup *group3=[BNGroup groupWithTpye:BNGroupTypeWeb];
    BNGroup *group4=[BNGroup groupWithTpye:BNGroupTypeAlgorithm];
    NSArray *data=@[group1,group2,group3,group4];
    
    __weak typeof(self) weakSelf=self;
    self.delegate=[BNHomeDelegate homeDelegateOfView:self.collectionView data:data selectIndex:^(NSUInteger section, NSUInteger item) {
        switch (section) {
            case 0:
                [weakSelf sectionZero:item];
                break;
            case 2:
                [weakSelf sectionTwo:item];
                break;
            default:
                break;
        }
        
    }];
    

}

#pragma mark -sectionTwo

- (void)sectionTwo:(NSUInteger)item
{
    switch (item) {
        case 0:
            [self.navigationController pushViewController:[BNHtmlController new] animated:YES];
            break;
            
        default:
            break;
    }
    
    
}
#pragma mark -sectionZero

- (void)sectionZero:(NSUInteger)item
{
    
    switch (item) {
        case 0:
            [self.navigationController pushViewController:[BNFoundationController new] animated:YES];
            break;
        case 1:
            [self.navigationController pushViewController:[BNUIController new] animated:YES];
            break;
        case 2:
            [self.navigationController pushViewController:[BNThreadController new] animated:YES];
            break;
        case 3:
            [self.navigationController pushViewController:[BNNetWorkController new] animated:YES];
            break;
            
        case 4:
            [self.navigationController pushViewController:[BNDataBaseController new] animated:YES];
            break;

        default:
            break;
    }
}



@end
