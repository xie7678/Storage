//
//  Tool.m
//  Storage
//
//  Created by Sam on 16/12/16.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import "Tool.h"
#import "SuppliesTypeModel.h"

@implementation Tool

+ (NSString *) getDefauleDate {
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    //输出格式为：2010-10-27 10:22:13
    NSLog(@"%@",currentDateStr);
    
    return currentDateStr;
}


+ (void) getSuppliesTypeWithNumber: (NSString *) number
                            result: (void (^) (SuppliesTypeModel *typeModel)) result {
    
    DBManager *db = [DBManager shareDBManagerA];
    
    [db selectSuppliesTypeTableWithNumber:number result:^(NSArray *arr) {
        if (arr.count > 0) {
            result(arr[0]);
        } else {
            result(nil);
        }
    }];
    
}

+ (void) checkSelectedSupplies: (NSArray *)seletedSuppliesArray
                   addSupplies: (SuppliesModel *) model
                        result: (void (^) (NSArray *arr)) result {
    
    //默认为正序遍历
    [seletedSuppliesArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSLog(@"3遍历array：%zi-->%@",idx,obj);
    }];
    
    
}

@end
