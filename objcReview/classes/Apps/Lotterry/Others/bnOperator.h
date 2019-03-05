//
//  bnOperator.h
//  Lottery
//
//  Created by Berning on 2018/12/6.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface bnOperator : NSObject

-(void)bnLotteryQueryOperator:(UINavigationController *)navController;

-(void)bnDisplayOperator:(UILabel *)label;

-(void)bnPreviousOperator:(UIImageView *)img label:(UILabel *)label;

-(void)bn3DClickOperator:(UILabel *)label;

-(void)bnNextOperator:(UIImageView *)img label:(UILabel *)label;

-(void)bnDblColOperator:(UILabel *)label;

-(void)bnLottoOperator:(UILabel *)label;

-(void)bnAddHisOperator:(UINavigationController *)navController;

-(void)bnHisChargeOperator:(UINavigationController *)navController;

@end

NS_ASSUME_NONNULL_END
