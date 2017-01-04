//
//  StrogeDetialTableViewController.h
//  Storage
//
//  Created by Sam on 16/12/16.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuppliesModel.h"
@interface StrogeDetialTableViewController : UITableViewController

@property (nonatomic, assign) int stoargeOrOutput;

@property (weak, nonatomic) IBOutlet UILabel *dateKeyLabel;

@property (weak, nonatomic) IBOutlet UILabel *numberKeyLabel;

@property (weak, nonatomic) IBOutlet UILabel *allNumberKeyLabel;

@property (weak, nonatomic) IBOutlet UILabel *peopleKeyLabel;

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@property (weak, nonatomic) IBOutlet UILabel *stroageLabel;

@property (weak, nonatomic) IBOutlet UILabel *stockLabel;

@property (weak, nonatomic) IBOutlet UILabel *peopleNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UILabel *describeLabel;

@property (nonatomic, strong) SuppliesModel *model;

@end
