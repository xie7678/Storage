//
//  GetSuppliesDetialTableViewController.m
//  Storage
//
//  Created by Sam on 16/12/13.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import "GetSuppliesDetialTableViewController.h"
#import "SuppliesTypeModel.h"

#import "AddStrogeTableViewController.h"
#import "AddOutputTableViewController.h"


@interface GetSuppliesDetialTableViewController ()<UITableViewDelegate, AddStrogeTableViewControllerDelegate, AddOutputTabelViewControllerDelegate>

@end

@implementation GetSuppliesDetialTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    [self setData];
//    NSLog(@"model = = %@",self.model);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) setData {
    
    self.numberLabel.text = self.model.number;
    self.suppliesName.text = self.model.name;
    self.stockLabel.text = self.model.stock;
    self.storageLabel.text = self.model.storage;
    self.outputLabel.text = self.model.output;
    self.peopleNameLabel.text = self.model.creatPeopleName;
    self.creatDateLabel.text = self.model.date;
//    DBManager *db = [DBManager shareDBManagerA];
//    __block SuppliesTypeModel *typeModel = [[SuppliesTypeModel alloc] init];
//    [db selectSuppliesTypeTableWithNumber:self.model.typeNumber result:^(NSArray *arr) {
//        if (arr.count>0) {
//            typeModel = (SuppliesTypeModel *)arr[0];
//            self.typeLabel.text = typeModel.type_name;
//        }
//    }];
    __weak typeof(self) weakSelf = self;
    [Tool getSuppliesTypeWithNumber:self.model.typeNumber result:^(SuppliesTypeModel *typeModel) {
        if (typeModel) {
            weakSelf.typeLabel.text = typeModel.type_name;
        }
    }];
}

- (void) updateModel {
    __weak typeof(self) weakSelf = self;
    DBManager *dbM = [DBManager shareDBManagerA];
    [dbM selectSuppliesTableWithNumber:self.model.number name:@"" result:^(NSArray *arr) {
        if (arr.count > 0) {
            weakSelf.model = arr[0];
            [weakSelf setData];
        }
        
    }];
    
    
}


- (void) getTypeName {
//   DBManager *db = [DBManager shareDBManagerA];
//    SuppliesTypeModel *typeModel = [[SuppliesTypeModel alloc] init];
//    [db selectSuppliesTypeTableWithNumber:self.model.typeNumber result:^(NSArray *arr) {
//        if (arr.count>0) {
//            typeModel = (SuppliesTypeModel *)arr[0];
//        }
//    }];
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
    return 9;
}
- (void) addStrogeSuccess {
    [self updateModel];
    NSLog(@"添加成功");
}
- (void) addOutputWithSuccess {
    NSLog(@"出库成功了");
    [self updateModel];
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"addNewStorageSegue"]) {
        AddStrogeTableViewController *detial = (AddStrogeTableViewController *)[segue destinationViewController];
        detial.model = self.model;
        detial.delegate = self;
        NSLog(@"model == %@",detial.model.number);
    } else if ([segue.identifier isEqualToString:@"addNewOutputSegue"]) {
        AddOutputTableViewController *detial = (AddOutputTableViewController *)[segue destinationViewController];
        detial.model = self.model;
        detial.delegate = self;
    }
}

@end
