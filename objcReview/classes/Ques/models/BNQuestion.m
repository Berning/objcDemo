//
//  BNQuestion.m
//  Questions
//
//  Created by Berning on 2018/12/16.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "BNQuestion.h"

@implementation BNQuestion

-(void)setQuestion:(NSString *)question
{
    _question=question;
    
    
    CGFloat questionLabelX = 5;
    CGFloat questionLabelY = 7;
    CGFloat maxW = kMainScreenWidth - 2 * questionLabelX;
    CGFloat maxH = kMainScreenHeight - 2 * questionLabelY;
    
//    CGSize questionSize=[question boundingRectWithSize:CGSizeMake(maxW, maxH) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:30]} context:nil].size;
    
    CGSize questionSize = [question sizeWithFont:[UIFont systemFontOfSize:22] constrainedToSize:CGSizeMake(maxW, 180)];

    
    _questionF=CGRectMake(questionLabelX, questionLabelY, questionSize.width, questionSize.height);
    
    _cellHeight=CGRectGetMaxY(_questionF)+questionLabelY;
        
}



@end
