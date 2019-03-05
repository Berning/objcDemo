//
//  BNTableViewCellTest.m
//  objcReview
//
//  Created by Berning on 2019/1/26.
//  Copyright © 2019年 Bien. All rights reserved.
//

#import "BNTableViewCellTest.h"

@implementation BNTableViewCellTest

+ (instancetype)cellWithtableView:(UITableView *)tableView
{
    static NSString *ID=@"cell";
    BNTableViewCellTest *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[BNTableViewCellTest alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}


@end
