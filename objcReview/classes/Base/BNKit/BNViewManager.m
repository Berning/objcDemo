//
//  BNViewManager.m
//  objcReview
//
//  Created by Berning on 2019/1/26.
//  Copyright © 2019年 Bien. All rights reserved.
//

#import "BNViewManager.h"


@interface BNViewManager ()

@property(nullable, nonatomic,readwrite)BNViewManager *presentedViewManager;

@end

@implementation BNViewManager

//addmask
#pragma view manager cycle
- (UIView *)maskView
{
    if (!_maskView) {
        _maskView=[[UIView alloc] initWithFrame:ckSreenBounds];
        _maskView.backgroundColor=[UIColor clearColor];
    }
    return _maskView;
}
- (instancetype)init
{
    if (self=[super init]) {
        [self loadView];
    }
    return self;
}

- (void)loadView
{
    self.view=[[UIView alloc] initWithFrame:ckSreenBounds];
    self.view.backgroundColor=[UIColor whiteColor];
}


- (void)viewDidLoad
{
    if(self.navigationManager)
    {
        NSUInteger loc=[NSStringFromClass([self class]) rangeOfString:@"Test"].location;
        self.navigationManager.navigationBar.title=[NSStringFromClass([self class]) substringWithRange:NSMakeRange(0, loc)];
    }
}


- (void)viewWillAppear:(BOOL)animated
{}

- (void)viewDidAppear:(BOOL)animated
{}

- (void)viewWillDisappear:(BOOL)animated
{}

-(void)viewDidDisappear:(BOOL)animated
{}

-(void)viewWillLayoutSubviews
{}

- (void)viewDidLayoutSubviews
{}



#pragma mark -present view manager

- (void)presentViewManager:(BNViewManager *)presentedViewManager Animated:(BOOL)animated completion:(void (^)(void))completion
{
    [self presentViewManager:presentedViewManager Animated:animated duration:ckPushDutation completion:completion];
}

- (void)presentViewManager:(BNViewManager *)presentedViewManager duration:(CGFloat)duration completion:(void (^)(void))completion
{
    [self presentViewManager:presentedViewManager Animated:YES duration:duration completion:completion];
}

- (void)presentViewManager:(BNViewManager *)presentedViewManager Animated:(BOOL)animated duration:(CGFloat)duration completion:(void( ^__nullable)(void))completion
{
    
    if((![presentedViewManager isMemberOfClass:[BNNavigationManager class]]) && (![NSStringFromCGRect(presentedViewManager.view.bounds) isEqualToString:NSStringFromCGRect(ckSreenBounds)]))
    {
        NSString *reason=[NSString stringWithFormat:@"Application tried to present modally an active controller <%@: %p>.",NSStringFromClass([presentedViewManager class]),presentedViewManager];
        NSException *exception=[NSException exceptionWithName:NSInvalidArgumentException reason:reason userInfo:nil];
        [exception raise];
    }
    self.presentedViewManager=presentedViewManager;
    
    if ([presentedViewManager isMemberOfClass:[BNNavigationManager class]])
    {
        BNNavigationManager *aPresentedViewManager=(BNNavigationManager *)presentedViewManager;
        [aPresentedViewManager.navigationBar.close addTarget:self action:@selector(dismissView)];
    }
    
    //addSelf
    CGFloat x=0;
    CGFloat y=0;
    CGFloat w=ckMainScreenWidth;
    CGFloat h=ckMainScreenHeight;
    
    if (animated) {
        y=ckMainScreenHeight;
        presentedViewManager.view.frame=CGRectMake(x, y, w, h);
        [UIView animateWithDuration:duration animations:^{
            CGRect rect=presentedViewManager.view.frame;
            rect.origin.y=0;
            presentedViewManager.view.frame=rect;
        }];
    }
    else{
        y=0;
        presentedViewManager.view.frame=CGRectMake(x, y, w, h);
    }
}


- (void)dismissView
{
    if (self.presentedViewManager)
    {
        [UIView animateWithDuration:ckPresentDuration animations:^{
            CGRect rect=self.presentedViewManager.view.frame;
            rect.origin.y=ckMainScreenHeight;
            self.presentedViewManager.view.frame=rect;
            
        } completion:^(BOOL finished) {
            [self.presentedViewManager.maskView removeFromSuperview];
            [self.presentedViewManager.view removeFromSuperview];
            self.presentedViewManager=nil;
        }];
    }
    else
    {
        [UIView animateWithDuration:ckPresentDuration animations:^{
            CGRect rect=BNApplicationWindow.rootViewManager.view.frame;
            rect.origin.y=kMainScreenHeight;
            BNApplicationWindow.rootViewManager.view.frame=rect;
            
        } completion:^(BOOL finished) {
            [BNApplicationWindow.rootViewManager.maskView removeFromSuperview];
            [BNApplicationWindow.rootViewManager.view removeFromSuperview];
            BNApplicationWindow.rootViewManager=nil;
        }];
    }
    

}


#pragma mark -presentedViewManager

- (void)setPresentedViewManager:(BNViewManager *)presentedViewManager
{

    if (BNApplicationWindow.rootViewManager)
    {
        _presentedViewManager=presentedViewManager;
        if(presentedViewManager)
        {
            if (self.navigationManager) {
                [self.navigationManager.view addSubview:presentedViewManager.maskView];
                [self.navigationManager.view addSubview:presentedViewManager.view];
            }
            else
            {
                [self.view addSubview:presentedViewManager.maskView];
                [self.view addSubview:presentedViewManager.view];
            }
            
            if (presentedViewManager.view)
            {
                if ([presentedViewManager isMemberOfClass:[BNNavigationManager class]])
                {
                    BNNavigationManager *aPresentedViewManager=(BNNavigationManager *)presentedViewManager;
                    [aPresentedViewManager.visibleViewManager viewDidLoad];
                }
                else
                {
                    [presentedViewManager viewDidLoad];
                }
            }
        }

    }
    else
    {
        BNApplicationWindow.rootViewManager=presentedViewManager;
    }
}


@end
