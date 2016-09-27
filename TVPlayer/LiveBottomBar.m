//
//  LiveBottomBar.m
//  TVPlayer
//
//  Created by shendong on 16/9/27.
//  Copyright © 2016年 shendong. All rights reserved.
//

#import "LiveBottomBar.h"
@interface LiveBottomBar()
@property (nonatomic,copy) selectActionBlock localBlock;
@end
@implementation LiveBottomBar

- (void)selectCallbacl:(selectActionBlock)block{
    self.localBlock = block;
}
- (IBAction)didSelect:(UIButton *)sender {
    self.localBlock(sender.tag - 100);
}

@end
