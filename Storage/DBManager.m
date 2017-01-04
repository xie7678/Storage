//
//  DBManager.m
//  Storage
//
//  Created by Sam on 16/12/12.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager {
    FMDatabase *_db;
    FMDatabaseQueue *_dbQueue;
}


static id shareDBManager = nil;

+ (instancetype) shareDBManagerA {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (shareDBManager == nil) {
            shareDBManager = [[self alloc] init];
        }
    });
    
    return shareDBManager;
}
/**
 创建物料表
 */
- (void) creatSuppliesTable {
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        
        BOOL success = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS supplies (id INTEGER PRIMARY KEY AUTOINCREMENT, number TEXT, name TEXT, stock TEXT, storage TEXT, output TEXT, date TEXT, creat_people_name TEXT, type TEXT, describe TEXT)"];
        
        if (success) {
            NSLog(@"创建表成功");
        } else {
            NSLog(@"创建表失败");
        }
        
    }];
    //    [self insertSuppliesTable];
    //    [self getSuppliesTableWithPage:0 size:10];
    //    [self selectSuppliesTableWithNumberOfName:@"K" name:@""];
    //        [self delegateSuppliesTableWithNumberOfName:@"1017" name:@""];
    //    [self delegateSuppliesTableWithNumberOfName:@"1017" name:@"" result:^(BOOL success) {
    //
    //    }];
    //    [self updateSuppliesTableWithNumber:@"1002" name:@"K" stock:@"24" storage:@"24" output:@"0" date:[NSString stringWithFormat:@"%@",[NSDate date]]];
    //    [self insertSuppliesTableNumber:@"1002" name:@"PRE-K" stock:@"20" storage:@"20" output:@"0" date:[NSString stringWithFormat:@"%@",[NSDate date]]];
    
}
/**
 创建入库表
 */
- (void) creatStorageTable {
    //    NSString *sqlStorageTable = [NSString stringWithFormat:@""];
    [_dbQueue inDatabase:^(FMDatabase *db) {
        BOOL success = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS storage (id INTEGER PRIMARY KEY AUTOINCREMENT, number TEXT, name TEXT, stock TEXT, storage TEXT, output TEXT, date TEXT, creat_people_name TEXT, type TEXT, describe TEXT)"];
        
        if (success) {
            NSLog(@"创建表成功");
        } else {
            NSLog(@"创建表失败");
        }
    }];
    
}
/**
 创建出库表
 */
- (void) creatOutputTable {
    //    NSString *sqlOutputTable = [NSString stringWithFormat:@""];
    [_dbQueue inDatabase:^(FMDatabase *db) {
        BOOL success = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS 'output' ('id' INTEGER PRIMARY KEY AUTOINCREMENT, 'number' TEXT, 'name' TEXT, 'stock' TEXT, 'storage' TEXT, 'output' TEXT, 'date' TEXT, creat_people_name TEXT, type TEXT, describe TEXT)"];
        
        if (success) {
            NSLog(@"创建表成功");
        } else {
            NSLog(@"创建表失败");
        }
    }];
}
/**
 创建物料类型
 */
- (void) creatTypeTable {
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sqlStr = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS 'supplies_type' ('id' INTEGER PRIMARY KEY AUTOINCREMENT, 'type_number' TEXT, 'type_name' TEXT, describe TEXT)"];
        
        BOOL success = [db executeUpdate:sqlStr];
        
        if (success) {
            NSLog(@"创建表成功");
        } else {
            NSLog(@"创建表失败");
        }
    }];
}
/**
 创建分组表
 */
- (void) creatGroupTable {
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sqlStr = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS 'groupS' ('id' INTEGER PRIMARY KEY AUTOINCREMENT, 'group_name' TEXT, 'supplies' TEXT, describe TEXT, date TEXT, creat_name TEXT)"];
        
        BOOL success = [db executeUpdate:sqlStr];
        
        if (success) {
            NSLog(@"创建表成功");
        } else {
            NSLog(@"创建表失败");
        }
    }];
}
/**
 创建物料分组关联表
 */
