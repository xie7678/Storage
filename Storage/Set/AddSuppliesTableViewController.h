//
//  AddSuppliesTableViewController.h
//  Storage
//
//  Created by Sam on 16/12/15.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GetSelectedSuppliesArrayDelegate <NSObject>

- (void) getSelectedSuppliesArray: (NSArray *) arr;

@end

@interface AddSuppliesTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic, weak) id <GetSelectedSuppliesArrayDelegate> delagate;


@end
