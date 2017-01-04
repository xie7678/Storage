//
//  GroupTableViewCell.h
//  Storage
//
//  Created by Sam on 16/12/16.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GroupModel.h"

@interface GroupTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@property (weak, nonatomic) IBOutlet UILabel *creatNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *groupNameLabel;

- (void) setGroupModel:(GroupModel *) group;

@end
