//
//  BNPickerView.h
//  Xcode8
//
//  Created by uBerning on 2017/3/15.
//  Copyright © 2017年 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNPickerView;

@protocol BNPickerViewDelegate <NSObject>

@optional

-(void)pickerView:(BNPickerView *)pickerView didClickedCancleBarButtonItem:(UIBarButtonItem *)cancleBarButtonItem;

-(void)pickerView:(BNPickerView *)pickerView didClickedConfirmBarButtonItem:(UIBarButtonItem *)confirmBarButtonItem;

@end


@interface BNPickerView : UIView

@property (nonatomic, weak) id<BNPickerViewDelegate> delegate;

@property(weak,nonatomic)UIView *pickerView;


@end
