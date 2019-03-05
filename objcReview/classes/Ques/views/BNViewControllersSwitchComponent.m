//
//  BNViewControllersSwitchComponent.m
//  Questions
//
//  Created by Berning on 2018/12/16.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "BNViewControllersSwitchComponent.h"


@interface BNViewControllersSwitchComponent ()<UIScrollViewDelegate>


@property (nonatomic, weak) UIView *titlesView;

@property (nonatomic, strong) NSMutableArray *titleButtons;

@property (nonatomic, weak) UIView *titleBottomView;

@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, weak) UIButton *selectedTitleButton;

@property(nonatomic,strong)UIViewController *controller;


@end

@implementation BNViewControllersSwitchComponent

#pragma mark -公共接口
+ (void)controllersSwitchOnController:(UIViewController *)controller superViewType:(BNSuperViewType)superViewType
{
    if(controller.childViewControllers.count==0)
    {
        UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@" 无子控制器" message:@"请添加至少一个子控制器" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil]];
        [controller presentViewController:alertController animated:YES completion:nil];
        return;
    }
    BNViewControllersSwitchComponent *switchComponent=[self shareViewControllersSwitch];
    switchComponent.frame=controller.view.bounds;
    switchComponent.controller=controller;
    [controller.view addSubview:switchComponent];
    
    [switchComponent setupScrollView];
    [switchComponent setupTitlesView:superViewType];    
    
    
}

-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{}

+ (instancetype)shareViewControllersSwitch
{
    static dispatch_once_t onceToken;
    static BNViewControllersSwitchComponent *_switchComponent;
    dispatch_once(&onceToken, ^{
        _switchComponent=[[BNViewControllersSwitchComponent alloc] init];
    });
    return _switchComponent;
}


#pragma mark -laze load
-(NSMutableArray *)titleButtons
{
    if(!_titleButtons)
    {
        _titleButtons=[NSMutableArray array];
    }
    return _titleButtons;
}


#pragma mark -私有方法

- (void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame: self.bounds];
    // 不要自动调整scrollView的contentInset
    scrollView.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(self.controller.childViewControllers.count * self.width, 0);
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    // 默认显示第0个控制器
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)setupTitlesView:(BNSuperViewType)superViewType
{
    // 标签栏整体
    UIView *titlesView = [[UIView alloc] init];
//    titlesView.backgroundColor = [UIColor colorWithRed:0.937255 green:0.937255 blue:0.956863 alpha:0.5];
    titlesView.frame = CGRectMake(0, 64, self.width/2, 35);
    
    switch (superViewType) {
        case BNSuperViewTypeOnView:
            [self addSubview:titlesView];
            break;
            
        default:
            self.controller.navigationItem.titleView=titlesView;
            break;
    }
    
    self.titlesView = titlesView;

    // 标签栏内部的标签按钮
    NSUInteger count = self.controller.childViewControllers.count;
    CGFloat titleButtonH = titlesView.height;
    CGFloat titleButtonW = titlesView.width / count;
    for (int i = 0; i < count; i++)
    {
        // 创建
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        
        [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:titleButton];
        [self.titleButtons addObject:titleButton];
        
        // 文字
        [titleButton setTitle:[self.controller.childViewControllers[i] title] forState:UIControlStateNormal];
        
        // frame
        titleButton.y = 0;
        titleButton.height = titleButtonH;
        titleButton.width = titleButtonW;
        titleButton.x = i * titleButton.width;
    }
    
    // 标签栏底部的指示器控件
    UIView *titleBottomView = [[UIView alloc] init];
    titleBottomView.backgroundColor = [self.titleButtons.lastObject titleColorForState:UIControlStateSelected];
    titleBottomView.height = 1;
    titleBottomView.y = titlesView.height - titleBottomView.height;
    [titlesView addSubview:titleBottomView];
    self.titleBottomView = titleBottomView;
    
    // 默认点击最前面的按钮
    UIButton *firstTitleButton = self.titleButtons.firstObject;
    [firstTitleButton.titleLabel sizeToFit];
    titleBottomView.width = firstTitleButton.titleLabel.width;
    titleBottomView.centerX = firstTitleButton.centerX;
    [self titleClick:firstTitleButton];
}

#pragma mark - 监听
- (void)titleClick:(UIButton *)titleButton
{
    
    // 控制按钮状态
    self.selectedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.selectedTitleButton = titleButton;
    
    // 底部控件的位置和尺寸
    [UIView animateWithDuration:0.25 animations:^{
        self.titleBottomView.width = titleButton.titleLabel.width;
        self.titleBottomView.centerX = titleButton.centerX;
    }];
    
    // 让scrollView滚动到对应的位置
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = self.width * [self.titleButtons indexOfObject:titleButton];
    [self.scrollView setContentOffset:offset animated:YES];
}


#pragma mark - <UIScrollViewDelegate>
/**
 * 当滚动动画完毕的时候调用（通过代码setContentOffset:animated:让scrollView滚动完毕后，就会调用这个方法）
 * 如果执行完setContentOffset:animated:后，scrollView的偏移量并没有发生改变的话，就不会调用scrollViewDidEndScrollingAnimation:方法
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 取出对应的子控制器
    int index = scrollView.contentOffset.x / scrollView.width;
    UIViewController *willShowChildVc = self.controller.childViewControllers[index];

    // 如果控制器的view已经被创建过，就直接返回
//    if (willShowChildVc.isViewLoaded) return;

    // 添加子控制器的view到scrollView身上
    willShowChildVc.view.frame = scrollView.bounds;
    [scrollView addSubview:willShowChildVc.view];

}

/**
 * 当减速完毕的时候调用（人为拖拽scrollView，手松开后scrollView慢慢减速完毕到静止）
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];

    // 点击按钮
    int index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:self.titleButtons[index]];
}


@end
