//
//  Tool.h
//  Storage
//
//  Created by Sam on 16/12/16.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SuppliesModel.h"
@interface Tool : NSObject
/**
 获取当前时间
 */
+ (NSString *) getDefauleDate;
/**
 通过物料分类number获取分类名
 */
+ (void) getSuppliesTypeWithNumber: (NSString *) number
                            result: (void (^) (SuppliesTypeModel *typeModel)) result;
/**
 筛选已选中的物料
 */
+ (void) checkSelectedSupplies: (NSArray *)seletedSuppliesArray
                   addSupplies: (SuppliesModel *) model
                        result: (void (^) (NSArray *arr)) result;
@end
