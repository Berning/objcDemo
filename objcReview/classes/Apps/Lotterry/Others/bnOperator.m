//
//  bnOperator.m
//  Lottery
//
//  Created by Berning on 2018/12/6.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "bnOperator.h"
#import "bnOpenSearchViewController.h"
#import "BNRecord.h"
#import "BNLotterySQLite.h"
#import "BNTableViewController.h"
#import "bnCollectionViewController.h"
#import "NSMutableArray+Sort.h"

@interface bnOperator ()
//模型数组
@property(nonatomic,strong)NSMutableArray *hisArr;

//字符串数组
@property(nonatomic,strong)NSMutableArray *arrAttr;

@property(nonatomic,strong)NSMutableArray *flagArr;

@property(nonatomic,assign)NSInteger flag;

@property(nonatomic,strong)BNRecord *record;

@end

@implementation bnOperator

#pragma mark -lazy load

-(NSMutableArray *)hisArr
{
    if (!_hisArr) {
        _hisArr=[NSMutableArray new];
    }
    return _hisArr;
}

-(NSMutableArray *)arrAttr
{
    if (!_arrAttr) {
        _arrAttr=[NSMutableArray new];
    }
    return _arrAttr;
}

-(NSMutableArray *)flagArr
{
    if (!_flagArr) {
        _flagArr=[NSMutableArray new];
    }
    return _flagArr;
}


-(instancetype)init
{
    if (self=[super init]) {
        self.flag=self.arrAttr.count-1;
        
    }
    return self;
}

#pragma mark -公共接口

-(void)bnLotteryQueryOperator:(UINavigationController *)navController
{
    [navController pushViewController:[bnOpenSearchViewController new] animated:YES];
}


-(void)bnDisplayOperator:(UILabel *)label
{
    [self displayOperator:label];
}

-(void)bnPreviousOperator:(UIImageView *)img label:(UILabel *)label
{
    [self previousOperator:img label:label];

}

-(void)bn3DClickOperator:(UILabel *)label
{
    [self threeDClickOperator:label];

}

-(void)bnNextOperator:(UIImageView *)img label:(UILabel *)label
{
    [self nextOperator:img label:label];

}

-(void)bnDblColOperator:(UILabel *)label
{
    [self dblColOperator:label];

}


-(void)bnLottoOperator:(UILabel *)label
{
    [self lottoOperator:label];

}

-(void)bnAddHisOperator:(UINavigationController *)navController
{
    [self addHisOperator:navController];

}



-(void)bnHisChargeOperator:(UINavigationController *)navController
{
    UIAlertController *alertVC=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"表格显示" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [navController presentViewController:[[UINavigationController alloc]initWithRootViewController:[BNTableViewController new]]
                                   animated :YES completion:^{}] ;
        
    }]];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"区块显示" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [navController pushViewController:[[bnCollectionViewController alloc]init] animated:YES];
    }]];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [navController presentViewController:alertVC animated:YES completion:nil];
    
    
}


#pragma mark -私有方法

-(void)displayOperator:(UILabel *)label
{
    label.text=@"中华人民共和国万岁";
    [self.arrAttr removeAllObjects];
    [self.hisArr removeAllObjects];
    [self.flagArr removeAllObjects];
    self.flag=self.arrAttr.count-1;
    self.record=nil;
}

-(void)previousOperator:(UIImageView *)img label:(UILabel *)label
{
    if(self.flag<=0)
    {
        [UIView animateWithDuration:1.5f animations:^{
            img.alpha=0.3;
        }];
        [UIView animateWithDuration:1.5f animations:^{
            img.alpha=1;
        }];
        return;
        
    }
    self.flag--;
    [self replaceLabl:label];

}

-(void)threeDClickOperator:(UILabel *)label
{
    NSMutableString *seriesNum=[NSMutableString string];
    for (int i=0; i<3; i++) {
        uint32_t a= arc4random_uniform(10);
        
        [seriesNum appendString:[NSString stringWithFormat:@"%i   ",a]];
    }
    
    label.text=seriesNum;
    
    [self.arrAttr addObject:seriesNum];
    self.flag=self.arrAttr.count-1;
    
    BNRecord * record=[BNRecord new];
    self.record=record;
    record.seriesNum=seriesNum;
    record.date=[self date];
    [self.hisArr addObject:record];

}

-(void)nextOperator:(UIImageView *)img label:(UILabel *)label
{
    if(self.flag>=self.arrAttr.count-1)
    {
        [UIView animateWithDuration:1.5f animations:^{
            img.alpha=0.3;
        }];
        [UIView animateWithDuration:1.5f animations:^{
            img.alpha=1;
        }];
        return;
    }
    self.flag++;
    [self replaceLabl:label];

}

