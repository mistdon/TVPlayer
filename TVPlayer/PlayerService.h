//
//  PlayerService.h
//  TVPlayer
//
//  Created by shendong on 16/9/26.
//  Copyright © 2016年 shendong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RACSignal;
@interface PlayerService : NSObject

- (RACSignal *)requretWithUrl:(NSString *)url withParameters:(NSDictionary *)paramters;

@end
