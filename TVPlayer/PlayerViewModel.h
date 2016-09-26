//
//  PlayerViewModel.h
//  TVPlayer
//
//  Created by shendong on 16/9/26.
//  Copyright © 2016年 shendong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RACSignal;
@interface PlayerViewModel : NSObject

- (RACSignal *)getPlayerList;

@end
