//
//  ViewController.m
//  MasonryTest
//
//  Created by aBerning on 2019/8/16.
//  Copyright © 2019 Bien. All rights reserved.
//

#import "ViewController.h"

#import "AFNetworking/AFNetworking.h"
#import "Masonry/Masonry.h"

@interface ViewController ()

@end

@implementation ViewController

//-(void)loadView
//{
//    UIScrollView *scroll=[UIScrollView new];
//    scroll.contentSize=CGSizeMake(300, 300);
//    self.view=scroll;
//    self.view.backgroundColor=UIColor.yellowColor;
//
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    UIView *red=UIView.new;
//    red.backgroundColor=UIColor.redColor;
//    [red mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@20);
//        make.top.equalTo(@60);
//        make.width.equalTo(@100);
//        make.height.equalTo(@100);
//    }];
//
//    [self.view addSubview:red];
    
    
    
    
    //    CGPoint
    //    CGSize
    //    CGVector
    //    CGRect
    
    
    //    UIOffset
    //    UIEdgeInsets
    
//    UIScrollView
    NSUInteger pages=10;
    UIScrollView *scrollView=[[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    scrollView.contentSize=CGSizeMake(0, self.view.frame.size.height*pages);
    CGPoint offset= scrollView.contentOffset;
    offset.y+=self.view.frame.size.height;
    scrollView.contentOffset=offset;
    
    
    
    
    
}


@end
