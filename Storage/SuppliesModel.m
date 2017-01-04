//
//  SuppliesModel.m
//  Storage
//
//  Created by Sam on 16/12/12.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import "SuppliesModel.h"

@implementation SuppliesModel

- (void) initWithId:(int)id number: (NSString *)number name: (NSString *)name stock: (NSString *)stock storage: (NSString *) storage output:(NSString *) output date: (NSString *) date creatPeopleName: (NSString *) creatPeopleName type: (NSString *)type describe: (NSString *) describe{
    
    self.id = id;
    self.number = number;
    self.name = name;
    self.stock = stock;
    self.storage = storage;
    self.output = output;
    self.date = date;
    self.creatPeopleName = creatPeopleName;
    self.typeNumber = type;
    self.describe = describe;
    self.isOfSelected = NO;
}
@end
