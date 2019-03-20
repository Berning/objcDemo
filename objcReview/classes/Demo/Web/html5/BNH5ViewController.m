//
//  BNH5ViewController.m
//  objcReview
//
//  Created by Berning on 2019/3/20.
//  Copyright © 2019年 Bien. All rights reserved.
//

#import "BNH5ViewController.h"
#import "BNH5DetailViewController.h"

@interface BNH5ViewController ()
@property(nonatomic,strong)NSMutableArray *htmls;

@end

@implementation BNH5ViewController

- (NSMutableArray *)htmls
{
    if(!_htmls)
    {
        _htmls=[NSMutableArray arrayWithContentsOfURL:[[NSBundle mainBundle]URLForResource:@"h5.plist" withExtension:nil] ];
    }
    return _htmls;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

#pragma mark -table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.htmls.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID=@"html5";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text=self.htmls[indexPath.row];
    
    return cell;
}


#pragma mark -table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    BNH5DetailViewController *vc=[BNH5DetailViewController new];
    vc.title=self.htmls[indexPath.row];
    [self showViewController:vc sender:nil];
}

@end
