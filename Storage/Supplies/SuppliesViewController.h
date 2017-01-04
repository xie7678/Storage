//
//  SuppliesViewController.h
//  Storage
//
//  Created by Sam on 16/12/13.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HandelType) {
    HandelTypeDefaul,          //
    HandelTypeStorage,
    HandelTypeOutput//
};

@interface SuppliesViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, assign) HandelType handelType;
@end
