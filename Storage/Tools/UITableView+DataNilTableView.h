//
//  UITableView+DataNilTableView.h
//  Storage
//
//  Created by Sam on 16/12/21.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (DataNilTableView)


- (void) tableViewNoDataWithRowCount: (int) rowCount showMessage: (NSString *)showMessage;

@end