- (void) creatSuppliesAndGroup {
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sqlStr = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS 'supplies_group' ('id' INTEGER PRIMARY KEY AUTOINCREMENT, 'group_number' TEXT, 'supplies_number' TEXT, supplies_name TEXT, describe TEXT)"];
        BOOL success = [db executeUpdate:sqlStr];
        if (success) {
            NSLog(@"创建表成功");
        } else {
            NSLog(@"创建表失败");
        }
    }];
}
#pragma mark - 物料
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
                            result: (void (^) (BOOL success)) result {
    
    __block BOOL success;
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sqlStr = @"";
        if ([describe isEqualToString:@""]) {
            sqlStr = [NSString stringWithFormat:@"INSERT INTO supplies (name, number, stock, storage, output, date, creat_people_name, type) VALUES ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@')",name, number, stock, storage, output, date, creatPName, typeName];
        } else {
            sqlStr = [NSString stringWithFormat:@"INSERT INTO supplies (name, number, stock, storage, output, date, creat_people_name, type, describe) VALUES ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@')",name, number, stock, storage, output, date, creatPName,typeName, describe];
        }
        //        NSLog(@"sqlStr == %@",sqlStr);
        success = [db executeUpdate:sqlStr];
        
        if (success) {
            NSLog(@"插入成功");
        } else {
            NSLog(@"插入失败");
        }
    }];
    
    result(success);
}

/**
 删除数据
 */
- (void) delegateSuppliesTableWithNumberOfName: (NSString *) number
                                          name: (NSString *) name
                                        result: (void (^) (BOOL success)) result {
    __block BOOL success;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sqlStr = [NSString stringWithFormat:@"DELETE FROM supplies WHERE number = '%@'",number];
        success = [db executeUpdate:sqlStr];
        
        if (success) {
            NSLog(@"删除数据成功");
        } else {
            NSLog(@"删除失败");
        }
    }];
    result(success);
}

/**
 更新数据
 */
- (void) updateSuppliesTableWithNumber: (NSString *) number
                                  name: (NSString *) name
                                 stock: (NSString *) stock
                               storage: (NSString *) storage
                                output: (NSString *) output
                                  date: (NSString *) date
                            creatPName: (NSString *) creatPName
                              typeName: (NSString *) typeName
                              describe: (NSString *) describe
                                result: (void (^) (BOOL success)) result {
    __block BOOL success;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        
        NSString *sqlStr = [NSString stringWithFormat:@"UPDATE supplies SET name = '%@', stock = '%@', storage = '%@', output= '%@', date = '%@', type = '%@', describe = '%@' WHERE number = '%@'",name, stock, storage, output, date, typeName, describe, number];
        
        success = [db executeUpdate:sqlStr];
        
        if (success) {
            NSLog(@"更新成功");
        } else {
            NSLog(@"更新失败");
        }
    }];
    
    result(success);
}
#pragma mark - 分类
- (void) insertSuppliesTypeTableWithNumber: (NSString *) number
                                      name: (NSString *) name
                                  describe: (NSString *) describe
                                    result: (void (^) (BOOL success)) result {
    
    __block BOOL success;
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        
        NSString *sqlStr = @"";
        
        if ([describe isEqualToString:@""] || describe == nil) {
            sqlStr = [NSString stringWithFormat:@"INSERT INTO supplies_type (type_name, type_number) VALUES ('%@', '%@')",name, number];
        } else {
            sqlStr = [NSString stringWithFormat:@"INSERT INTO supplies_type (type_name, type_number, describe) VALUES ('%@', '%@', '%@')",name, number, describe];
        }
        
        success = [db executeUpdate:sqlStr];
        
        if (success) {
            NSLog(@"插入成功");
        } else {
            NSLog(@"插入失败");
        }
    }];
    
    result(success);
}

