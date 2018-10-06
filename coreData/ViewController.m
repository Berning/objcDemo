//
//  ViewController.m
//  coreDataTest
//
//  Created by Berning on 2018/10/4.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "ViewController.h"
#import "bnDataManager.h"
#import "bnViewContainer.h"
@interface ViewController ()


@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [bnDataManager crudWithView:self.view];
}



@end
