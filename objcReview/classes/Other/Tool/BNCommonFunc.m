//
//  BNCommonFunc.m
//  Xcode8
//
//  Created by uBerning on 2017/3/15.
//  Copyright © 2017年 BN. All rights reserved.
//

#import "BNCommonFunc.h"

@implementation BNCommonFunc

+(NSString*) getFormatNumStr:(float) num
{
    float kNum = num / 1000;
    NSString* str = @"";
    
    if (kNum == 0){
        str = [NSString stringWithFormat:@"%.f",kNum];
    }
    else if (kNum < 1) {
        str = [NSString stringWithFormat:@"%.3f", kNum];
    }
    else if(kNum < 10){
        str = [NSString stringWithFormat:@"%.2f", kNum];
    }
    else if(kNum < 100){
        str = [NSString stringWithFormat:@"%.1f" , kNum];
    }
    else {
        str = [NSString stringWithFormat:@"%.f" , kNum];
    }
    
    return str;
}


+(NSString*) getFormatTimeStr:(float) min{
    
    NSString* formatStr = @"0";
    
    float thour =  min / 60;
    int tMin = (int)min % 60;
    int tgMin = ((tMin *100)/60 ) % 10;
    if (thour > 0) {
        
        if (tMin == 0) {
            formatStr = [NSString stringWithFormat:@"%.f" , thour];
        }
        else if(tgMin == 0){
            formatStr = [NSString stringWithFormat:@"%.1f" , thour];
        }
        else{
            formatStr = [NSString stringWithFormat:@"%.2f" , thour];
        }
    }
    
    return formatStr;
}

+(NSString*) getFormatTimeHourMinStr:(float) min
{
    NSString* formatStr = @"0分钟";
    
    int thour = (int)min / 60;
    int tmin = (int)min % 60;
    
    if (min > 0) {
        if (thour > 0 && tmin > 0) {
            formatStr = [NSString stringWithFormat:@"%d小时%d分钟" , thour , tmin];
        }
        else if (thour > 0 && tmin <= 0) {
            formatStr = [NSString stringWithFormat:@"%d小时" , thour];
        }
        else{
            formatStr = [NSString stringWithFormat:@"%d分钟" , tmin];
        }
    }
    
    return formatStr;
}




@end
