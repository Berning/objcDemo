//
//  bnSubView.m
//  Lottery
//
//  Created by Berning on 2018/12/5.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "bnSubView.h"
#import "bnImageView.h"
#import "bnButtton.h"
#import "bnLabel.h"
#import "bnOperator.h"

@interface bnSubView ()

@property(nonatomic,strong)bnLabel *labl;

@property(nonatomic,weak)UIImageView *img ;

@property(nonatomic,strong)UINavigationController *navController;

@end

@implementation bnSubView

+(void)subViewAddWithNavigationController:(UINavigationController *)navController WithFrame:(CGRect)frame InView:(UIView *)view
{
    
    bnSubView *subView=[[self alloc] initWithFrame:frame];
    subView.navController=navController;
    [view addSubview:subView];
}


-(instancetype)initWithFrame:(CGRect)frame
{
    //view 的init 方法默认调用了initWithFrame
    
//    NSLog(@"initWithFrame");
    if(self=[super initWithFrame:frame])
    {
        [self childViews];
    }
    return  self;
}

-(void)childViews
{
    __weak typeof(self) weakSelf=self;
    bnOperator *oprator=[bnOperator new];
    
    CGFloat queryW=110;
    CGFloat queryH=35;
    CGFloat queryY=75;
    CGFloat queryX=self.frame.size.width-queryW-10;
    
    bnButtton *query=[[bnButtton alloc]initWithFrame:CGRectMake(queryX, queryY, queryW, queryH)];
    [query setTitle:@"开奖查询" forState:UIControlStateNormal];
    query.backgroundColor=[UIColor redColor];
    [self addSubview:query];
    
    query.click = ^(bnButtton * _Nonnull btn) {
        [oprator bnLotteryQueryOperator:self.navController];
    };

    
    //label
    self.labl=[bnLabel new];
    self.labl.frame=CGRectMake(25, 100, self.frame.size.width-50, 80);
    [self addSubview: self.labl];
    self.labl.text=@"毛爷爷、习大大，我只想中个二等奖啊...";
    self.labl.textAlignment=NSTextAlignmentCenter;
    self.labl.adjustsFontSizeToFitWidth=YES;
    self.labl.font=[UIFont boldSystemFontOfSize:30];
    self.labl.textColor=[UIColor redColor];
    self.labl.click = ^(bnLabel *label) {
        [oprator bnDisplayOperator:weakSelf.labl];
    };

    
    //img
    CGFloat leftSide=(self.frame.size.width-230)/2.0;
    bnImageView *img=[[bnImageView alloc]initWithFrame:CGRectMake(leftSide, 222, 230, 230)];
    self.img=img;
    img.contentMode=UIViewContentModeCenter;
    [self addSubview:img];
    [img setImage:[UIImage imageNamed:@"nike.jpg"]];
    img.click = ^(bnImageView *img) {
        [oprator bn3DClickOperator:weakSelf.labl];
    };

    //previous
    bnButtton *previous=[[bnButtton alloc]initWithFrame:CGRectMake(0, 297, leftSide, 80)];
    [self addSubview:previous];
    [previous setBackgroundImage:[UIImage imageNamed:@"previous"] forState:UIControlStateNormal];
    previous.click = ^(bnButtton * _Nonnull btn) {
        [oprator bnPreviousOperator:img label:weakSelf.labl];
    };
    


    //next
    bnButtton *next=[[bnButtton alloc]initWithFrame:CGRectMake(leftSide+230, 297, leftSide, 80)];
    [self addSubview:next];
    [next setBackgroundImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];

    next.click = ^(bnButtton * _Nonnull btn) {
        [oprator bnNextOperator:img label:weakSelf.labl];
    };


    //btns
    CGFloat x=60;
    CGFloat w=120;
    CGFloat h=100;
    CGFloat y=self.frame.size.height-100-h;
    
    bnButtton *colBall=[[bnButtton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    [colBall setBackgroundImage:[UIImage imageNamed:@"timor1"] forState:UIControlStateNormal];
    [self addSubview:colBall];
    colBall.click = ^(bnButtton * _Nonnull btn) {
        [oprator bnDblColOperator:weakSelf.labl];
    };

    bnButtton *lotto=[[bnButtton alloc]initWithFrame:CGRectMake(self.frame.size.width-x-w, y, w, h)];
    [self addSubview:lotto];
    [lotto setBackgroundImage:[UIImage imageNamed:@"timor2"] forState:UIControlStateNormal];
    lotto.click = ^(bnButtton * _Nonnull btn) {
        [oprator bnLottoOperator:weakSelf.labl];
    };


    //addHis
    bnButtton *addHis=[[bnButtton alloc]initWithFrame:CGRectMake(x, y+25+h, 100, 40)];
    [self addSubview:addHis];
    [addHis setTitle:@"加入购买" forState:UIControlStateNormal];
    [addHis setBackgroundColor:[UIColor blueColor]];
    
    addHis.click = ^(bnButtton * _Nonnull btn) {
        [oprator bnAddHisOperator:weakSelf.navController];
    };

    //hisCharge
    bnButtton *hisCharge=[[bnButtton alloc]initWithFrame:CGRectMake(self.frame.size.width-x-100, y+25+h, 100, 40)];
    [self addSubview:hisCharge];
    [hisCharge setTitle:@"历史购买" forState:UIControlStateNormal];
    [hisCharge setBackgroundColor:[UIColor blueColor]];
    
    hisCharge.click = ^(bnButtton * _Nonnull btn) {
        [oprator bnHisChargeOperator:weakSelf.navController];
    };


}

@end
