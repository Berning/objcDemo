//
//  BNParseViewController.m
//  objcReview
//
//  Created by aBerning on 2019/9/15.
//  Copyright © 2019 Bien. All rights reserved.
//

#import "BNParseViewController.h"
#import "BNMovieController.h"


#define  baseVideoUrl  @"http://berning.wang/"

@interface BNParseViewController ()<BNMoviePlayerViewControllerDelegate>

@property(nonatomic,strong)BNMovieController *movieController;


@end

@implementation BNParseViewController


#pragma mark -
- (void)setVideos:(NSArray *)videos
{
    _videos=videos;
    [self.tableView reloadData];
}

- (void)loadData
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableHeaderView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 10)];
    
    self.tableView.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadData];
    }];
    if ([self.tableView.mj_footer isRefreshing] == NO) {
        [self.tableView.mj_footer beginRefreshing];
        self.tableView.mj_header.automaticallyChangeAlpha = YES;
    }

}

#pragma  mark - tableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.videos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"video";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    BNVidio *video=self.videos[indexPath.row];
    cell.textLabel.text=video.name;

    if (video.image) {
        cell.imageView.image=video.image;
    }else
    {
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",baseVideoUrl,video.imageURL]] placeholderImage:[UIImage imageWithName:@"network"]];
        
    }
    

    return cell;
}


#pragma mark - tableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    [self presentViewController:self.movieController animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

#pragma mark - movie play


- (BNMovieController *)movieController
{
    if (!_movieController) {
        
        _movieController=[BNMovieController new];
        _movieController.delegate=self;
        
        NSIndexPath *indexPath=[self.tableView indexPathForSelectedRow];
        BNVidio *video=self.videos[indexPath.row];
        
        NSString *urlStr=[[NSString stringWithFormat:@"%@%@",baseVideoUrl,video.videoURL] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

        _movieController.movieUrl=[NSURL URLWithString:urlStr];
        [_movieController captureImageWithInterval:5.0f];
    }
    return _movieController;
}



#pragma mark - movie delegate
- (void)moviePlayerDidCapturedWithImage:(UIImage *)image
{
    NSIndexPath *indexPath=[self.tableView indexPathForSelectedRow];

    BNVidio *video=self.videos[indexPath.row];
    video.image=image;
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
}

-(void)moviePlayerDidFinished
{
    [self dismissViewControllerAnimated:YES completion:nil];
    self.movieController=nil;
}

#pragma  mark - customDownloadImage

- (void)customDownloadImage
{
    
    
    //
    //    if (!video.image) {
    //        cell.imageView.image=[UIImage imageNamed:@"network"];
    //        [self downLoadImages:video indexPath:indexPath];
    //    }
    //    else
    //    {
    //        cell.imageView.image=video.image;
    //
    //    }
    
}

- (void)downLoadImages:(BNVidio *)video indexPath:(NSIndexPath *)indexPath
{
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",baseVideoUrl,video.imageURL]];
    NSLog(@"%@",url);
    NSURLRequest *requst=[NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:10.0f];
    [NSURLConnection sendAsynchronousRequest:requst queue:[NSOperationQueue new] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        if (!connectionError&&data) {
            video.image=[UIImage imageWithData:data];
        }
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
        
    }];
    
}


@end
