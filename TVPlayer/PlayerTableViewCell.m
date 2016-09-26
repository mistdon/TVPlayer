//
//  PlayerTableViewCell.m
//  TVPlayer
//
//  Created by shendong on 16/9/26.
//  Copyright © 2016年 shendong. All rights reserved.
//

#import "PlayerTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "Player.h"

@interface PlayerTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@end
@implementation PlayerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setPlayer:(Player *)player{
    [self.backgroundImageView sd_setImageWithURL:player.creator.portrait  placeholderImage:nil];
    self.nameLabel.text = player.creator.nick;
}
@end
