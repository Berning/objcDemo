//
//  BNDataBaseController.m
//  objcReview
//
//  Created by Berning on 2019/1/7.
//  Copyright © 2019年 BN. All rights reserved.
//

#import "BNDataBaseController.h"

//store type
#import "BNSandBox.h"
#import "BNBaseStore.h"
#import "BNSQLite.h"
#import "BNCoreData.h"
#import "BNDataManager.h"

@interface BNDataBaseController ()

@property(nonatomic,strong)NSMutableArray *stores;


@end

@implementation BNDataBaseController

-(NSMutableArray *)stores
{
    if(!_stores)
    {
        _stores=[NSMutableArray array];
    }
    return _stores;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.stores addObject:NSStringFromClass([BNSandBox class])];
    [self.stores addObject:NSStringFromClass([BNBaseStore class])];
    [self.stores addObject:NSStringFromClass([BNSQLite class])];
    [self.stores addObject:NSStringFromClass([BNCoreData class])];
    [self.stores addObject:NSStringFromClass([BNDataManager class])];


}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.stores.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID=@"store";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }

    NSUInteger len=[self.stores[indexPath.row] rangeOfString:@"BN"].length;
    NSUInteger allen=[self.stores[indexPath.row] length];
    
    NSString *name=[self.stores[indexPath.row] substringWithRange:NSMakeRange(len, allen-len)];
    

    cell.textLabel.text=name;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    

    if ([NSClassFromString(self.stores[indexPath.row]) respondsToSelector:@selector(test)])
    {
        [NSClassFromString(self.stores[indexPath.row]) test];

    }
    
}




@end
