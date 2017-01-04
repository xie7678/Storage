//
//  SuppliesTypeModel.h
//  Storage
//
//  Created by Sam on 16/12/14.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SuppliesTypeModel : NSObject

@property (nonatomic, strong) NSString *type_number;

@property (nonatomic, strong) NSString *type_name;

@property (nonatomic, strong) NSString *describe;

- (void) initWithModel: (NSString *) number name:(NSString *) name describe:(NSString *) describe;
@end