- (void) selectSuppliesTypeTableWithAll: (void (^) (NSArray *arr)) result {
    
    NSMutableArray *modelMA = [NSMutableArray array];
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sqlStr = [NSString stringWithFormat:@"SELECT * FROM supplies_type"];
        FMResultSet *result = [db executeQuery:sqlStr];
        
        while ([result next]) {
            SuppliesTypeModel *typeModel = [[SuppliesTypeModel alloc] init];
            NSString *number = [result stringForColumn:@"type_number"];
            NSString *name = [result stringForColumn:@"type_name"];
            NSString *describe = [result stringForColumn:@"describe"];
            [typeModel initWithModel:number name:name describe:describe];
            [modelMA addObject:typeModel];
        }
        
    }];
    
    result(modelMA);
    
}
- (void) selectSuppliesTypeTableWithNumber: (NSString *)number
                                   result : (void (^) (NSArray *arr)) result {
    
    NSMutableArray *modelMA = [NSMutableArray array];
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sqlStr = [NSString stringWithFormat:@"SELECT * FROM supplies_type WHERE type_number = '%@'",number];
        FMResultSet *result = [db executeQuery:sqlStr];
        
        while ([result next]) {
            SuppliesTypeModel *typeModel = [[SuppliesTypeModel alloc] init];
            NSString *number = [result stringForColumn:@"type_number"];
            NSString *name = [result stringForColumn:@"type_name"];
            NSString *describe = [result stringForColumn:@"describe"];
            [typeModel initWithModel:number name:name describe:describe];
            [modelMA addObject:typeModel];
        }
        
    }];
    
    result(modelMA);
    
}
#pragma mark - 分组
/**
 分页展示分组
 */
- (void) selectGroupAndSuppliesWithPage: (int) page
                                   size: (int) size
                                 result: (void (^) (NSArray *arr)) result
{
    
    NSMutableArray *modelMA = [NSMutableArray array];
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sqlStr = [NSString stringWithFormat:@"SELECT * FROM groupS LIMIT %d, %d ",page * size, size];
        FMResultSet *result = [db executeQuery:sqlStr];
        while ([result next]) {
            GroupModel *groupModel = [[GroupModel alloc] init];
            NSString *groupNumber = [result stringForColumn:@"id"];
            NSString *GroupName = [result stringForColumn:@"group_name"];
            NSString *suppliesA = [result stringForColumn:@"supplies"];
            NSString *describe = [result stringForColumn:@"describe"];
            NSString *pName = [result stringForColumn:@"creat_name"];
            NSString *date = [result stringForColumn:@"date"];
            
            [groupModel initWithModel:groupNumber groupName:GroupName suppliesA:suppliesA describe:describe peopleName:pName date:date];
            //            [groupModel initWithModel:number name:name describe:describe];
            [modelMA addObject:groupModel];
            
        }
    }];
    result(modelMA);
}


/**
 获取分组下的物料
 */
- (void) selectGroupWithSupplies:(NSString *) number {
    
    
    NSMutableArray *modelMA = [NSMutableArray array];
    //    NSString *sqlStr = [NSString stringWithFormat:@"SELECT * FROM group WHERE group_number = '%@'",number];
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sqlStr = [NSString stringWithFormat:@"SELECT * FROM supplies_group WHERE group_number = '%@'",number];
        FMResultSet *result = [db executeQuery:sqlStr];
        while ([result next]) {
            
            SuppliesGroupModel *suppliesGroupModel = [[SuppliesGroupModel alloc] init];
            NSString *groupNumber = [result stringForColumn:@"group_number"];
            NSString *suppliesName = [result stringForColumn:@"supplies_name"];
            NSString *suppliesNumber = [result stringForColumn:@"supplies_number"];
            [suppliesGroupModel initWithModelGroupNumber:groupNumber suppliesName:suppliesName suppliesNumber:suppliesNumber];
            [modelMA addObject:suppliesGroupModel];
        }
    }];
    
    
}
/**
 插入分组
 */
