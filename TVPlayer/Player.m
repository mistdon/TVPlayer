//
//  Player.m
//  TVPlayer
//
//  Created by shendong on 16/9/26.
//  Copyright © 2016年 shendong. All rights reserved.
//

#import "Player.h"
#import <MJExtension/MJExtension.h>
@implementation Creator

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if ([property.name isEqualToString:@"portrait"]) {
        return [NSURL URLWithString:[@"http://img.meelive.cn/" stringByAppendingString:oldValue]];
    }else{
        return oldValue;
    }
}

@end


@implementation Player

@end
