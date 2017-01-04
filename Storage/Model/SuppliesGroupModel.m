//
//  SuppliesGroupModel.m
//  Storage
//
//  Created by Sam on 16/12/15.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import "SuppliesGroupModel.h"

@implementation SuppliesGroupModel
- (void) initWithModelGroupNumber: (NSString *) groupNumber suppliesName:(NSString *) suppliesName suppliesNumber:(NSString *) suppliesNumber {
    self.group_number = groupNumber;
    self.supplies_name = suppliesName;
    self.supplies_number = suppliesNumber;
}
@end
