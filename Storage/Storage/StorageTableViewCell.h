//
//  StorageTableViewCell.h
//  Storage
//
//  Created by Sam on 16/12/16.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuppliesModel.h"


@interface StorageTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;//物料名

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;//物料编号

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;//添加物料时间

- (void) setStorageModel:(SuppliesModel *) model;

@end
