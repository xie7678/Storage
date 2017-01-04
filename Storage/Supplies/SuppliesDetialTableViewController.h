//
//  SuppliesDetialTableViewController.h
//  Storage
//
//  Created by Sam on 16/12/13.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuppliesModel.h"
@interface SuppliesDetialTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *numberTF;

@property (weak, nonatomic) IBOutlet UITextField *nameTF;

@property (weak, nonatomic) IBOutlet UITextField *stockTF;

@property (weak, nonatomic) IBOutlet UITextField *storageNameTF;

@property (weak, nonatomic) IBOutlet UITextField *dateTF;

@property (weak, nonatomic) IBOutlet UIButton *sureButton;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (weak, nonatomic) IBOutlet IBDesTextView *describeTV;

@property (weak, nonatomic) IBOutlet UITextField *typeTF;

@property (nonatomic, strong) SuppliesModel *model;

@end
