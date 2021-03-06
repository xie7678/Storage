//
//  StorageTableViewCell.m
//  Storage
//
//  Created by Sam on 16/12/16.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import "StorageTableViewCell.h"

@implementation StorageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void) setStorageModel:(SuppliesModel *) model {
    self.numberLabel.text = model.number;
    self.nameLabel.text = model.name;
    self.dateLabel.text = model.date;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
