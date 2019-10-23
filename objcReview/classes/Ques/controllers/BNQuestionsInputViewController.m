//
//  BNQuestionsInputViewController.m
//  Questions
//
//  Created by Berning on 2018/12/16.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "BNQuestionsInputViewController.h"
#import "BNTextView.h"
#import "BNQuestionsTableViewController.h"
#import "BNQuestion.h"
#import "BNQuestionSQLite.h"



@interface BNQuestionsInputViewController ()<UITextViewDelegate>

@property(nonatomic,weak)BNTextView *textView;

@end

@implementation BNQuestionsInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavs];
    [self initSubViews];
}


- (void)setNavs
{
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(commit)];
    
    
}

- (void)commit
{
    BNQuestion *question=[[BNQuestion alloc] init];
    question.question=[self.textView.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    question.date=[self date];
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [BNQuestionSQLite sqliteInsertRecord:question success:^(NSString *success) {
        
        [BNNotificationCenter postNotificationName:BNNewQuestionDidAdded object:nil];
        
        alertController.message=success;
        UIAlertAction *alertAction=[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:alertAction];
        
        
    } failure:^(NSString * failure) {
        
    } ];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

-(void)initSubViews
{
    
    
    BNTextView *textView = [[BNTextView alloc] init];
    textView.frame=CGRectMake(0, kNavigationBarHeight_Portrait, kMainScreenWidth, (kMainScreenHeight-kNavigationBarHeight_Portrait)/2.0f);
    // 垂直方向上永远可以拖拽
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    
//    [textView becomeFirstResponder];
    textView.placeholder = @"请在此输入问题描述...";
    textView.returnKeyType=UIReturnKeyDone;
    [self.view addSubview:textView];
    self.textView = textView;
    
}



-(NSString * )date
{
    NSDateFormatter*fmt= [NSDateFormatter new];
    [fmt setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    return [fmt stringFromDate:[NSDate date]];
}

#pragma mark -  TextViewDelegate

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}




@end
