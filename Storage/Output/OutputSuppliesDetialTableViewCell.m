//
//  OutputSuppliesDetialTableViewCell.m
//  Storage
//
//  Created by Sam on 16/12/20.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import "OutputSuppliesDetialTableViewCell.h"

@implementation OutputSuppliesDetialTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void) setSuppliesModel: (SuppliesModel *) model {
    _model = model;
    
    self.numberLabel.text = model.number;
    
    self.nameLabel.text = model.name;
    
    self.stockLabel.text = model.stock;
    
    self.outputNumberTF.delegate = self;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"text == %@",textField.text);
    
//    if ([textField.text isEqualToString:@""] || textField.text == nil) {
//        [MBProgressHUD showError:@"请输入出库数量"];
//    }
//    
//    [textField.text hasPrefix:@"0"];
//    
//    if (textField.text) {
//        
//    }
    
    if ([self.delegate respondsToSelector:@selector(getOutputSuppliesDetialWithNumber:suppliesNumber:)]) {
        [self.delegate getOutputSuppliesDetialWithNumber:textField.text suppliesNumber:self.model.number];
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}
@end
