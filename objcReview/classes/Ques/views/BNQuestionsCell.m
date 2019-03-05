//
//  BNQuestionsCell.m
//  Questions
//
//  Created by Berning on 2018/12/16.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "BNQuestionsCell.h"
#import "BNQuestion.h"
@interface BNQuestionsCell ()

@property(nonatomic,strong)UILabel *questionLabel;

@end

@implementation BNQuestionsCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    
    static NSString *reusableIndentifier=@"BNQuestionsCell";
    BNQuestionsCell *cell=[tableView dequeueReusableCellWithIdentifier:reusableIndentifier];
    if(!cell)
    {
        cell=[[BNQuestionsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reusableIndentifier];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews
{
    self.questionLabel=[[UILabel alloc] init];
    [self.contentView addSubview:self.questionLabel];
    self.questionLabel.numberOfLines=0;

}

-(void)setQuestion:(BNQuestion *)question
{
    _question=question;
    self.questionLabel.frame=question.questionF;
    
    self.questionLabel.text=[question.question stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    

}



@end
