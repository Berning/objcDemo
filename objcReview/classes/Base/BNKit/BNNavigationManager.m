//
//  BNNavigationManager.m
//  objcReview
//
//  Created by Berning on 2019/1/27.
//  Copyright © 2019年 Bien. All rights reserved.
//

#import "BNNavigationManager.h"


@interface BNNavigationManager ()

@property(nullable, nonatomic,readwrite,strong) BNViewManager *visibleViewManager;

@property(nullable, nonatomic,readwrite,strong) BNViewManager *topViewManager;


@property(nonatomic,weak) BNBack *back;

@end

@implementation BNContainerView

@end

@implementation BNNavigationManager

- (instancetype)initWithRootViewManager:(BNViewManager *)rootViewManager
{
    self.visibleViewManager=rootViewManager;
    rootViewManager.navigationManager=self;
    self.maskView=rootViewManager.maskView;

    //selfView
    BNContainerView *view=[[BNContainerView alloc] initWithFrame:rootViewManager.view.frame];
    self.view=view;
    
    //navigationBar
    
    [self setPresentNavigationBar];
//    [self setPushNavigationBar];

    //viewManager view
    CGRect rect=rootViewManager.view.frame;
    rect.origin.x=0;
    rect.origin.y=ckNavigationBarHeight;
    rect.size.height=rootViewManager.view.frame.size.height-ckNavigationBarHeight;
    rootViewManager.view.frame=rect;
    [view addSubview:rootViewManager.view];
    
    return self;
}


- (void)setPresentNavigationBar
{
    //navigationBar
    BNNavigationBarStyle navigationBarStyle=BNNavigationBarStyleModal;
    if (!BNApplicationWindow.rootViewManager)
    {
//        navigationBarStyle=BNNavigationBarStyleDefault;
    }
    BNNavigationBar *navigationBar=[BNNavigationBar navigationBarWithStyle:navigationBarStyle];
    [self.view addSubview:navigationBar];
    self.navigationBar=navigationBar;
}



#pragma mark -push


- (void)pushViewManager:(BNViewManager *)viewManager animated:(BOOL)animated
{
    //addSelf
    CGFloat w=ckMainScreenWidth;
    CGFloat h=ckMainScreenHeight-self.navigationBar.height;
    CGFloat x=w;
    CGFloat y=self.navigationBar.height;
    viewManager.view.frame=CGRectMake(x, y, w, h);
    
    CGRect rect=viewManager.maskView.frame;
    rect.origin.y=ckNavigationBarHeight;
    viewManager.maskView.frame=rect;
    
    self.topViewManager=viewManager;
    
    if (animated) {
        
        [UIView animateWithDuration:ckPushDutation animations:^{
            CGRect rect=viewManager.view.frame;
            rect.origin.x=0;
            viewManager.view.frame=rect;
        }];
    }
    else{
        x=0;
        viewManager.view.frame=CGRectMake(x, y, w, h);
    }
    
}


- (void)setPushNavigationBar
{
    //navigationBar
    BNNavigationBar *navigationBar=[BNNavigationBar navigationBarWithStyle:BNNavigationBarStylePush];
    [self.view addSubview:navigationBar];
    self.navigationBar=navigationBar;
    [navigationBar.back addTarget:self action:@selector(popOver)];
    
    //navigationBar subViews
}

- (void)popOver
{
    [UIView animateWithDuration:ckPushDutation animations:^{
        CGRect rect=self.topViewManager.view.frame;
        rect.origin.x=ckMainScreenWidth;
        self.topViewManager.view.frame=rect;
        
    } completion:^(BOOL finished) {
        
        [self.topViewManager.maskView removeFromSuperview];
        [self.topViewManager.view removeFromSuperview];
        self.topViewManager.navigationManager=nil;
    }];
}

- (void)setTopViewManager:(BNViewManager *)topViewManager
{
    _topViewManager=topViewManager;
    [self.view addSubview:topViewManager.maskView];
    [self.view addSubview:topViewManager.view];
    if (topViewManager.view) {
        topViewManager.navigationManager=self;
        [topViewManager viewDidLoad];
    }
}


@end


@implementation BNViewManager (BNNavigation)

static const double key;

- (void)setNavigationManager:(BNNavigationManager *)navigationManager
{
    objc_setAssociatedObject(self,&key,navigationManager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

- (BNNavigationManager *)navigationManager
{
    return  (BNNavigationManager *)objc_getAssociatedObject(self,&key);

}

@end
