
//
//  BNPickerView.m
//  Xcode8
//
//  Created by uBerning on 2017/3/15.
//  Copyright © 2017年 BN. All rights reserved.
//

#import "BNPickerView.h"
#import "BNDefines.h"

@implementation BNPickerView

-(instancetype)init
{
    if (self=[super init]) {
        [self setupSubViews];
    }
    return self;
}

-(void)setupSubViews
{
    //1.toolBar
    UIToolbar *toolBar=[UIToolbar new];
    toolBar.translatesAutoresizingMaskIntoConstraints=NO;
    [self addSubview:toolBar];
    toolBar.backgroundColor=[UIColor lightGrayColor ];
    
    //1.1.cancleItem
    UIBarButtonItem *cancleItem=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancle:)];
    NSMutableDictionary *cancleAttrs = [NSMutableDictionary dictionary];
    cancleAttrs[NSForegroundColorAttributeName]=BNColorFromRGB(0x5b5b5b);
    [cancleItem setTitleTextAttributes:cancleAttrs forState:UIControlStateNormal];
    
    //1.2.
    UIBarButtonItem *flexItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    //1.3.confirmItem
    UIBarButtonItem *confirmItem=[[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(confirm:)];
    NSMutableDictionary *confirmAttrs = [NSMutableDictionary dictionary];
    confirmAttrs[NSForegroundColorAttributeName] =BNColorFromRGB(0x52995d);
    [confirmItem setTitleTextAttributes:confirmAttrs forState:UIControlStateNormal];
    
    
    NSArray *itemArray=@[cancleItem,flexItem,confirmItem];
    [toolBar setItems:itemArray];
    
    
    
    //2.pickerView
    UIView *pickerView=[UIView new];
    pickerView.translatesAutoresizingMaskIntoConstraints=NO;
    [self addSubview:pickerView];
    self.pickerView=pickerView;
    
#pragma mark --添加约束
    
    NSDictionary *views=NSDictionaryOfVariableBindings(toolBar,pickerView);
    
    //1.toolBar
    NSArray *toolBarH=[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[toolBar]|" options:0 metrics:nil views:views];
    [self addConstraints:toolBarH];
    
    NSArray *toolBarV=[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[toolBar(==44)]" options:0 metrics:nil views:views];
    [self addConstraints:toolBarV];
    
    //2.pickerView
    NSArray *pickerViewH=[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[pickerView]|" options:0 metrics:nil views:views];
    [self addConstraints:pickerViewH];
    
    NSArray *pickerViewV=[NSLayoutConstraint constraintsWithVisualFormat:@"V:[toolBar][pickerView(==162)]|" options:0 metrics:nil views:views];
    [self addConstraints:pickerViewV];
    
}


-(void)cancle:(UIBarButtonItem *)cancleItem
{
    if ([self.delegate respondsToSelector:@selector(pickerView:didClickedCancleBarButtonItem:)]) {
        [self.delegate pickerView:self didClickedCancleBarButtonItem:cancleItem];
    }
    
}

-(void)confirm:(UIBarButtonItem *)confirmItem
{
    if ([self.delegate respondsToSelector:@selector(pickerView:didClickedConfirmBarButtonItem:)]) {
        [self.delegate pickerView:self didClickedConfirmBarButtonItem:confirmItem];
    }
    
}

@end
