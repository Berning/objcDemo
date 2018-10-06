//
//  bnViewContainer.h
//  coreDataTest
//
//  Created by Berning on 2018/10/6.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol bnViewContainerDelegate <NSObject>

@optional

-(void)addEmployee;
-(void)queryEmployee;
-(void)updateEmployee:(UITextField *)textF;
-(void)deleteEmployee:(UITextField *)textF;
-(void)queryComplexEmployee:(UITextField *)textF;

@end

@interface bnViewContainer : UIView

//
@property(nonatomic,weak)id<bnViewContainerDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
