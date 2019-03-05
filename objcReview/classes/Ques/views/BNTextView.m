//
//  BNTextView.m
//  Ring
//
//  Created by wangboning on 15/11/29.
//  Copyright © 2015年 Qihoo. All rights reserved.
//

#import "BNTextView.h"

@interface BNTextView ()

@property (nonatomic, weak) UILabel *placeholderLabel;

@end

@implementation BNTextView

- (id)initWithFrame:(CGRect)frame
{
    if ( self = [super initWithFrame:frame])
    {
        // 1.添加提示文字
        self.font=[UIFont systemFontOfSize:20];
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.textColor = [UIColor lightGrayColor];
        placeholderLabel.hidden = YES;
        placeholderLabel.numberOfLines = 0;
        placeholderLabel.backgroundColor = [UIColor clearColor];
        placeholderLabel.font =self.font;
        [self insertSubview:placeholderLabel atIndex:0];
        self.placeholderLabel = placeholderLabel;

        //2.监听textView文字改变的通知
        [BNNotificationCenter addObserver:self selector:@selector(textDidChanged) name:UITextViewTextDidChangeNotification object:self];
    
    }
    return self;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    
    self.placeholderLabel.text = placeholder;
    if (placeholder.length) { // 需要显示
        self.placeholderLabel.hidden = NO;
        
        // 计算frame
        CGFloat placeholderX = 5;
        CGFloat placeholderY = 7;
        CGFloat maxW = self.frame.size.width - 2 * placeholderX;
        CGFloat maxH = self.frame.size.height - 2 * placeholderY;
        CGSize placeholderSize =[placeholder boundingRectWithSize:CGSizeMake(maxW, maxH) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.placeholderLabel.font} context:nil].size;
        
        
//      CGSize placeholderSize =  [placeholder sizeWithFont:self.placeholderLabel.font constrainedToSize:CGSizeMake(maxW, maxH)];
        self.placeholderLabel.frame = CGRectMake(placeholderX, placeholderY, placeholderSize.width, placeholderSize.height);
    } else {
        self.placeholderLabel.hidden = YES;
    }
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    self.placeholderLabel.textColor = placeholderColor;
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    self.placeholder = self.placeholder;
}

- (void)textDidChanged
{
    self.placeholderLabel.hidden = (self.text.length != 0);
}

- (void)dealloc
{
    [BNNotificationCenter removeObserver:self];
}

@end