- (void) insertGroupWithName: (NSString *) name
                      describe: (NSString *) describe
                      supplies: (NSString *) supplies
                          date: (NSString *) date
                     creatName: (NSString *) creatName
                        result: (void (^) (BOOL success)) result{
    
    __block BOOL success;
    NSString *sqlStr = @"";
//     'group_number' TEXT, 'group_name' TEXT, 'supplies' TEXT, describe TEXT, date TEXT, name TEXT
    if ([describe isEqualToString:@""] || describe == nil) {
        sqlStr = [NSString stringWithFormat:@"INSERT INTO groupS (group_name, supplies, date, creat_name) VALUES ('%@', '%@', '%@', '%@')",name, supplies, date, creatName];
    } else {
        sqlStr = [NSString stringWithFormat:@"INSERT INTO groupS (group_name, supplies, describe, date, creat_name) VALUES ('%@', '%@', '%@', '%@' '%@')",name, supplies, describe, date, creatName];
    }
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        success = [db executeUpdate:sqlStr];
        if (success) {
            NSLog(@"插入数据成功");
        } else {
            NSLog(@"插入数据失败");
        }
    }];
    
    result(success);
}
#pragma mark - 删除表
- (void) deleteTable {
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sqlStr = [NSString stringWithFormat:@"DROP TABLE supplies"];
        
        BOOL success = [db executeUpdate:sqlStr];
        
        if (success) {
            NSLog(@"删除表成功");
        } else {
            NSLog(@"删除表失败");
        }
        
    }];
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sqlStr = [NSString stringWithFormat:@"DROP TABLE storage"];
        
        BOOL success = [db executeUpdate:sqlStr];
        
        if (success) {
            NSLog(@"删除表成功");
        } else {
            NSLog(@"删除表失败");
        }
        
    }];
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sqlStr = [NSString stringWithFormat:@"DROP TABLE output"];
        
        BOOL success = [db executeUpdate:sqlStr];
        
        if (success) {
            NSLog(@"删除表成功");
        } else {
            NSLog(@"删除表失败");
        }
        
    }];
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sqlStr = [NSString stringWithFormat:@"DROP TABLE supplies_type"];
        
        BOOL success = [db executeUpdate:sqlStr];
        
        if (success) {
            NSLog(@"删除表成功");
        } else {
            NSLog(@"删除表失败");
        }
        
    }];
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sqlStr = [NSString stringWithFormat:@"DROP TABLE groupS"];
        
        BOOL success = [db executeUpdate:sqlStr];
        
        if (success) {
            NSLog(@"删除表成功");
        } else {
            NSLog(@"删除表失败");
        }
        
    }];
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sqlStr = [NSString stringWithFormat:@"DROP TABLE supplies_group"];
        
        BOOL success = [db executeUpdate:sqlStr];
        
        if (success) {
            NSLog(@"删除表成功");
        } else {
            NSLog(@"删除表失败");
        }
        
    }];
}

/**
 检索
 */

- (void) selectSuppliesTableWithNumber: (NSString *) number
                                  name: (NSString *) name
                                result: (void (^) (NSArray *arr)) result {
    
    NSMutableArray *modelMA = [NSMutableArray array];
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        
        NSString *sqlStr = @"";
        
        if (number == nil || [number isEqualToString:@""]) {
            
            sqlStr = [NSString stringWithFormat:@"SELECT * FROM supplies WHERE name LIKE '%%%@%%'",name];
            
            NSLog(@"sqlStr == %@", sqlStr);
        } else {
            
            sqlStr = [NSString stringWithFormat:@"SELECT * FROM supplies WHERE number = '%@'",number];
        }
        
        FMResultSet *result = [db executeQuery:sqlStr];
        
        while ([result next]) {
            SuppliesModel *model = [[SuppliesModel alloc] init];
            int ID = [result intForColumnIndex:0];
            NSString *number = [result stringForColumn:@"number"];
            NSString *name = [result stringForColumn:@"name"];
            NSString *stock = [result stringForColumn:@"stock"];
            NSString *storage = [result stringForColumn:@"storage"];
            NSString *output = [result stringForColumn:@"output"];
            NSString *date = [result stringForColumn:@"date"];
            NSString *creatName = [result stringForColumn:@"creat_people_name"];
            NSString *type = [result stringForColumn:@"type"];
            NSString *describe = [result stringForColumn:@"describe"];
            [model initWithId:ID number:number name:name stock:stock storage:storage output:output date:date creatPeopleName:creatName type:type describe:describe];
            
            [modelMA addObject:model];
            
        }
    }];
    
    result(modelMA);
}

