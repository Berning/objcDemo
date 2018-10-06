//
//  bnViewContainer.m
//  coreDataTest
//
//  Created by Berning on 2018/10/6.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "bnViewContainer.h"
#import "bnDataOperation.h"

@interface bnViewContainer ()
@property(nonatomic,weak)UITextField *textField;
@property(nonatomic,strong) bnDataOperation *operationDelegate;

@end

@implementation bnViewContainer


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self setupWithViews];
        self.backgroundColor=[UIColor lightGrayColor];
        self.operationDelegate=[bnDataOperation new];
        self.delegate=self.operationDelegate;
    }
    return self;
    
}
-(void)setupWithViews
{
    CGFloat width=60;
    CGFloat x=60;
    CGFloat height=35;
    CGFloat y=100;
    CGFloat offset=50;
    UIButton *add=[[UIButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
    [add setTitle:@"add" forState:UIControlStateNormal];
    [add setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [add setBackgroundColor:[UIColor cyanColor] ];
    
    //query
    UIButton *query=[[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-x-width, y, width, height)];
    [query setTitle:@"query" forState:UIControlStateNormal];
    [query setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [query setBackgroundColor:[UIColor cyanColor]];
    
    //update
    UIButton *update=[[UIButton alloc] initWithFrame:CGRectMake(x, y+offset, width, height)];
    [update setTitle:@"update" forState:UIControlStateNormal];
    [update setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [update setBackgroundColor:[UIColor cyanColor]];
    
    //delete
    UIButton *delete=[[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-x-width, y+offset, width, height)];
    [delete setTitle:@"delete" forState:UIControlStateNormal];
    [delete setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [delete setBackgroundColor:[UIColor cyanColor]];
    
    //queryCplx
    UIButton *queryCplx=[[UIButton alloc] initWithFrame:CGRectMake(x, y+3*offset, width, height)];
    [queryCplx setTitle:@"queryCplx" forState:UIControlStateNormal];
    [queryCplx setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [queryCplx setBackgroundColor:[UIColor cyanColor]];
    
    
    [self addSubview:add];
    [self addSubview:query];
    [self addSubview:update];
    [self addSubview:delete];
    [self addSubview:queryCplx];
    [add addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    [query addTarget:self action:@selector(query) forControlEvents:UIControlEventTouchUpInside];
    [update addTarget:self action:@selector(update) forControlEvents:UIControlEventTouchUpInside];
    [delete addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
    [queryCplx addTarget:self action:@selector(queryComplex) forControlEvents:UIControlEventTouchUpInside];
    
    
    UITextField *textField=[[UITextField alloc]initWithFrame:CGRectMake(x, y+2*offset, width+offset, height)];
    [self addSubview:textField];
    textField.borderStyle=UITextBorderStyleLine;
    self.textField=textField;
    
    

}


-(void)add
{
    NSLog(@"add1---%@",self.delegate);
    if (self.delegate&&[self.delegate respondsToSelector:@selector(addEmployee)]) {
        [self.delegate addEmployee];

    }
}

-(void)query
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(queryEmployee)]) {
        [self.delegate queryEmployee];
    }

}

-(void)update
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(updateEmployee:)]) {
        [self.delegate updateEmployee:self.textField];
    }

}
-(void)delete
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(deleteEmployee:)]) {
        [self.delegate deleteEmployee:self.textField];
    }

}

-(void)queryComplex
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(queryComplexEmployee:)]) {
        [self.delegate queryComplexEmployee:self.textField];
    }

}

-(void)dealloc
{
    NSLog(@"view dealloc");
}
@end
