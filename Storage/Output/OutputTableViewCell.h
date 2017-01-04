//
//  OutputTableViewCell.h
//  Storage
//
//  Created by Sam on 16/12/16.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OutputTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

- (void) setOutputModel:(SuppliesModel *) model;
@end
