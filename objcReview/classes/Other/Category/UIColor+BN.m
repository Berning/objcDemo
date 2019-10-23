//
//  UIColor+BN.m
//  objcReview
//
//  Created by Berning on 2019/1/26.
//  Copyright © 2019年 Bien. All rights reserved.
//

#import "UIColor+BN.h"

@implementation UIColor (BN)

+ (UIColor *)navigationBarColor
{
    return [UIColor colorWithRed:245/255.0 green:245/255.0 blue:247/255.0 alpha:1];
}

+ (UIColor *)colorWithRedH:(NSString *)rh greenH:(NSString *)gh blueH:(NSString *)bh alpha:(NSString *)alpha
{
    CGFloat rd=(CGFloat)HtoD(rh.UTF8String);
    CGFloat gd=(CGFloat)HtoD(gh.UTF8String);
    CGFloat bd=(CGFloat)HtoD(bh.UTF8String);
    CGFloat a=[alpha floatValue];
    return [UIColor colorWithRed:rd/255.0 green:gd/255.0 blue:bd/255.0 alpha:a];
}


+ (UIColor *)colorWithRedH:(NSString *)rh greenH:(NSString *)gh blueH:(NSString *)bh
{
    return [UIColor colorWithRedH:rh greenH:gh blueH:bh alpha:@"1"];
}

/**
 *  十六进制转十进制
 *
 */

float HtoD(const char *s)
{
    
    int i;
    float dec=0;
    char t;
    for(i=0; s[i]!='\0'; i++)
    {
        dec=dec*16;
        t=s[i];
        NSLog(@"dec=========>%f",dec);

        if(t>='0' && t<='9')
            dec=dec+t-'0';
        else if(t>='a' && t<='f')
        {
            dec=dec+t-'a'+10;
        }
        else if(t>='A' && t<='F')
        {
            dec=dec+t-'A'+10;
        }
        
        NSLog(@"dec=========>%f",dec);
    }
    return dec;
}

@end
