//
//  BNXmlParseController.m
//  objcReview
//
//  Created by aBerning on 2019/9/14.
//  Copyright © 2019 Bien. All rights reserved.
//

#import "BNXmlParseController.h"

@interface BNXmlParseController ()<NSXMLParserDelegate>

@property(nonatomic,strong)NSMutableArray *videosM;

@property(nonatomic,strong)BNVidio *video;

@property(nonatomic,strong)NSMutableString *videoString;


@end

@implementation BNXmlParseController


- (NSMutableArray *)videosM
{
    if (!_videosM) {
        _videosM=[NSMutableArray array];
    }
    return _videosM;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)loadData
{ 
    [super loadData];
    
    __weak __typeof(self) weakSelf=self;
    
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"http://121.40.171.11/objc/videos.php?format=xml&count=5&from=%lu",self.videosM.count]];
    NSURLRequest *request=[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue new] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        
        if (!connectionError)
        {//no connection error
            NSIndexSet *statusCodeRange=[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(200, 100)];
            NSHTTPURLResponse *httpResponse=[response copy];
            if (data&&[statusCodeRange containsIndex:httpResponse.statusCode])
            {//no http error such as 403,500
                
                NSXMLParser *parser=[[NSXMLParser alloc] initWithData:data];
                parser.delegate=self;
                [parser parse];
                
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


#pragma mark -NSXMLParserDelegate


- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    
    if (!_videoString) {
        _videoString=[NSMutableString string];
    }else
    {
        [_videoString setString:@""];
    }
    
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
{
//    if (!elementName) {
//        
//    }
    if ([elementName isEqualToString:@"video"]) {
        self.video=[[BNVidio alloc] init];
        self.video.videoId=attributeDict[@"videoId"];
    }
    
    [self.videoString setString:@""];

}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [self.videoString appendString:string];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"video"]) {
        [self.videosM addObject:self.video];
    }else if (![elementName isEqualToString:@"videos"])
    {
        [self.video setValue:self.videoString forKey:elementName];
    }
}


- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!self.videosM.count) {
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
          
        
        }else
        {

            self.videos=[self.videosM copy];
            
        }
        [self.tableView.mj_footer endRefreshing];
        
    });
}


- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alertVc=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        alertVc.title=[NSString stringWithFormat:@"错误码:%ld",parseError.code];
        alertVc.message=parseError.localizedDescription;
        UIAlertAction *alert=[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertVc addAction:alert];
        
        [self presentViewController:alertVc animated:YES completion:nil];

    });
}

@end
