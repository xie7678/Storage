//
//  AddStrogeTableViewController.h
//  Storage
//
//  Created by Sam on 16/12/15.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuppliesModel.h"

@protocol AddStrogeTableViewControllerDelegate <NSObject>

- (void) addStrogeSuccess;

@end

@interface AddStrogeTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *numberTF;

@property (weak, nonatomic) IBOutlet UITextField *nameTF;

@property (weak, nonatomic) IBOutlet UITextField *typeTF;

@property (weak, nonatomic) IBOutlet UITextField *stockTF;

@property (weak, nonatomic) IBOutlet UITextField *addStrogeNumberTF;

@property (weak, nonatomic) IBOutlet UITextField *addStrogePeopleName;

@property (weak, nonatomic) IBOutlet UITextField *dateTF;

@property (weak, nonatomic) IBOutlet UITextView *describeTV;

@property (nonatomic, strong) SuppliesModel *model;

@property (nonatomic, weak) id <AddStrogeTableViewControllerDelegate> delegate;

@end
