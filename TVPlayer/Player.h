//
//  Player.h
//  TVPlayer
//
//  Created by shendong on 16/9/26.
//  Copyright © 2016年 shendong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Creator : NSObject
@property (nonatomic, copy) NSString *nick; //昵称
@property (nonatomic, copy) NSString *portrait; //头像
@property (nonatomic, copy) NSString *location; //所在地
@end

@interface Player : NSObject
@property (nonatomic, copy) NSString *share_addr;
@property (nonatomic, copy) NSString *stream_addr; //直播地址
@property (nonatomic, strong) Creator *creator;
@end
