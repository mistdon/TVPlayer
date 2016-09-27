//
//  PlayViewController.m
//  TVPlayer
//
//  Created by shendong on 16/9/26.
//  Copyright © 2016年 shendong. All rights reserved.
//

#import "PlayViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>


@interface PlayViewController ()
@property (nonatomic, strong) id<IJKMediaPlayback> Mediaplayer;
@end

@implementation PlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];  
    self.Mediaplayer = [[IJKFFMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:self.player.stream_addr] withOptions:[IJKFFOptions optionsByDefault]];
    [[self.Mediaplayer view] setAutoresizingMask: UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [[self.Mediaplayer view] setFrame:self.view.bounds];
    [self.Mediaplayer setScalingMode:IJKMPMovieScalingModeFill];
    [self.Mediaplayer setShouldAutoplay:YES];
    self.view.autoresizesSubviews = YES;
    [self.view addSubview:[self.Mediaplayer view]];
        [self installMovieNotificationObservers];
    
    UIButton *btn =[[UIButton alloc] init];
    [btn setTitle:@"Back" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [btn setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 40 - 5, self.view.bounds.size.height - 40 - 5, 40, 40)];
    [self.view addSubview:btn];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.Mediaplayer prepareToPlay];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.Mediaplayer shutdown];
}
- (void)dealloc{
    [self removeMovieNotificationObservers];
}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - notification - 
- (void)installMovieNotificationObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadStateDidChange:)
                                                 name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackFinish:)
                                                 name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mediaIsPreparedToPlayDidChange:)
                                                 name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackStateDidChange:)
                                                 name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                               object:nil];
    
}

- (void)removeMovieNotificationObservers {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                                  object:nil];
    
}
- (void)loadStateDidChange:(NSNotification *)notification{
    NSLog(@"=========%s",__FUNCTION__);
}
- (void)moviePlayBackFinish:(NSNotification *)notification{
    NSLog(@"=========%s",__FUNCTION__);
}
- (void)mediaIsPreparedToPlayDidChange:(NSNotification *)notification{
    NSLog(@"=========%s",__FUNCTION__);
}
- (void)moviePlayBackStateDidChange:(NSNotification *)notification{
    NSLog(@"=========%s",__FUNCTION__);
}
@end
