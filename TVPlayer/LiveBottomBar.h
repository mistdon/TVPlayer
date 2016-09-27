//
//  LiveBottomBar.h
//  TVPlayer
//
//  Created by shendong on 16/9/27.
//  Copyright © 2016年 shendong. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^selectActionBlock)(NSInteger);

@interface LiveBottomBar : UIView
- (void)selectCallbacl:(selectActionBlock)block;
@end
