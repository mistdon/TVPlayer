//
//  CameraViewController.m
//  TVPlayer
//
//  Created by shendong on 16/9/27.
//  Copyright © 2016年 shendong. All rights reserved.
//

#import "CameraViewController.h"
#import <LFLiveKit/LFLiveKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

#import "LiveBottomBar.h"

@interface CameraViewController ()<LFLiveSessionDelegate>
@property (nonatomic, strong) LiveBottomBar *liveBottomBar;
@property (nonatomic, strong) LFLiveSession *session;

@end

@implementation CameraViewController
#pragma mark - lazy load -
- (LFLiveSession *)session{
    if (!_session) {
        _session = [[LFLiveSession alloc] initWithAudioConfiguration:[LFLiveAudioConfiguration defaultConfiguration] videoConfiguration:[LFLiveVideoConfiguration defaultConfiguration]];
        _session.preView = self.view;
        _session.delegate = self;
    }
    return _session;
}
#pragma mark - life cycle -
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"📷";
    
    [self prepareForVideo];
    [self prepareForAudio];
    [self startLive];
    
    self.liveBottomBar = [[[NSBundle mainBundle] loadNibNamed:@"LiveBottomBar" owner:nil options:nil] firstObject];
    self.liveBottomBar.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 44, [UIScreen mainScreen].bounds.size.width, 44);
    [self.view addSubview:self.liveBottomBar];
    @weakify(self);
    [self.liveBottomBar selectCallbacl:^(NSInteger index) {
        @strongify(self);
        switch (index) {
            case 2:
                [self exchangeCameraPosition];
                break;
            case 3:
                [self exchangeBeautyFace];
                break;
            case 4:
                [self.navigationController popViewControllerAnimated:YES];
                break;
            default:
                break;
        }
        NSLog(@"index = %lu",index);
    }];
}
#pragma mark - private method -
- (void)prepareForVideo{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (status) {
        case AVAuthorizationStatusAuthorized:
            [self.session setRunning:YES];
            break;
        case AVAuthorizationStatusNotDetermined:{
            @weakify(self);
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    @strongify(self);
                    [self.session setRunning:YES];
                };
            }];
            break;
        }
        case AVAuthorizationStatusDenied:
        case AVAuthorizationStatusRestricted:
            NSLog(@"您已关闭摄像权限，请前往设置中打开");
            break;
        default:
            break;
    }
}
- (void)prepareForAudio{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    switch (status) {
        case AVAuthorizationStatusNotDetermined:{
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
                ;
            }];
            }
            break;
        default:
            break;
    }
}
- (void)startLive{
    LFLiveStreamInfo *streamInfo = [LFLiveStreamInfo new];
    streamInfo.url = @"www.baidu.com"; //your server rtmp url
    [self.session startLive:streamInfo];
}
- (void)stopLive{
    [self.session stopLive];
}
- (void)exchangeCameraPosition{
    AVCaptureDevicePosition devicePosition = self.session.captureDevicePosition;
    self.session.captureDevicePosition = (devicePosition == AVCaptureDevicePositionFront) ? AVCaptureDevicePositionBack : AVCaptureDevicePositionFront;
}
- (void)exchangeBeautyFace{
    self.session.beautyFace = !self.session.beautyFace;
}
#pragma mark - LFLiveSessionDelegate -
- (void)liveSession:(LFLiveSession *)session liveStateDidChange:(LFLiveState)state{
    NSLog(@"%s,state = %lu",__FUNCTION__,(unsigned long)state);
}
- (void)liveSession:(LFLiveSession *)session errorCode:(LFLiveSocketErrorCode)errorCode{
    NSLog(@"%s,state = %lu",__FUNCTION__,(unsigned long)errorCode);
}
- (void)liveSession:(LFLiveSession *)session debugInfo:(LFLiveDebug *)debugInfo{
    NSLog(@"%s,state = %lu",__FUNCTION__,(unsigned long)debugInfo);
}


@end
