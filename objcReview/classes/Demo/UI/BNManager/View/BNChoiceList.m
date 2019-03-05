//
//  BNChoiceList.m
//  objcReview
//
//  Created by Berning on 2019/1/25.
//  Copyright © 2019年 Bien. All rights reserved.
//

#import "BNChoiceList.h"

@interface BNChoiceList ()

@property(nonatomic,strong)NSArray *data;


@end

@implementation BNChoiceList


- (instancetype)initWithFrame:(CGRect)frame data:(NSArray *)data
{
    if (self=[super initWithFrame:frame]) {
        self.delegate=self;
        self.dataSource=self;
        self.separatorColor=BNColor(96, 96, 96);
        self.scrollEnabled=NO;
        self.data=data;
    }
    return self;
}


#pragma mark -tableview data source

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID=@"choice";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    //蓝色 ???
//    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    cell.selectedBackgroundView = [UIView new];
    cell.selectedBackgroundView.backgroundColor = BNColor(86, 86, 86);
    cell.backgroundColor=BNColor(76, 76, 76);
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    cell.textLabel.text=self.data[indexPath.row];
    return cell;
}



#pragma mark -tableview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
