//
//  DBManagerh
//  Storage
//
//  Created by Sam on 16/12/12.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>
#import "SuppliesModel.h"
#import "SuppliesTypeModel.h"
#import "GroupModel.h"
#import "SuppliesGroupModel.h"
@interface DBManager : NSObject

+ (instancetype) shareDBManagerA;

//@property (nonatomic, strong) 


#pragma mark - 物料
/**
 分页获取数据
 */
- (void) getSuppliesTableWithPage: (int) page
                             size: (int) size
                           result: (void (^) (NSArray *arr)) result;
/**
 检索
 */
- (void) selectSuppliesTableWithNumber: (NSString *) number
                                  name: (NSString *) name
                                result: (void (^) (NSArray *arr)) result;
/**
 插入物料数据
 */
- (void) insertSuppliesTableNumber: (NSString *) number
                              name: (NSString *) name
                             stock: (NSString *) stock
                           storage: (NSString *) storage
                            output: (NSString *) output
                              date: (NSString *) date
                        creatPName: (NSString *) creatPName
                          typeName: (NSString *) typeName
                          describe: (NSString *) describe
                            result: (void (^) (BOOL success)) result;
/**
 更新数据
 */
- (void) updateSuppliesTableWithNumber: (NSString *) number
                                  name: (NSString *) name
                                 stock: (NSString *) stock
                               storage: (NSString *)storage
                                output: (NSString *) output
                                  date: (NSString *)date
                            creatPName: (NSString *) creatPName
                              typeName: (NSString *) typeName
                              describe: (NSString *) describe
                                result: (void (^) (BOOL success)) result;

#pragma mark - 分类

- (void) insertSuppliesTypeTableWithNumber: (NSString *) number
                                      name:(NSString *) name
                                  describe:(NSString *) describe
                                    result: (void (^) (BOOL success)) result;

- (void) selectSuppliesTypeTableWithAll: (void (^) (NSArray *arr)) result;

- (void) selectSuppliesTypeTableWithNumber: (NSString *)number
                                   result : (void (^) (NSArray *arr)) result;
#pragma mark - 出库
/**
 插入入库数据
 */
- (void) insertOutputTableNumber: (NSString *) number
                            name: (NSString *) name
                           stock: (NSString *) stock
                         storage: (NSString *) storage
                          output: (NSString *) output
                            date: (NSString *) date
                      creatPName: (NSString *) creatPName
                        typeName: (NSString *) typeName
                        describe: (NSString *) describe
                          result: (void (^) (BOOL success)) result;
/**
 分页获取数据
 */
- (void) getOutputTableWithPage: (int) page
                           size: (int) size
                         result: (void (^) (NSArray *arr)) result;

/**
 出库数据检索
 
 */
- (void) selectedOutputTableWithNumber: (NSString *) number
                                  name: (NSString *) name
                                  page: (int) page
                                  size: (int) size
                                result: (void (^) (NSArray *arr)) result;

#pragma mark - 入库
/**
 插入入库数据
 */
- (void) insertStorageTableNumber: (NSString *) number
                             name: (NSString *) name
                            stock: (NSString *) stock
                          storage: (NSString *) storage
                           output: (NSString *) output
                             date: (NSString *) date
                       creatPName: (NSString *) creatPName
                         typeName: (NSString *) typeName
                         describe: (NSString *) describe
                           result: (void (^) (BOOL success)) result;
/**
 分页获取数据
 */
- (void) getStorageTableWithPage: (int) page
                            size: (int) size
                          result: (void (^) (NSArray *arr)) result;

/**
 入库数据检索
 */
- (void) selectedStorageTabelWithNumber: (NSString *) number//入库物料编号
                                   name: (NSString *) name//入库物料名（模糊搜索）
                                   page: (int) page
                                   size: (int) size
                                 result: (void (^) (NSArray *arr)) result;//返回检索数组
#pragma mark - 分组
/**
 分页展示分组
 */
- (void) selectGroupAndSuppliesWithPage: (int) page
                                   size: (int) size
                                 result: (void (^) (NSArray *arr)) result;
/**
 获取分组下的物料
 */
- (void) selectGroupWithSupplies:(NSString *) number;

/**
 插入分组
 */
- (void) insertGroupWithName: (NSString *) name
                    describe: (NSString *) describe
                    supplies: (NSString *) supplies
                        date: (NSString *) date
                   creatName: (NSString *) creatName
                      result: (void (^) (BOOL success)) result;
@end
