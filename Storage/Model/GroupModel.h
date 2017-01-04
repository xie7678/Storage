//
//  GroupModel.h
//  Storage
//
//  Created by Sam on 16/12/15.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupModel : NSObject

@property (nonatomic, strong) NSString *group_number;

@property (nonatomic, strong) NSString *group_name;

@property (nonatomic, strong) NSString *suppliesA;

@property (nonatomic, strong) NSString *describe;

/**
 创建人
 */
@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *date;

- (void) initWithModel: (NSString *) groupNumber
             groupName: (NSString *) groupName
             suppliesA: (NSString *) suppliesA
              describe: (NSString *) describe
            peopleName: (NSString *) peopleName
                  date: (NSString *) date;

@end
