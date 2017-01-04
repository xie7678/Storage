//
//  StrogeDetialTableViewController.m
//  Storage
//
//  Created by Sam on 16/12/16.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import "StrogeDetialTableViewController.h"

@interface StrogeDetialTableViewController ()

@end

@implementation StrogeDetialTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self updateDate];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) updateDate {
    
    self.numberKeyLabel.text = self.stoargeOrOutput == 0 ? @"入库数量" : @"出库数量";
    
    self.allNumberKeyLabel.text = self.stoargeOrOutput == 0 ? @"入库总数" : @"出库总数";
    
    self.peopleKeyLabel.text = self.stoargeOrOutput == 0 ? @"入库人" : @"出库人";
    
    self.dateKeyLabel.text = self.stoargeOrOutput == 0 ? @"入库时间" : @"出库时间";
    
    self.numberLabel.text = self.model.number;
    
    self.nameLabel.text = self.model.name;
    
    self.stockLabel.text = self.model.stock;
    
    self.stroageLabel.text = self.stoargeOrOutput == 0 ? self.model.storage : self.model.output;
    
    self.peopleNameLabel.text = self.model.creatPeopleName;
    
    self.dateLabel.text = self.model.date;
    
    self.describeLabel.text = self.model.describe;
    
    [Tool getSuppliesTypeWithNumber:self.model.typeNumber result:^(SuppliesTypeModel *typeModel) {
        if (typeModel) {
            self.typeLabel.text = typeModel.type_name;
        }
    }];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 8;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