/**
 分页获取数据
 */
- (void) getSuppliesTableWithPage: (int) page
                             size: (int) size
                           result: (void (^) (NSArray *arr)) result  {
    NSMutableArray *modelMA = [NSMutableArray array];
    [_dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *result = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM supplies LIMIT %d, %d",page * size, size]];
        
        while ([result next]) {
            SuppliesModel *model = [[SuppliesModel alloc] init];
            int ID = [result intForColumnIndex:0];
            NSString *number = [result stringForColumn:@"number"];
            NSString *name = [result stringForColumn:@"name"];
            NSString *stock = [result stringForColumn:@"stock"];
            NSString *storage = [result stringForColumn:@"storage"];
            NSString *output = [result stringForColumn:@"output"];
            NSString *date = [result stringForColumn:@"date"];
            NSString *creatName = [result stringForColumn:@"creat_people_name"];
            NSString *type = [result stringForColumn:@"type"];
            NSString *describe = [result stringForColumn:@"describe"];
            
            [model initWithId:ID number:number name:name stock:stock storage:storage output:output date:date creatPeopleName:creatName type:type describe:describe];
            
            [modelMA addObject:model];
            
        }
    }];
    result(modelMA);
}
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
                           result: (void (^) (BOOL success)) result {
    
    __block BOOL success;
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sqlStr = @"";
        if ([describe isEqualToString:@""]) {
            
            sqlStr = [NSString stringWithFormat:@"INSERT INTO storage (name, number, stock, storage, output, date, creat_people_name, type) VALUES ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@')",name, number, stock, storage, output, date, creatPName, typeName];
        } else {
            sqlStr = [NSString stringWithFormat:@"INSERT INTO storage (name, number, stock, storage, output, date, creat_people_name, type, describe) VALUES ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@')",name, number, stock, storage, output, date, creatPName,typeName, describe];
        }
        //        NSLog(@"sqlStr == %@",sqlStr);
        success = [db executeUpdate:sqlStr];
        
        if (success) {
            NSLog(@"插入成功");
        } else {
            NSLog(@"插入失败");
        }
    }];
    
    result(success);
}
/**
 分页获取数据
 */
- (void) getStorageTableWithPage: (int) page
                             size: (int) size
                           result: (void (^) (NSArray *arr)) result
{
    
    NSMutableArray *modelMA = [NSMutableArray array];
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        
        FMResultSet *result = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM storage ORDER BY id DESC LIMIT %d, %d",page * size,size]];
        
        while ([result next]) {
            SuppliesModel *model = [[SuppliesModel alloc] init];
            int ID = [result intForColumnIndex:0];
            NSString *number = [result stringForColumn:@"number"];
            NSString *name = [result stringForColumn:@"name"];
            NSString *stock = [result stringForColumn:@"stock"];
            NSString *storage = [result stringForColumn:@"storage"];
            NSString *output = [result stringForColumn:@"output"];
            NSString *date = [result stringForColumn:@"date"];
            NSString *creatName = [result stringForColumn:@"creat_people_name"];
            NSString *type = [result stringForColumn:@"type"];
            NSString *describe = [result stringForColumn:@"describe"];
            
            [model initWithId:ID number:number name:name stock:stock storage:storage output:output date:date creatPeopleName:creatName type:type describe:describe];
            
            [modelMA addObject:model];
            
        }
    }];
    result(modelMA);
}
/**
    入库数据检索
 */
