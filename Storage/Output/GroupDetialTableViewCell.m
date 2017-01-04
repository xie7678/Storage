//
//  GroupDetialTableViewCell.m
//  Storage
//
//  Created by Sam on 16/12/20.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import "GroupDetialTableViewCell.h"

@implementation GroupDetialTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void) setGroupModel: (GroupModel *)model {
    
    _model = model;
    
    self.numberLabel.text = model.group_number;
    
    self.nameLabel.text = model.group_name;
    
    self.dateTF.text = [Tool getDefauleDate];
    
    self.peopleNameTF.delegate = self;
    
    self.describeTV.delegate = self;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
//    - (void) getGroupDetialWithEidt: (NSString *) peopleName date: (NSString *) date
    if ([self.delegate respondsToSelector:@selector(getGroupDetialWithEidt:date:)]) {
        [self.delegate getGroupDetialWithEidt:textField.text date:self.dateTF.text];
    }
    
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}
@end
