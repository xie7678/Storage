//
//  GroupViewController.h
//  Storage
//
//  Created by Sam on 16/12/16.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupTableViewCell.h"

typedef NS_ENUM(NSInteger, GroupType) {
    GroupTypeDefaul,          //
    GroupTypeStorage,
    GroupTypeOutput//
};

@interface GroupViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, assign) GroupType groupType;

@end
