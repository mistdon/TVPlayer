//
//  PlayerViewModel.m
//  TVPlayer
//
//  Created by shendong on 16/9/26.
//  Copyright © 2016年 shendong. All rights reserved.
//

#import "PlayerViewModel.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <MJExtension/MJExtension.h>

#import "PlayerService.h"
#import "Player.h"

@implementation PlayerViewModel



/**
 @return <#return value description#>
 */
- (RACSignal *)getPlayerList{
    NSString *url = @"http://service.ingkee.com/api/live/simpleall?&devi=f77b4297b24055de68c2fa365cdcf2760ec0d32d&cv=IK3.5.10_Iphone&ua=iPhone7_2&proto=7&lc=0000000000000035&idfv=DE30D518-773A-4DFB-8ABE-87C5C46CB332&imsi=&imei=&cc=TG0001&osversion=ios_10.000000&idfa=2295CB6B-D6B5-4A7D-AC7B-ED31DAC63205&uid=209951796&sid=20sJCwlOUHwyKEXwRy3bNxpnGQ8pUH2A59u5fi0MU9JAxwIGyey&conn=Wifi&mtid=b18e66b41efd9a3df1a7bc8758da1883&mtxid=bc5436ce2846&s_sg=f04324b2a5793b957c4f81b6a75ead0e&s_sc=100&s_st=1474882848&";
    RACReplaySubject *replay = [RACReplaySubject subject];
    PlayerService *service = [[PlayerService alloc] init];
    [[service requretWithUrl:url withParameters:nil] subscribeNext:^(id x) {
        NSDictionary *result = (NSDictionary *)x;
        if (result[@"dm_error"] && [result[@"dm_error"] integerValue] == 0) {
            NSArray *data = [result objectForKey:@"lives"];
            NSArray *lives = [Player mj_objectArrayWithKeyValuesArray:data];
            [replay sendNext:lives];
            [replay sendCompleted];
        }else{
            [replay sendError:[NSError errorWithDomain:@"TVPlayer" code:1001 userInfo:@{@"text":@"something is wrong!"}]];
        }
    }error:^(NSError *error) {
        [replay sendError:error];
    }];
    return replay;
}

@end
