//
//  BNWaterflowView.m
//  waterFlow
//
//  Created by Berning on 14-7-28.
//  Copyright (c) 2014年 BN. All rights reserved.
//

#import "BNWaterflowView.h"
#import "BNWaterflowViewCell.h"

#define BNWaterflowViewDefaultCellH 70
#define BNWaterflowViewDefaultMargin 8
#define BNWaterflowViewDefaultNumberOfColumns 3

@interface BNWaterflowView()
/**
 *  所有cell的frame数据
 */
@property (nonatomic, strong) NSMutableArray *cellFrames;
/**
 *  正在展示的cell
 */
@property (nonatomic, strong) NSMutableDictionary *displayingCells;
/**
 *  缓存池（用Set，存放离开屏幕的cell）
 */
@property (nonatomic, strong) NSMutableSet *reusableCells;
@end

@implementation BNWaterflowView

#pragma mark - 初始化
- (NSMutableArray *)cellFrames
{
    if (_cellFrames == nil) {
        self.cellFrames = [NSMutableArray array];
    }
    return _cellFrames;
}

- (NSMutableDictionary *)displayingCells
{
    if (_displayingCells == nil) {
        self.displayingCells = [NSMutableDictionary dictionary];
    }
    return _displayingCells;
}

- (NSMutableSet *)reusableCells
{
    if (_reusableCells == nil) {
        self.reusableCells = [NSMutableSet set];
    }
    return _reusableCells;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [self reloadData];

}

#pragma mark - 公共接口
/**
 *  cell的宽度
 */
- (CGFloat)cellWidth
{
    // 总列数
    NSUInteger numberOfColumns = [self numberOfColumns];
    CGFloat leftM = [self marginForType:BNWaterflowViewMarginTypeLeft];
    CGFloat rightM = [self marginForType:BNWaterflowViewMarginTypeRight];
    CGFloat columnM = [self marginForType:BNWaterflowViewMarginTypeColumn];
    return (self.bounds.size.width - leftM - rightM - (numberOfColumns - 1) * columnM) / numberOfColumns;
}

/**
 *  刷新数据
 */
- (void)reloadData
{
    // 清空之前的所有数据
    // 移除正在正在显示cell
    [self.displayingCells.allValues makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.displayingCells removeAllObjects];
    [self.cellFrames removeAllObjects];
    [self.reusableCells removeAllObjects];
    
    // cell的总数
    NSUInteger numberOfCells = [self.dataSource numberOfCellsInWaterflowView:self];
    
    // 总列数
    NSUInteger numberOfColumns = [self numberOfColumns];
    
    // 间距
    CGFloat topM = [self marginForType:BNWaterflowViewMarginTypeTop];
    CGFloat bottomM = [self marginForType:BNWaterflowViewMarginTypeBottom];
    CGFloat leftM = [self marginForType:BNWaterflowViewMarginTypeLeft];
    CGFloat columnM = [self marginForType:BNWaterflowViewMarginTypeColumn];
    CGFloat rowM = [self marginForType:BNWaterflowViewMarginTypeRow];
    
    // cell的宽度
    CGFloat cellW = [self cellWidth];
    
    // 用一个C语言数组存放所有列的最大Y值
    CGFloat maxYOfColumns[numberOfColumns];
    for (int i = 0; i<numberOfColumns; i++) {
        maxYOfColumns[i] = 0.0;
    }
    
    // 计算所有cell的frame
    for (int i = 0; i<numberOfCells; i++) {
        // cell处在第几列(最短的一列)
        NSUInteger cellColumn = 0;
        // cell所处那列的最大Y值(最短那一列的最大Y值)
        CGFloat maxYOfCellColumn = maxYOfColumns[cellColumn];
        // 求出最短的一列
        for (int j = 1; j<numberOfColumns; j++) {
            if (maxYOfColumns[j] < maxYOfCellColumn) {
                cellColumn = j;
                maxYOfCellColumn = maxYOfColumns[j];
            }
        }
        
        // 询问代理i位置的高度
        CGFloat cellH = [self heightAtIndex:i];
        
        // cell的位置
        CGFloat cellX = leftM + cellColumn * (cellW + columnM);
        CGFloat cellY = 0;
        if (maxYOfCellColumn == 0.0) { // 首行
            cellY = topM;
        } else {
            cellY = maxYOfCellColumn + rowM;
        }
        
        // 添加frame到数组中
        CGRect cellFrame = CGRectMake(cellX, cellY, cellW, cellH);
        [self.cellFrames addObject:[NSValue valueWithCGRect:cellFrame]];
        
        // 更新最短那一列的最大Y值
        maxYOfColumns[cellColumn] = CGRectGetMaxY(cellFrame);
    }
    
    // 设置contentSize
    CGFloat contentH = maxYOfColumns[0];
    for (int j = 1; j<numberOfColumns; j++) {
        if (maxYOfColumns[j] > contentH) {
            contentH = maxYOfColumns[j];
        }
    }
    contentH += bottomM;
    self.contentSize = CGSizeMake(0, contentH);
}

