//
//  GetSuppliesDetialTableViewController.h
//  Storage
//
//  Created by Sam on 16/12/13.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuppliesModel.h"
@interface GetSuppliesDetialTableViewController : UITableViewController
@property (nonatomic, strong) SuppliesModel *model;

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@property (weak, nonatomic) IBOutlet UILabel *suppliesName;

@property (weak, nonatomic) IBOutlet UILabel *stockLabel;

@property (weak, nonatomic) IBOutlet UILabel *storageLabel;

@property (weak, nonatomic) IBOutlet UILabel *outputLabel;

@property (weak, nonatomic) IBOutlet UILabel *peopleNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *creatDateLabel;

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@end