- (void) selectedStorageTabelWithNumber: (NSString *) number//入库物料编号
                                   name: (NSString *) name//入库物料名（模糊搜索）
                                   page: (int) page
                                   size: (int) size
                                 result: (void (^) (NSArray *arr)) result {//返回检索数组
    NSMutableArray *modelMA = [NSMutableArray array];
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
       
        NSString *sqlStr = @"";
        
        if ([name isEqualToString:@""] || name == nil) {
            sqlStr = [NSString stringWithFormat: @"SELECT * FROM storage WHERE number = '%@' ORDER BY id DESC LIMIT %d, %d", number, page * size, size];
        } else {
            sqlStr = [NSString stringWithFormat:@"SELECT * FROM storage WHERE name LIKE '%%%@%%' ORDER BY id DESC LIMIT %d, %d", name, page * size, size];
        }
        
        FMResultSet *result = [db executeQuery:sqlStr];
        
        while ([result next]) {
            SuppliesModel *model = [[SuppliesModel alloc] init];
            int ID = [result intForColumnIndex:0];
            NSString *number = [result stringForColumn:@"number"];
            NSString *name = [result stringForColumn:@"name"];
            NSString *stock = [result stringForColumn:@"stock"];
            NSString *storage = [result stringForColumn:@"storage"];
            NSString *output = [result stringForColumn:@"output"];
            NSString *date = [result stringForColumn:@"date"];
            NSString *creatName = [result stringForColumn:@"creat_people_name"];
            NSString *type = [result stringForColumn:@"type"];
            NSString *describe = [result stringForColumn:@"describe"];
            [model initWithId:ID number:number name:name stock:stock storage:storage output:output date:date creatPeopleName:creatName type:type describe:describe];
            
            [modelMA addObject:model];
        }
        
    }];
    result(modelMA);
}


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
                           result: (void (^) (BOOL success)) result {
    
    __block BOOL success;
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sqlStr = @"";
        if ([describe isEqualToString:@""]) {
            
            sqlStr = [NSString stringWithFormat:@"INSERT INTO output (name, number, stock, storage, output, date, creat_people_name, type) VALUES ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@')",name, number, stock, storage, output, date, creatPName, typeName];
        } else {
            sqlStr = [NSString stringWithFormat:@"INSERT INTO output (name, number, stock, storage, output, date, creat_people_name, type, describe) VALUES ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@')",name, number, stock, storage, output, date, creatPName,typeName, describe];
        }
        //        NSLog(@"sqlStr == %@",sqlStr);
        success = [db executeUpdate:sqlStr];
        
        if (success) {
            NSLog(@"插入成功");
        } else {
            NSLog(@"插入失败");
        }
    }];
    
    result(success);
}
/**
 分页获取数据
 */
- (void) getOutputTableWithPage: (int) page
                           size: (int) size
                         result: (void (^) (NSArray *arr)) result
{
    
    NSMutableArray *modelMA = [NSMutableArray array];
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        
        FMResultSet *result = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM output ORDER BY id DESC LIMIT %d, %d",page * size,size]];
        
        while ([result next]) {
            SuppliesModel *model = [[SuppliesModel alloc] init];
            int ID = [result intForColumnIndex:0];
            NSString *number = [result stringForColumn:@"number"];
            NSString *name = [result stringForColumn:@"name"];
            NSString *stock = [result stringForColumn:@"stock"];
            NSString *storage = [result stringForColumn:@"storage"];
            NSString *output = [result stringForColumn:@"output"];
            NSString *date = [result stringForColumn:@"date"];
            NSString *creatName = [result stringForColumn:@"creat_people_name"];
            NSString *type = [result stringForColumn:@"type"];
            NSString *describe = [result stringForColumn:@"describe"];
            
            [model initWithId:ID number:number name:name stock:stock storage:storage output:output date:date creatPeopleName:creatName type:type describe:describe];
            
            [modelMA addObject:model];
            
        }
    }];
    result(modelMA);
}

