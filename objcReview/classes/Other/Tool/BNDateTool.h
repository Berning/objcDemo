//
//  BNDateTool.h
//  Xcode8
//
//  Created by uBerning on 2017/3/15.
//  Copyright © 2017年 BN. All rights reserved.
//
//  负责日期操作，计算周开始的时间和结束时间，计算月开始时间，判断是周几等和日期相关的操作

#import <Foundation/Foundation.h>

@interface BNDateTool : NSObject

+ (instancetype)sharedManager;

-(void) reset;

//根据当前时间或者上周日时间计算前一周的周一
-(NSString*) getBeforeWeekStartDate;

//根据当前时间或者上周日时间计算前一周的周日
-(NSString*) getBeforeWeekEndDate;

//根据当前时间或者上个月1日时间计算前一个月的1日
-(NSString*) getBeforeMonthStartDate;

//根据当前时间或者上周日时间计算前一周的周一存到成员变量
-(void) setBeforeWeekStartAndEndDate;

//根据当前时间或者上周日时间计算前一周的周日存到成员变量
//-(void) setBeforeWeekEndDate;

//根据当前时间或者上个月1日时间计算前一个月的1日保存成员变量
-(void) setBeforeMonthStartDate;


-(NSString*) getWeekStartAndEndDate;
-(NSString*) getMonthDate;

-(NSString*) getWeekStartDate;
-(NSString*) getMonthStartDate;

-(NSString*) getBeforDate:(NSString*) dateStr;



@end
