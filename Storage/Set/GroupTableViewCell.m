//
//  GroupTableViewCell.m
//  Storage
//
//  Created by Sam on 16/12/16.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import "GroupTableViewCell.h"

@implementation GroupTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void) setGroupModel:(GroupModel *) group {
    self.numberLabel.text = group.group_number;
    self.groupNameLabel.text = group.group_name;
    self.creatNameLabel.text = group.name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
