//
//  BNRecordViewController.m
//  Lottery
//
//  Created by uBerning on 2017/11/4.
//  Copyright © 2017年 BN. All rights reserved.
//

#define BNCOMPLETE @"完成"
#define BNEDIT @"编辑"
#define BNClose @"关闭"
#define BNMutableSelected @"多选"
#define BNCancleMutableSelected @"取消多选"

#import "BNRecordViewController.h"
#import "BNLotterySQLite.h"
#import "BNRecord.h"
@interface BNRecordViewController ()

@property(nonatomic,strong)NSArray *records;

@property(nonatomic,strong)NSMutableArray *unusedRecords;

@property(nonatomic,weak)UIButton *leftBtn;

@property(nonatomic,weak)UIButton *rightBtn;

@end

@implementation BNRecordViewController

-(NSArray *)records
{
    
    if (!_records) {
        _records =[NSArray new];
    }
    return _records;
}

-(NSMutableArray *)unusedRecords
{
    
    if (!_unusedRecords) {
        _unusedRecords =[NSMutableArray new];
    }
    return _unusedRecords;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //nav
    [self setNav];
    
    self.tableView.allowsSelection=NO;
    __weak __typeof(self) weakSelf=self;

    [BNLotterySQLite bnSQLiteRetrieveRecord:^(NSArray *records)
    {
        weakSelf.records=[records reverseObjectEnumerator].allObjects;
    }
    failure:^(NSError *error)
    {
        
    }];
    
}

-(instancetype)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

-(void)setNav
{
    UIButton *leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    leftBtn.titleLabel.textAlignment=NSTextAlignmentLeft;
    [leftBtn.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [leftBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [leftBtn setTitle:BNClose forState:UIControlStateNormal];
    self.leftBtn=leftBtn;
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    [leftBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [rightBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [rightBtn setTitle:BNEDIT forState:UIControlStateNormal];
    self.rightBtn=rightBtn;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [rightBtn addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView.tableFooterView=[UIView new];
}

-(void)edit
{
    self.rightBtn.selected=!self.rightBtn.selected;
    self.tableView.editing=!self.tableView.editing;
    
    if ([self.rightBtn.titleLabel.text isEqualToString:BNCOMPLETE])
    {
        __weak __typeof(self) weakSelf=self;
        for (BNRecord *record in self.unusedRecords)
        {
            [BNLotterySQLite bnSQLiteDeleteRecord:record success:^(NSArray *records)
            {
                weakSelf.records=[records reverseObjectEnumerator].allObjects;
                [weakSelf.tableView reloadData];
            } failure:^(NSError *error)
            {
                
            }];

        }
        
    }
    
    //
    [self.leftBtn setTitle:self.rightBtn.selected?BNMutableSelected:BNClose forState:UIControlStateNormal];
    [self.rightBtn setTitle:self.rightBtn.selected?BNCOMPLETE:BNEDIT forState:UIControlStateNormal];
    
}

- (void)close{
    
    if(![self.leftBtn.titleLabel.text isEqualToString:BNClose])
    {
   
        //多选
        if ([self.leftBtn.titleLabel.text isEqualToString:BNMutableSelected])
        {
            for (int i=0; i<self.records.count; i++)
            {
                NSIndexPath *indexPath=[NSIndexPath indexPathForRow:i inSection:0];
                [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionBottom];
                [self.unusedRecords addObject:[self.records objectAtIndex:indexPath.row]];
            }
        }
        else
        {
            for (int i=0; i<self.records.count; i++)
            {
                NSIndexPath *indexPath=[NSIndexPath indexPathForRow:i inSection:0];
                [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
                [self.unusedRecords removeObject:[self.records objectAtIndex:indexPath.row]];
            }
        }
        
        [self.leftBtn setTitle:self.leftBtn.selected?BNMutableSelected:BNCancleMutableSelected forState:UIControlStateNormal];
        self.leftBtn.selected=!self.leftBtn.selected;

        
    }else
    {
        [self dismissViewControllerAnimated:YES completion:nil];

    }
    
    
}
#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.records.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"reuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    
    BNRecord *record=[self.records objectAtIndex:indexPath.row];
    
    if(![record.seriesNum containsString:@"#"])
    {
        cell.textLabel.textColor=[UIColor redColor];
        cell.textLabel.text=record.seriesNum;
    }else
    {
        NSUInteger sepLoc=[record.seriesNum rangeOfString:@"#"].location;
        NSMutableAttributedString *attrdStr=[[NSMutableAttributedString alloc]initWithString:record.seriesNum];
        [attrdStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, sepLoc)];
        [attrdStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(sepLoc, record.seriesNum.length-sepLoc)];
        [attrdStr replaceCharactersInRange:NSMakeRange(sepLoc, 1) withString:@" "];
        cell.textLabel.attributedText=attrdStr;
    }
    
    cell.detailTextLabel.text=record.date;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.unusedRecords addObject:[self.records objectAtIndex:indexPath.row]];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.unusedRecords removeObject:[self.records objectAtIndex:indexPath.row]];
}

//
//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"row:%ld",(long)indexPath.row);
//
//
//}
//
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;
}


@end
