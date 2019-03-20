//
//  BNHtmlController.m
//  objcReview
//
//  Created by Berning on 2018/11/12.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "BNHtmlController.h"
#import "BNHtmlDetailController.h"

@interface BNHtmlController ()

@property(nonatomic,strong)NSMutableArray *htmls;


@end

@implementation BNHtmlController

- (NSMutableArray *)htmls
{
    if(!_htmls)
    {
        _htmls=[NSMutableArray arrayWithContentsOfURL:[[NSBundle mainBundle]URLForResource:@"html.plist" withExtension:nil] ];
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
    static NSString *ID=@"html";
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
    BNHtmlDetailController *vc=[BNHtmlDetailController new];
    vc.title=self.htmls[indexPath.row];
    [self showViewController:vc sender:nil];
}

@end
