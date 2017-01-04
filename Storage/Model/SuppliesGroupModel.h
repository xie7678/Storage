//
//  SuppliesGroupModel.h
//  Storage
//
//  Created by Sam on 16/12/15.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SuppliesGroupModel : NSObject

@property (nonatomic, strong) NSString *group_number;

@property (nonatomic, strong) NSString *supplies_name;

@property (nonatomic, strong) NSString *supplies_number;

- (void) initWithModelGroupNumber: (NSString *) groupNumber suppliesName:(NSString *) suppliesName suppliesNumber:(NSString *) suppliesNumber;

@end
