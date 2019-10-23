//
//  BNWaterflowView.h
//  waterFlow
//
//  Created by Berning on 14-7-28.
//  Copyright (c) 2014年 BN. All rights reserved.
//  使用瀑布流形式展示内容的控件

#import <UIKit/UIKit.h>

typedef enum {
    BNWaterflowViewMarginTypeTop,
    BNWaterflowViewMarginTypeBottom,
    BNWaterflowViewMarginTypeLeft,
    BNWaterflowViewMarginTypeRight,
    BNWaterflowViewMarginTypeColumn, // 每一列
    BNWaterflowViewMarginTypeRow, // 每一行
} BNWaterflowViewMarginType;

@class BNWaterflowView, BNWaterflowViewCell;

/**
 *  数据源方法
 */
@protocol BNWaterflowViewDataSource <NSObject>
@required
/**
 *  一共有多少个数据
 */
- (NSUInteger)numberOfCellsInWaterflowView:(BNWaterflowView *)waterflowView;
/**
 *  返回index位置对应的cell
 */
- (BNWaterflowViewCell *)waterflowView:(BNWaterflowView *)waterflowView cellAtIndex:(NSUInteger)index;

@optional
/**
 *  一共有多少列
 */
- (NSUInteger)numberOfColumnsInWaterflowView:(BNWaterflowView *)waterflowView;
@end

/**
 *  代理方法
 */
@protocol BNWaterflowViewDelegate <UIScrollViewDelegate>
@optional
/**
 *  第index位置cell对应的高度
 */
- (CGFloat)waterflowView:(BNWaterflowView *)waterflowView heightAtIndex:(NSUInteger)index;
/**
 *  选中第index位置的cell
 */
- (void)waterflowView:(BNWaterflowView *)waterflowView didSelectAtIndex:(NSUInteger)index;
/**
 *  返回间距
 */
- (CGFloat)waterflowView:(BNWaterflowView *)waterflowView marginForType:(BNWaterflowViewMarginType)type;
@end

/**
 *  瀑布流控件
 */
@interface BNWaterflowView : UIScrollView
/**
 *  数据源
 */
@property (nonatomic, weak) id<BNWaterflowViewDataSource> dataSource;
/**
 *  代理
 */
@property (nonatomic, weak) id<BNWaterflowViewDelegate> delegate;

/**
 *  刷新数据（只要调用这个方法，会重新向数据源和代理发送请求，请求数据）
 */
- (void)reloadData;

/**
 *  cell的宽度
 */
- (CGFloat)cellWidth;

/**
 *  根据标识去缓存池查找可循环利用的cell
 */
- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier;

@end
