//
//  PlayerService.m
//  TVPlayer
//
//  Created by shendong on 16/9/26.
//  Copyright © 2016年 shendong. All rights reserved.
//

#import "PlayerService.h"
#import <ReactiveCocoa.h>
#import <AFNetworking.h>

@implementation PlayerService

- (RACSignal *)requretWithUrl:(NSString *)url withParameters:(NSDictionary *)paramters{
    NSParameterAssert(url);
    RACReplaySubject *subject = [RACReplaySubject subject];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", nil];
    [manager GET:url parameters:paramters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        [subject sendNext:responseObject];
        [subject sendCompleted];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [subject sendError:error];
    }];
    return  subject;
}

@end
