//
//  BNViewController.m
//  Xcode8
//
//  Created by uBerning on 2017/3/8.
//  Copyright © 2017年 360. All rights reserved.
//

#import "BNViewController.h"


@interface BNViewController ()

@end

@implementation BNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor grayColor];
    
    void (^block)();
    
    __weak __typeof(self) weakself=self;

    block=^{
        weakself.view.backgroundColor=[UIColor cyanColor];
    };
    block();

}

-(void)dealloc
{
    NSLog(@"vc释放了");
}



@end
