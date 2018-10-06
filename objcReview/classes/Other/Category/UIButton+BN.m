
//
//  UIButton+BN.m
//  Xcode8
//
//  Created by uBerning on 2017/3/15.
//  Copyright © 2017年 BN. All rights reserved.
//

#import "UIButton+BN.h"

@implementation UIButton (BN)
-(void) autoFixWidthByText
{
    if (self.titleLabel.text && self.titleLabel.text.length > 0) {
        CGSize size = CGSizeMake(320,2000);
        NSDictionary *attribute = @{NSFontAttributeName: self.titleLabel.font};
        NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        CGSize labelsize = [self.titleLabel.text boundingRectWithSize:size options:options attributes:attribute context:nil].size;
        CGRect labelFram = self.frame;
        labelFram.size.width = labelsize.width + 10;
        self.frame = labelFram;
    }
    else{
        
        CGRect labelFram = self.frame;
        labelFram.size.width = 0.0;
        self.frame = labelFram;
    }
}
@end
