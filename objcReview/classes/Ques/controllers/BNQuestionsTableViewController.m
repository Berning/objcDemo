//
//  BNQuestionsTableViewController.m
//  Questions
//
//  Created by Berning on 2018/12/16.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "BNQuestionsTableViewController.h"
#import "BNQuestionsCell.h"
#import "BNQuestionSQLite.h"
#import "BNQuestion.h"
#import "BNWebViewController.h"


NSString * const BNNewQuestionDidAdded=@"com.bien.rich.objcReview";

@interface BNQuestionsTableViewController ()

@property(nonatomic,strong)NSArray *questionArray;

@end

@implementation BNQuestionsTableViewController

#pragma mark -lazy load

-(NSArray *)questionArray
{
    if (!_questionArray) {
        
        _questionArray=[NSArray array];
        
    }
    return _questionArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self refreshTableView];
    [BNNotificationCenter addObserver:self selector:@selector(questionHasAdded) name:BNNewQuestionDidAdded object:nil];
}


-(void)dealloc
{
    
    [BNNotificationCenter removeObserver:self];
}

- (void)questionHasAdded
{
    [self refreshTableView];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

-(void)refreshTableView
{
    __weak typeof(self) weakSelf=self;
    [BNQuestionSQLite sqliteRetrieveRecord:^(NSArray *records) {
        weakSelf.questionArray=[records reverseObjectEnumerator].allObjects;
        
        [weakSelf.tableView reloadData];
    } failure:^(NSError * error) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.questionArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BNQuestionsCell *cell = [BNQuestionsCell cellWithTableView:tableView];
    BNQuestion *question=self.questionArray[indexPath.row];
   
    cell.question=question;
    return cell;
}


#pragma mark - Table view data delegate


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BNQuestion *question=self.questionArray[indexPath.row];
    return question.cellHeight;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"indexPath:%ld",indexPath.row);
    BNQuestion *question=self.questionArray[indexPath.row];
    BNWebViewController *webVC=[BNWebViewController new];
    [self.navigationController pushViewController:webVC animated:YES];
    
    self.delegate=webVC;
    NSLog(@"delegate:%@",self.delegate);
    if(self.delegate && [self.delegate respondsToSelector:@selector(questionsTableViewCellLoadString:)])
    {
        [self.delegate questionsTableViewCellLoadString:question.question];
    }
    
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/





@end
