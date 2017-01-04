//
//  GroupModel.m
//  Storage
//
//  Created by Sam on 16/12/15.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import "GroupModel.h"

@implementation GroupModel

- (void) initWithModel: (NSString *) groupNumber
             groupName: (NSString *) groupName
             suppliesA: (NSString *) suppliesA
              describe: (NSString *) describe
            peopleName: (NSString *) peopleName
                  date: (NSString *) date {
    
    self.group_number = groupNumber;
    self.group_name = groupName;
    self.suppliesA = suppliesA;
    self.describe = describe;
    self.name = peopleName;
    self.date = date;
}
@end
