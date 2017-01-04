//
//  AddSuppliesTableViewCell.h
//  Storage
//
//  Created by Sam on 16/12/19.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuppliesModel.h"

@protocol GetSelectedSuppliesDelegate <NSObject>

- (void) getSelectedSuppliesWithModel: (SuppliesModel *) model;

@end

@interface AddSuppliesTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIButton *selectButton;

@property (nonatomic, strong) SuppliesModel *model;

@property (nonatomic, weak) id <GetSelectedSuppliesDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *touchBtn;



- (void) setSuppliesModel:(SuppliesModel *) model;


@end
