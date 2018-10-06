//
//  BNDateTool.m
//  Xcode8
//
//  Created by uBerning on 2017/3/15.
//  Copyright © 2017年 BN. All rights reserved.
//

#import "BNDateTool.h"

@interface BNDateTool ()

@property (nonatomic , strong) NSDate* curDate;

@property (nonatomic , strong) NSDate* weekStartDate;
@property (nonatomic , strong) NSDate* weekEndDate;

@property (nonatomic , strong) NSDate* monthStartDate;


@end

@implementation BNDateTool

+ (instancetype)sharedManager {
    static BNDateTool *_sharedManager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}


-(void) reset
{
    self.curDate = [NSDate date];
    
    self.weekStartDate = nil;
    self.weekEndDate = nil;
    self.monthStartDate = nil;
}


-(NSString*) getBeforeWeekStartDate
{
    NSDate* date = nil;
    if (self.weekStartDate) {
        NSDate *newDate = [[NSDate alloc] initWithTimeIntervalSince1970:([self.weekStartDate timeIntervalSince1970] - 3*24*3600)];
        date = [self calculateWeekStartDate:newDate];
    }
    else{
        date = [self calculateWeekStartDate:[NSDate date]];
    }
    
    if (date) {
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];// you can use your format.
        return [dateFormat stringFromDate:date];
    }
    return @"";
}
-(NSString*) getBeforeWeekEndDate
{
    NSDate* date = nil;
    if (self.weekStartDate) {
        NSDate *newDate = [[NSDate alloc] initWithTimeIntervalSince1970:([self.weekStartDate timeIntervalSince1970] - 3*24*3600)];
        date = [self calculateWeekEndDate:newDate];
    }
    else{
        date = [self calculateWeekEndDate:[NSDate date]];
    }
    
    if (date) {
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];// you can use your format.
        return [dateFormat stringFromDate:date];
    }
    return @"";
}

-(NSString*) getBeforeMonthStartDate
{
    NSDate* date = nil;
    if (self.monthStartDate) {
        NSDate *newDate = [[NSDate alloc] initWithTimeIntervalSince1970:([self.monthStartDate timeIntervalSince1970] - 3*24*3600)];
        date = [self calculateMonthStartDate:newDate];
    }
    else{
        date = [self calculateMonthStartDate:[NSDate date]];
    }
    
    if (date) {
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];// you can use your format.
        return [dateFormat stringFromDate:date];
    }
    return @"";
}



-(void) setBeforeWeekStartAndEndDate
{
    if (self.weekStartDate) {
        NSDate *newDate = [[NSDate alloc] initWithTimeIntervalSince1970:([self.weekStartDate timeIntervalSince1970] - 3*24*3600)];
        self.weekStartDate = [self calculateWeekStartDate:newDate];
        self.weekEndDate = [self calculateWeekEndDate:newDate];
    }
    else{
        self.weekStartDate = [self calculateWeekStartDate:[NSDate date]];
        self.weekEndDate = [self calculateWeekEndDate:[NSDate date]];
    }
    
}


-(void) setBeforeMonthStartDate
{
    if (self.monthStartDate) {
        NSDate *newDate = [[NSDate alloc] initWithTimeIntervalSince1970:([self.monthStartDate timeIntervalSince1970] - 3*24*3600)];
        self.monthStartDate = [self calculateMonthStartDate:newDate];
    }
    else{
        self.monthStartDate = [self calculateMonthStartDate:[NSDate date]];
    }
}

-(NSString*) getWeekStartAndEndDate
{
    
    NSString* str = nil;
    
    if (self.weekStartDate && self.weekEndDate) {
        
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"MM月dd日"];// you can use your format.
        NSString* startDate = [dateFormat stringFromDate:self.weekStartDate];
        NSString* endDate = [dateFormat stringFromDate:self.weekEndDate];
        
        str = [NSString stringWithFormat:@"%@-%@" , startDate , endDate];
    }
    
    return str;
}


-(NSString*) getMonthDate
{
    NSString* str = nil;
    
    if (self.monthStartDate)
    {
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy年MM月"];// you can use your format.
        str = [dateFormat stringFromDate:self.monthStartDate];
    }
    
    return str;
}


-(NSString*) getWeekStartDate
{
    NSString* str = nil;
    
    if (self.weekStartDate)
    {
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];// you can use your format.
        str = [dateFormat stringFromDate:self.weekStartDate];
    }
    
    return str;
}

-(NSString*) getMonthStartDate
{
    NSString* str = nil;
    
    if (self.monthStartDate)
    {
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];// you can use your format.
        str = [dateFormat stringFromDate:self.monthStartDate];
    }
    
    return str;
}



-(NSDate*) calculateWeekStartDate:(NSDate*) date{
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:date];
    NSInteger dayofweek = [[[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:date] weekday];// this will give you current day of week
    [components setDay:([components day] - ((dayofweek) - 2))];// for beginning of the week.
    
    return [gregorian dateFromComponents:components];
}

-(NSDate*) calculateWeekEndDate:(NSDate*) date{
    
    NSCalendar *gregorianEnd = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *componentsEnd = [gregorianEnd components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:date];
    NSInteger Enddayofweek = [[[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:date] weekday];// this will give you current day of week
    [componentsEnd setDay:([componentsEnd day]+(7-Enddayofweek)+1)];// for end day of the week
    
    return [gregorianEnd dateFromComponents:componentsEnd];
}


/**
 * 计算每个月的初的日期
 *
 */

-(NSDate*) calculateMonthStartDate:(NSDate *)date{
    
    NSInteger year,month,day;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    comps = [calendar components:unitFlags fromDate:date];
    year = [comps year];
    month = [comps month];
    day = [comps day];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    return [formatter dateFromString:[NSString stringWithFormat:@"%ld年%ld月1日" , year , month]];
}



/**
 * 计算每个月的天数
 *
 * @param year 年份
 * @param month 月份
 */
- (NSInteger) getDaysOfMonth:(NSInteger) year andMonth:(NSInteger) month
{
    NSMutableArray* arr = [NSMutableArray arrayWithObjects:@"31", @"28", @"31", @"30", @"31", @"30", @"31", @"31", @"30", @"31", @"30", @"31", nil];
    NSInteger days = 0;
    
    if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0){
        arr[1] = @"29"; // 闰年2月29天
    }
    
    if (month - 1 >= 0 && month -1 < arr.count) {
        days = ((NSString*)arr[month-1]).integerValue;
    }
    
    return days;
}


- (void) logDate:(NSDate *)date{
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];// you can use your format.
    NSString* dateString2Prev = [dateFormat stringFromDate:date];
    NSLog(@"date = %@", dateString2Prev);
    
}


-(NSString*) getBeforDate:(NSString*) dateStr
{
    NSString* beforeDate = @"";
    
    if (dateStr) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDate* date = [formatter dateFromString:dateStr];
        NSDate *newDate = [[NSDate alloc] initWithTimeIntervalSince1970:([date timeIntervalSince1970] - 24*3600)];
        beforeDate = [formatter stringFromDate:newDate];
    }
    
    return beforeDate;
}




@end
