//
//  GroupDetialTableViewController.h
//  Storage
//
//  Created by Sam on 16/12/19.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupModel.h"
@interface GroupDetialTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *groupName;

@property (weak, nonatomic) IBOutlet UITextField *groupId;

@property (weak, nonatomic) IBOutlet UITextField *crateNameTF;

@property (weak, nonatomic) IBOutlet UITextView *describeTV;

@property (nonatomic, strong) GroupModel *model;

@end
