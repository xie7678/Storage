//
//  SuppliesTableViewCell.m
//  Storage
//
//  Created by Sam on 16/12/13.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import "SuppliesTableViewCell.h"

@implementation SuppliesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void) setModelWithCell: (SuppliesModel *) model {
    
    self.numberLabel.text = model.number;
    self.nameLabel.text = model.name;
    self.StockLabel.text = model.stock;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
