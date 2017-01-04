//
//  SuppliesModel.h
//  Storage
//
//  Created by Sam on 16/12/12.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SuppliesModel : NSObject

@property (nonatomic, assign) int id;

@property (nonatomic, strong) NSString *number;//编号

@property (nonatomic, strong) NSString *name;//物料名称

@property (nonatomic, strong) NSString *stock;//库存

@property (nonatomic, strong) NSString *storage;//入库数量

@property (nonatomic, strong) NSString *output;//出库数量

@property (nonatomic, strong) NSString *date;//创建时间，出库，入库时间

@property (nonatomic, strong) NSString *creatPeopleName;//创建人

@property (nonatomic, strong) NSString *typeNumber;//分类名

@property (nonatomic, strong) NSString *describe;//描述

@property (nonatomic, assign) BOOL isOfSelected;

- (void) initWithId:(int)id number: (NSString *)number name: (NSString *)name stock: (NSString *)stock storage: (NSString *) storage output:(NSString *) output date: (NSString *) date creatPeopleName: (NSString *) creatPeopleName type: (NSString *)type describe: (NSString *) describe;

@end
