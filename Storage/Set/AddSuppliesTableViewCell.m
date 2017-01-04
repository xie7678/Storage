//
//  AddSuppliesTableViewCell.m
//  Storage
//
//  Created by Sam on 16/12/19.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import "AddSuppliesTableViewCell.h"

@implementation AddSuppliesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    @weakify(self);
    [[self.touchBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        self.model.isOfSelected = !self.model.isOfSelected;
        if (self.model.isOfSelected) {
            self.selectButton.selected = YES;
        } else {
            self.selectButton.selected = NO;
        }
        if ([self.delegate respondsToSelector:@selector(getSelectedSuppliesWithModel:)]) {
            [self.delegate getSelectedSuppliesWithModel:self.model];
        }
    }];
    
}

- (void) setSuppliesModel:(SuppliesModel *) model {
    
    self.numberLabel.text = model.number;
    
    self.nameLabel.text = model.name;
    
    _model = model;
    
    if (model.isOfSelected) {
        self.selectButton.selected = YES;
    } else {
        self.selectButton.selected = NO;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)selectSuppliesAction:(UIButton *)sender {
    
    self.model.isOfSelected = !self.model.isOfSelected;
    
//    [self setSuppliesModel:self.model];
    
//    UITableView *tableView = (UITableView *)[[[[sender superview] superview] superview] superview];
//    [tableView reloadData];
    
    if ([self.delegate respondsToSelector:@selector(getSelectedSuppliesWithModel:)]) {
        [self.delegate getSelectedSuppliesWithModel:self.model];
    }
    
}

@end
