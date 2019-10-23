//
//  BNJsonSerialController.m
//  objcReview
//
//  Created by aBerning on 2019/9/14.
//  Copyright © 2019 Bien. All rights reserved.
//

#import "BNJsonSerialController.h"


@interface BNJsonSerialController ()

@property(nonatomic,strong) NSMutableArray *videosM ;

@end

@implementation BNJsonSerialController

- (NSMutableArray *)videosM
{
    if (!_videosM) {
        _videosM=[NSMutableArray array];
    }
    return _videosM;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (void)loadData
{
    [super loadData];
    
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"http://121.40.171.11/objc/videos.php?format=json&count=5&from=%lu",self.videosM.count]];
//    NSURL *url=[NSURL URLWithString:@"http://localhost/objc/videos.php?format=json"];

    NSURLRequest *request=[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];

    __weak __typeof(self) weakSelf=self;
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue new] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        
        if (!connectionError)
        {//no connection error
            NSIndexSet *statusCodeRange=[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(200, 100)];
            NSHTTPURLResponse *httpResponse=[response copy];
            if (data&&[statusCodeRange containsIndex:httpResponse.statusCode])
            {//no http error such as 403,500

                NSError *serialError=nil;
                NSArray *json=[NSJSONSerialization JSONObjectWithData:data options:0 error:&serialError];
                if (!json.count) {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        CGFloat left=120;
                        CGFloat duration=1.5;
                        UIView *messageView=[[UIView alloc] initWithFrame:CGRectMake(left, self.view.height-88, self.view.width-2*left, 30)];
                        messageView.alpha=0;
                        messageView.backgroundColor=UIColor.lightGrayColor;
                        
                        UILabel *label=[[UILabel alloc] initWithFrame:messageView.bounds];
                        [messageView addSubview:label];
                        label.text=@"哥，这回真没了";
                        label.textAlignment=NSTextAlignmentCenter;
                        label.textColor=[UIColor whiteColor];
                        
                        [UIView animateWithDuration:duration animations:^{
                            messageView.alpha=1;
                            [BNApplicationWindow addSubview:messageView];
                        } completion:^(BOOL finished) {
                            [UIView animateWithDuration:duration animations:^{
                                messageView.alpha=0;

                            } completion:^(BOOL finished) {
                                [messageView removeFromSuperview];
                            }];
                        }];
                        
                        [self.tableView.mj_footer endRefreshing];

                    }];
                    return ;

                }
                
                if (!serialError&&json)
                {//no error
                    
                    [json enumerateObjectsUsingBlock:^(id  _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        BNVidio *video=[BNVidio new];
                        [video setValuesForKeysWithDictionary:dict];
                        [self.videosM addObject:video];
                    }];
                    
                    
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        
                        self.videos=[self.videosM copy];
                        [self.tableView.mj_footer endRefreshing];

                    }];
                    
                }
                else//解析error
                {

                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        UIAlertController *alertVc=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
                        
                        alertVc.title=[NSString stringWithFormat:@"错误码:%ld",serialError.code];
                        alertVc.message=serialError.localizedDescription;
                        UIAlertAction *alert=[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            [weakSelf.navigationController popViewControllerAnimated:YES];
                        }];
                        [alertVc addAction:alert];
                        
                        [weakSelf presentViewController:alertVc animated:YES completion:nil];
                        
                    }];

                }

            }
            else
            {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    
                    
                    UIAlertController *alertVc=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];

                    alertVc.title=[NSString stringWithFormat:@"错误码:%ld",httpResponse.statusCode];
//                    alertVc.message=serialError.localizedDescription;
                    UIAlertAction *alert=[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                    }];
                    [alertVc addAction:alert];

                    [weakSelf presentViewController:alertVc animated:YES completion:nil];
                    
                }];

                
            }
            
        }
        else
        {
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                UIAlertController *alertVc=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
                alertVc.message=connectionError.localizedDescription;
                UIAlertAction *alert=[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }];
                [alertVc addAction:alert];
                [weakSelf presentViewController:alertVc animated:YES completion:nil];

            }];
        }
        
        
    }];
    

}



@end