/**
 出库数据检索
 
 */
- (void) selectedOutputTableWithNumber: (NSString *) number
                                  name: (NSString *) name
                                  page: (int) page
                                  size: (int) size
                                result: (void (^) (NSArray *arr)) result{
    NSMutableArray *modelMA = [NSMutableArray array];
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        
        NSString *sqlStr = @"";
        
        if ([name isEqualToString:@""] || name == nil) {
            sqlStr = [NSString stringWithFormat: @"SELECT * FROM output WHERE number = '%@' ORDER BY id DESC LIMIT %d, %d", number, page * size, size];
        } else {
            sqlStr = [NSString stringWithFormat:@"SELECT * FROM output WHERE name LIKE '%%%@%%' ORDER BY id DESC LIMIT %d, %d", name, page * size, size];
        }
        
        FMResultSet *result = [db executeQuery:sqlStr];
        
        while ([result next]) {
            SuppliesModel *model = [[SuppliesModel alloc] init];
            int ID = [result intForColumnIndex:0];
            NSString *number = [result stringForColumn:@"number"];
            NSString *name = [result stringForColumn:@"name"];
            NSString *stock = [result stringForColumn:@"stock"];
            NSString *storage = [result stringForColumn:@"storage"];
            NSString *output = [result stringForColumn:@"output"];
            NSString *date = [result stringForColumn:@"date"];
            NSString *creatName = [result stringForColumn:@"creat_people_name"];
            NSString *type = [result stringForColumn:@"type"];
            NSString *describe = [result stringForColumn:@"describe"];
            
            [model initWithId:ID number:number name:name stock:stock storage:storage output:output date:date creatPeopleName:creatName type:type describe:describe];
            
            [modelMA addObject:model];
            
        }
    }];
    result(modelMA);
    
}


#pragma mark - init
- (id) init {
    self = [super init];
    
    if (self) {
        
        //        NSFileManager *fm = [NSFileManager defaultManager];
        //
        //        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        //        NSString *documents = [paths objectAtIndex:0];
        //        NSString *database_path = [documents stringByAppendingPathComponent:@"storage.db"];
        //        NSString *te = [[NSBundle mainBundle] pathForResource:@"storage" ofType:@"db"];
        //        if (![fm fileExistsAtPath:database_path]) {
        ////            [fm copyItemAtPath:te toPath:database_path error:nil];
        //            [FMDatabase databaseWithPath:database_path];
        //        } else {
        //            NSLog(@"文件已存在%@",database_path);
        //        }
        //
        //        NSLog(@"path == %@",database_path);
        //
        //        _db = [FMDatabase databaseWithPath:database_path];
        //
        //        [self creatSuppliesTable];
        
        // 0.拼接数据库存放的沙盒路径
        NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
        NSString *sqlFilePath = [path stringByAppendingPathComponent:@"storage.sqlite"];
        
        // 1.创建一个FMDatabaseQueue对象
        // 只要创建数据库队列对象, FMDB内部就会自动给我们加载数据库对象
        _dbQueue = [FMDatabaseQueue databaseQueueWithPath:sqlFilePath];
        
        NSLog(@"path == %@",sqlFilePath);
        
        // 2.执行操作
        // 会通过block传递队列中创建好的数据库
        
        [self creatSuppliesTable];
        [self creatStorageTable];
        [self creatOutputTable];
        [self creatTypeTable];
        [self creatGroupTable];
//        [self creatSuppliesAndGroup];
//                        [self deleteTable];
        
    }
    
    return self;
}

@end
