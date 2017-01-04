//
//  OutputSuppliesDetialTableViewCell.h
//  Storage
//
//  Created by Sam on 16/12/20.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OutputSuppliesDetialDelegate <NSObject>

- (void) getOutputSuppliesDetialWithNumber: (NSString *) outputNumber suppliesNumber: (NSString *) suppliesNumber ;

@end

@interface OutputSuppliesDetialTableViewCell : UITableViewCell<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *stockLabel;

@property (weak, nonatomic) IBOutlet UITextField *outputNumberTF;

@property (nonatomic, strong) SuppliesModel *model;

@property (nonatomic, weak) id <OutputSuppliesDetialDelegate> delegate;

- (void) setSuppliesModel: (SuppliesModel *) model;
@end
