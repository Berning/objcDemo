//
//  BNUIController.m
//  UI
//
//  Created by Berning on 2018/12/19.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "BNUIController.h"

//test
#import "BNViewManagerTest.h"
#import "BNTableViewManagerTest.h"
#import "BNCollectionViewManagerTest.h"

#import "BNWaterFlowController.h"
#import "BNProgressController.h"

#import "UIViewControllerTest.h"

@interface BNUIController ()

@property(nonatomic,strong)NSMutableArray *datas;
@property(nonatomic,strong)NSMutableArray *applies;
@property(nonatomic,strong)NSMutableArray *tests;
@property(nonatomic,strong)NSMutableArray *viewControllers;


@end

@implementation BNUIController

#pragma mark -lazy load


-(NSMutableArray *)datas
{
    if(!_datas)
    {
        _datas=[NSMutableArray array];
        [_datas addObject:self.tests];
        [_datas addObject:self.viewControllers];
        [_datas addObject:self.applies];
    }
    return _datas;
}

- (NSMutableArray *)viewControllers
{
    if (!_viewControllers) {
        _viewControllers=[NSMutableArray array];
        [_viewControllers addObject:NSStringFromClass([UIViewControllerTest class])];
    }
    return _viewControllers;
}

-(NSMutableArray *)tests
{
    if(!_tests)
    {
        _tests=[NSMutableArray array];
        [_tests addObject:NSStringFromClass([BNViewMangerTest class])];
        [_tests addObject:NSStringFromClass([BNTableViewManagerTest class])];
        [_tests addObject:NSStringFromClass([BNCollectionViewManagerTest class])];
        
    }
    return _tests;
}

-(NSMutableArray *)applies
{
    if(!_applies)
    {
        _applies=[NSMutableArray array];
        [_applies addObject:NSStringFromClass([BNWaterFlowController class])];
        [_applies addObject:NSStringFromClass([BNProgressController class])];
        
    }
    return _applies;
}


-(instancetype)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}


#pragma mark -tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.datas[section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *ID=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    if (indexPath.section==2) {
        NSUInteger len=[self.datas[indexPath.section][indexPath.row] rangeOfString:@"BN"].length;
        NSUInteger loc=[self.datas[indexPath.section][indexPath.row] rangeOfString:@"Controller"].location;
        cell.textLabel.text=[self.datas[indexPath.section][indexPath.row] substringWithRange:NSMakeRange(len, loc-len)];
    }
    else
    {
        NSUInteger loc=[self.datas[indexPath.section][indexPath.row] rangeOfString:@"Test"].location;
        cell.textLabel.text=[self.datas[indexPath.section][indexPath.row]substringWithRange:NSMakeRange(0, loc)];
    }
    
    return cell;
    
}

#pragma mark -tableView delegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *header=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 40)];
//    header.backgroundColor=[UIColor redColor];
    if (0==section) {
        header.text=@"  BNKit";
    }
    else if (1==section)
    {
        header.text=@"  UITest";
    }
    else if (2==section)
    {
        header.text=@"  Apply";
    }

    return header;

}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UILabel *footer=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 40)];
    footer.backgroundColor=[UIColor yellowColor];
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
//
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    Class class=NSClassFromString(self.datas[indexPath.section][indexPath.row]);
    id obj=[class new];
    if ([obj isKindOfClass:[UIViewController class]]) {
        [self.navigationController pushViewController:obj animated:YES];
        
    }
    else
    {
        //push
//        BNApplicationWindow.rootViewManager=[[BNNavigationManager alloc] initWithRootViewManager:obj];
        
        //modal
        BNViewManager *viewManager=(BNViewManager *)obj;
        BNNavigationManager *nav=[[BNNavigationManager alloc] initWithRootViewManager:viewManager];
        [obj presentViewManager:nav Animated:YES completion:nil];
        
    }
}




@end
