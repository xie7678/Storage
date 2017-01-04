//
//  SuppliesTypeModel.m
//  Storage
//
//  Created by Sam on 16/12/14.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import "SuppliesTypeModel.h"

@implementation SuppliesTypeModel
- (void) initWithModel: (NSString *) number name:(NSString *) name describe:(NSString *) describe{
    self.type_name = name;
    self.type_number = number;
    self.describe = describe;
}
@end
