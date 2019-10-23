//
//  BNBaseTableController.m
//  objcReview
//
//  Created by Berning on 2019/1/7.
//  Copyright © 2019年 BN. All rights reserved.
//

#import "BNTableViewController.h"

@interface BNTableViewController ()

@end

@implementation BNTableViewController

- (UIRefreshControl *)refreshControl
{
    if (!_refreshControl) {
        _refreshControl=[[UIRefreshControl alloc] init];
    }
    return _refreshControl;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self createTableViewIfNeed];
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self.style = style;
    if (self = [super initWithNibName:nil bundle:nil]) {
        [self createTableViewIfNeed];
    }
    return self;
}

-(instancetype)init
{
    if (self=[super init]) {
        [self createTableViewIfNeed];
    }
    return self;
}

- (void)createTableViewIfNeed
{
    if (self.tableView == nil) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:self.style];
        self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorColor = [UIColor lightGrayColor];
        self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.tableView.backgroundView.backgroundColor = [UIColor redColor];
        self.tableView.showsVerticalScrollIndicator = NO;

    }

}

- (void)viewDidLoad
{
    [super viewDidLoad];

//    self.shouldAutomaticallyForwardRotationMethods=YES;
    //automaticallyAdjustsScrollViewInsets  API_DEPRECATED("Use UIScrollView's contentInsetAdjustmentBehavior instead", ios(7.0,11.0),tvos(7.0,11.0)); // Defaults to YES
    
    if ([self.tableView respondsToSelector:@selector(contentInsetAdjustmentBehavior)]) {
        if (@available(iOS 11.0, *)) {
            self.tableView.contentInsetAdjustmentBehavior =UIScrollViewContentInsetAdjustmentAutomatic ;
        }
       
    }

    CGFloat height = self.view.height;
    height -= (self.navigationController) ? kNavigationBarHeight_Portrait : 0;
    [_tableView setFrame:CGRectMake(0,kNavigationBarHeight_Portrait, self.view.width, height)];
    [self.view addSubview:_tableView];

    self.tableView.tableFooterView=[UIView new];


}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark -scollView

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
}
@end
