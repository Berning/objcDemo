//
//  UILabel+BN.m
//  Xcode8
//
//  Created by uBerning on 2017/3/15.
//  Copyright © 2017年 BN. All rights reserved.
//

#import "UILabel+BN.h"

@implementation UILabel (BN)

-(void) autoFixWidthByText
{
    if (self.text && self.text.length > 0) {
        CGSize size = CGSizeMake(320,2000);
        NSDictionary *attribute = @{NSFontAttributeName: self.font};
        NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        CGSize labelsize = [self.text boundingRectWithSize:size options:options attributes:attribute context:nil].size;
        CGRect labelFram = self.frame;
        labelFram.size.width = labelsize.width;
        self.frame = labelFram;
    }
    else{
        
        CGRect labelFram = self.frame;
        labelFram.size.width = 0.0;
        self.frame = labelFram;
    }
}


@end
