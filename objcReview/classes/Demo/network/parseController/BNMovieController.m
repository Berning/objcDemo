
//
//  BNMovieController.m
//  objcReview
//
//  Created by aBerning on 2019/9/30.
//  Copyright © 2019 Bien. All rights reserved.
//

#import "BNMovieController.h"
#import <MediaPlayer/MediaPlayer.h>


@interface BNMovieController ()

@property(nonatomic,strong)MPMoviePlayerController *moviePlayer;

@end

@implementation BNMovieController

- (MPMoviePlayerController *)moviePlayer
{
    if (!_moviePlayer) {
        _moviePlayer=[[MPMoviePlayerController alloc ]initWithContentURL:self.movieUrl];
        _moviePlayer.view.frame=self.view.bounds;
        _moviePlayer.view.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
       
//        MPMovieControlStyleNone,       // No controls
//        MPMovieControlStyleEmbedded,   // Controls for an embedded view
//        MPMovieControlStyleFullscreen, // Controls for fullscreen playback
//        MPMovieControlStyleDefault = MPMovieControlStyleEmbedded

//        _moviePlayer.controlStyle
        
//        MPMovieLoadStateUnknown        = 0,
//        MPMovieLoadStatePlayable       = 1 << 0,
//        MPMovieLoadStatePlaythroughOK  = 1 << 1, // Playback will be automatically started in this state when shouldAutoplay is YES
//        MPMovieLoadStateStalled        = 1 << 2, // Playback will be automatically paused in this state, if started

        
//        _moviePlayer.loadState
        
//        MPMovieRepeatModeNone,
//        MPMovieRepeatModeOne

//        _moviePlayer.repeatMode
        
        [self.view addSubview:_moviePlayer.view];
    }
    return _moviePlayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.moviePlayer play];
    NSLog(@"loadState:%lu",(unsigned long)self.moviePlayer.loadState);
    NSLog(@"controlStyle:%lu",self.moviePlayer.controlStyle);
    NSLog(@"repeatMode:%lu",self.moviePlayer.repeatMode);
    
    [self addNotification];
}


- (void)viewDidAppear:(BOOL)animated
{
    [self.moviePlayer setFullscreen:YES animated:YES];
}


#pragma mark - 添加通知
- (void)addNotification
{
    // 1. 添加播放状态的监听
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self selector:@selector(stateChanged) name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
    // 2. 播放结束
    [nc addObserver:self selector:@selector(finished) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    // 3. 全屏
    [nc addObserver:self selector:@selector(exitFullScreen) name:MPMoviePlayerDidExitFullscreenNotification object:nil];
    // 4. 截屏完成通知
    [nc addObserver:self selector:@selector(captureFinished:) name:MPMoviePlayerThumbnailImageRequestDidFinishNotification object:nil];
      
}

- (void)dealloc
{
    // 1. 删除通知监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (void)captureImageWithInterval:(float)interval
{
    // 数组中有多少时间,就通知几次
    // MPMovieTimeOptionExact 精确
    // MPMovieTimeOptionNearestKeyFrame 大概齐
    [self.moviePlayer requestThumbnailImagesAtTimes:@[@(interval)] timeOption:MPMovieTimeOptionNearestKeyFrame];
    
}


- (void)captureFinished:(NSNotification *)notification
{
//    NSLog(@"%@", notification);
    [self.delegate moviePlayerDidCapturedWithImage:notification.userInfo[MPMoviePlayerThumbnailImageKey]];
}


- (void)exitFullScreen
{
    // 返回上级窗体
    // 谁申请,谁释放!
    if(self.delegate&&[self.delegate respondsToSelector:@selector(moviePlayerDidFinished)])
    {
        [self.delegate moviePlayerDidFinished];
    }
    NSLog(@"完成");
}

- (void)finished
{
    NSLog(@"结束");
    [self.moviePlayer play];
}

/**
 MPMoviePlaybackStateStopped,           停止
 MPMoviePlaybackStatePlaying,           播放
 MPMoviePlaybackStatePaused,            暂停
 MPMoviePlaybackStateInterrupted,       中断
 MPMoviePlaybackStateSeekingForward,    后退
 MPMoviePlaybackStateSeekingBackward    前进
 */
- (void)stateChanged
{
    switch (self.moviePlayer.playbackState) {
        case MPMoviePlaybackStatePlaying:
            NSLog(@"播放");
            break;
        case MPMoviePlaybackStatePaused:
            NSLog(@"暂停");
            
            NSLog(@"endPlaybackTime:%f",self.moviePlayer.endPlaybackTime);
            NSLog(@"playableDuration:%f",self.moviePlayer.playableDuration);
            NSLog(@"duration:%f",self.moviePlayer.duration);
//            NSLog(@"fullscreen:%d",self.moviePlayer.fullscreen);

            break;
        case MPMoviePlaybackStateStopped:
            // 执行[self.moviePlayer stop]或者前进后退不工作时会触发
            NSLog(@"停止");

            break;
            
        case MPMoviePlaybackStateInterrupted:
            NSLog(@"中断");
            break;
            
        case MPMoviePlaybackStateSeekingForward:
            NSLog(@"Forward");

            if(self.delegate&&[self.delegate respondsToSelector:@selector(moviePlayerSeekingForward)])
            {
                [self.delegate moviePlayerSeekingForward];
            }
            break;
        case MPMoviePlaybackStateSeekingBackward:
            NSLog(@"Backward");

            if(self.delegate&&[self.delegate respondsToSelector:@selector(moviePlayerSeekingBackward)])
            {
                [self.delegate moviePlayerSeekingBackward];
            }

            break;
        default:
            break;
    }
}


@end
