//
//  GroupDetialTableViewCell.h
//  Storage
//
//  Created by Sam on 16/12/20.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GroupDetialDelegate <NSObject>

- (void) getGroupDetialWithEidt: (NSString *) peopleName date: (NSString *) date;

@end

@interface GroupDetialTableViewCell : UITableViewCell<UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UITextField *peopleNameTF;

@property (weak, nonatomic) IBOutlet UITextField *dateTF;

@property (nonatomic, strong) GroupModel *model;

@property (nonatomic, weak) id <GroupDetialDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextView *describeTV;

- (void) setGroupModel: (GroupModel *)model;


@end
