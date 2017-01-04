//
//  AddGroupTableViewController.h
//  Storage
//
//  Created by Sam on 16/12/16.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddGroupTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *groupName;

@property (weak, nonatomic) IBOutlet UITextField *creatNameTF;

@property (weak, nonatomic) IBOutlet UITextView *describeTV;

@property (weak, nonatomic) IBOutlet UILabel *selectedSuppliesContentLabel;

@end