-(void)dblColOperator:(UILabel *)label
{
    //1.包含重复球；2.红球不足6个
    NSMutableString *seriesNum=[NSMutableString string];
    NSString *objNum=nil;
    NSMutableArray *arr=[NSMutableArray array];
    uint32_t a=0;
    while (arr.count<6) {
        a= arc4random()%33+1;
        a<10?(objNum=[NSString stringWithFormat:@"0%d",a]):
        (objNum=[NSString stringWithFormat:@"%d",a]);
        while ([arr containsObject:objNum]) {
            a= arc4random()%33+1;
            a<10?(objNum=[NSString stringWithFormat:@"0%d",a]):
            (objNum=[NSString stringWithFormat:@"%d",a]);
        }
        [arr addObject:objNum];
        
        
    }
    
    [arr arraySortArrayByAscend:arr];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [seriesNum appendString:[NSString stringWithFormat:@"%@ ",obj]];
        
    }];
    
    //2.蓝球
    a= arc4random()%16+1;
    a<10?([seriesNum appendString:[NSString stringWithFormat:@"#0%i",a]]):
    ([seriesNum appendString:[NSString stringWithFormat:@"#%i",a]]);
    
    NSUInteger sepLoc=[seriesNum rangeOfString:@"#"].location;
    NSMutableAttributedString *attrdStr=[[NSMutableAttributedString alloc]initWithString:seriesNum];
    [attrdStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, sepLoc)];
    [attrdStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(sepLoc, seriesNum.length-sepLoc)];
    [attrdStr replaceCharactersInRange:NSMakeRange(sepLoc, 1) withString:@" "];
    label.attributedText=attrdStr;
    
    [self.arrAttr addObject:attrdStr];
    self.flag=self.arrAttr.count-1;
    
    BNRecord * record=[BNRecord new];
    self.record=record;
    record.seriesNum=seriesNum;
    record.date=[self date];
    [self.hisArr addObject:record];

}

-(void)lottoOperator:(UILabel *)label
{
    //1.包含重复球；2.红球不足5个
    NSMutableString *seriesNum=[NSMutableString string];
    NSString *objNum=nil;
    NSMutableArray *arr=[NSMutableArray array];
    uint32_t a=0;
    while (arr.count<5)
    {
        a= arc4random()%35+1;
        a<10?(objNum=[NSString stringWithFormat:@"0%d",a]):
        (objNum=[NSString stringWithFormat:@"%d",a]);
        while ([arr containsObject:objNum])
        {
            a= arc4random()%35+1;
            a<10?(objNum=[NSString stringWithFormat:@"0%d",a]):
            (objNum=[NSString stringWithFormat:@"%d",a]);
        }
        [arr addObject:objNum];
    }
    
    [arr arraySortArrayByAscend:arr];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [seriesNum appendString:[NSString stringWithFormat:@"%@ ",obj]];
        
    }];
    
    //2.蓝球
    [arr removeAllObjects];
    while (arr.count<2)
    {
        a= arc4random()%12+1;
        a<10?(objNum=[NSString stringWithFormat:@"0%d",a]):
        (objNum=[NSString stringWithFormat:@"%d",a]);
        while ([arr containsObject:objNum])
        {
            a= arc4random()%12+1;
            a<10?(objNum=[NSString stringWithFormat:@"0%d",a]):
            (objNum=[NSString stringWithFormat:@"%d",a]);
        }
        [arr addObject:objNum];
        
    }
    
    [arr arraySortArrayByAscend:arr];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [seriesNum containsString:@" #"]?
        [seriesNum appendString:[NSString stringWithFormat:@"%@ ",obj]]:
        [seriesNum appendString:[NSString stringWithFormat:@"#%@  ",obj]];
        
    }];
    
    
    NSUInteger sepLoc=[seriesNum rangeOfString:@"#"].location;
    NSMutableAttributedString *attrdStr=[[NSMutableAttributedString alloc]initWithString:seriesNum];
    [attrdStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, sepLoc)];
    [attrdStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(sepLoc, seriesNum.length-sepLoc)];
    [attrdStr replaceCharactersInRange:NSMakeRange(sepLoc, 1) withString:@" "];
    label.attributedText=attrdStr;
    
    [self.arrAttr addObject:attrdStr];
    self.flag=self.arrAttr.count-1;
    
    BNRecord * record=[BNRecord new];
    self.record=record;
    record.seriesNum=seriesNum;
    record.date=[self date];
    [self.hisArr addObject:record];
    
}

-(void)addHisOperator:(UINavigationController *)navController
{
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    BOOL isAdd=![self.flagArr containsObject:self.record.seriesNum]&&self.record;
    BOOL isRepeat=[self.flagArr containsObject:self.record.seriesNum]&&self.record;
    if(isAdd)
    {
        [self.flagArr addObject:self.record.seriesNum];
        [BNLotterySQLite bnSQLiteInsertRecord:self.record success:^(NSString *successStr) {
            alertController.title=self.record.seriesNum;
            alertController.message=successStr;
            UIAlertAction *successAdd=[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:successAdd];
        } failure:^(NSString *failureStr) {
            alertController.message=failureStr;
            UIAlertAction *failureAction=[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:failureAction];
        }];
        
    }else if(isRepeat)
    {
        alertController.message=@"重复加入,请选择别的号码";
        UIAlertAction *repeatAdd=[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:repeatAdd];
    }else
    {
        alertController.message=@"请选择号码";
        UIAlertAction *askAdd=[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:askAdd];
    }
    [ navController presentViewController:alertController animated:YES completion:nil];

}



-(void)replaceLabl:(UILabel *)label
{
    if ([[self.arrAttr objectAtIndex:self.flag] isKindOfClass:[NSString class]])
    {
        label.text= [self.arrAttr objectAtIndex:self.flag];
    }
    else
    {
        label.attributedText=[self.arrAttr objectAtIndex:self.flag];
    }
    
    self.record=[self.hisArr objectAtIndex:self.flag];
}


-(NSString * )date
{
    //    NSDate *date= [NSDate dateWithTimeIntervalSinceNow: [[NSTimeZone systemTimeZone] secondsFromGMTForDate:[NSDate date] ] ];
    
    NSDateFormatter*fmt= [NSDateFormatter new];
    [fmt setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    return [fmt stringFromDate:[NSDate date]];
}


@end