/**
 *  当UIScrollView滚动的时候也会调用这个方法
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 向数据源索要对应位置的cell
    NSUInteger numberOfCells = self.cellFrames.count;
    for (int i = 0; i<numberOfCells; i++) {
        // 取出i位置的frame
        CGRect cellFrame = [self.cellFrames[i] CGRectValue];
        
        // 优先从字典中取出i位置的cell
        BNWaterflowViewCell *cell = self.displayingCells[@(i)];
        
        // 判断i位置对应的frame在不在屏幕上（能否看见）
        if ([self isInScreen:cellFrame]) { // 在屏幕上
            if (cell == nil) {
                cell = [self.dataSource waterflowView:self cellAtIndex:i];
                cell.frame = cellFrame;
                [self addSubview:cell];
                
                // 存放到字典中
                self.displayingCells[@(i)] = cell;
            }
        } else {  // 不在屏幕上
            if (cell) {
                // 从scrollView和字典中移除
                [cell removeFromSuperview];
                [self.displayingCells removeObjectForKey:@(i)];
                
                // 存放进缓存池
                [self.reusableCells addObject:cell];
            }
        }
    }
}

- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier
{
    __block BNWaterflowViewCell *reusableCell = nil;
    
    [self.reusableCells enumerateObjectsUsingBlock:^(BNWaterflowViewCell *cell, BOOL *stop) {
        if ([cell.identifier isEqualToString:identifier]) {
            reusableCell = cell;
            *stop = YES;
        }
    }];
    
    if (reusableCell) { // 从缓存池中移除
        [self.reusableCells removeObject:reusableCell];
    }
    return reusableCell;
}

#pragma mark - 私有方法
/**
 *  判断一个frame是否显示在屏幕上
 */
- (BOOL)isInScreen:(CGRect)frame
{
    return (CGRectGetMaxY(frame) > self.contentOffset.y) &&
    (CGRectGetMinY(frame) < self.contentOffset.y + self.bounds.size.height);
}

/**
 *  间距
 */
- (CGFloat)marginForType:(BNWaterflowViewMarginType)type
{
    if ([self.delegate respondsToSelector:@selector(waterflowView:marginForType:)]) {
        return [self.delegate waterflowView:self marginForType:type];
    } else {
        return BNWaterflowViewDefaultMargin;
    }
}
/**
 *  总列数
 */
- (NSUInteger)numberOfColumns
{
    if ([self.dataSource respondsToSelector:@selector(numberOfColumnsInWaterflowView:)]) {
        return [self.dataSource numberOfColumnsInWaterflowView:self];
    } else {
        return BNWaterflowViewDefaultNumberOfColumns;
    }
}
/**
 *  index位置对应的高度
 */
- (CGFloat)heightAtIndex:(NSUInteger)index
{
    if ([self.delegate respondsToSelector:@selector(waterflowView:heightAtIndex:)]) {
        return [self.delegate waterflowView:self heightAtIndex:index];
    } else {
        return BNWaterflowViewDefaultCellH;
    }
}

#pragma mark - 事件处理
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (![self.delegate respondsToSelector:@selector(waterflowView:didSelectAtIndex:)]) return;
    
    // 获得触摸点
    UITouch *touch = [touches anyObject];
    //    CGPoint point = [touch locationInView:touch.view];
    CGPoint point = [touch locationInView:self];
    
    __block NSNumber *selectIndex = nil;
    [self.displayingCells enumerateKeysAndObjectsUsingBlock:^(id key, BNWaterflowViewCell *cell, BOOL *stop) {
        if (CGRectContainsPoint(cell.frame, point)) {
            selectIndex = key;
            *stop = YES;
        }
    }];
    
    if (selectIndex) {
        [self.delegate waterflowView:self didSelectAtIndex:selectIndex.unsignedIntegerValue];
    }
}

@end
