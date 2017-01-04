//
//  UITableView+DataNilTableView.m
//  Storage
//
//  Created by Sam on 16/12/21.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import "UITableView+DataNilTableView.h"

@implementation UITableView (DataNilTableView)


- (void) tableViewNoDataWithRowCount: (int) rowCount showMessage: (NSString *) showMessage {
    
    if (rowCount == 0) {
        
        UIView *backV = (UIView *)[[NSBundle mainBundle] loadNibNamed:@"NoData" owner:nil options:nil].firstObject;
        
        if (showMessage != nil) {
            for (UIView *view in backV.subviews) {
                if ([view isKindOfClass:[UILabel class]]) {
                    UILabel *lab = (UILabel *)view;
                    lab.text = showMessage;
                    break;
                }
            }
        }
        
        self.backgroundView = backV;
        
    } else {
        
        self.backgroundView = nil;
        
        
    }
    
    
    
}

@end
