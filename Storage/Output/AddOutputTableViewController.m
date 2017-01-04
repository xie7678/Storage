//
//  AddOutputTableViewController.m
//  Storage
//
//  Created by Sam on 16/12/15.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import "AddOutputTableViewController.h"

@interface AddOutputTableViewController ()

@end

@implementation AddOutputTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.numberTF.text = self.model.number;
    
    self.nameTF.text = self.model.name;
    
    self.stockTF.text = self.model.stock;
    
    //    self.addStrogePeopleName.text = self.model.creatPeopleName;
    
    self.dateTF.text = [Tool getDefauleDate];
    
    //    DBManager *db = [DBManager shareDBManagerA];
    //    __block SuppliesTypeModel *typeModel = [[SuppliesTypeModel alloc] init];
    //    [db selectSuppliesTypeTableWithNumber:self.model.typeNumber result:^(NSArray *arr) {
    //        if (arr.count>0) {
    //            typeModel = (SuppliesTypeModel *)arr[0];
    //            self.typeTF.text = typeModel.type_name;
    //        }
    //    }];
    __weak typeof(self) weakSelf = self;
    [Tool getSuppliesTypeWithNumber:self.model.typeNumber result:^(SuppliesTypeModel *typeModel) {
        if (typeModel) {
            weakSelf.typeTF.text = typeModel.type_name;
        }
    }];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (IBAction)sureOutputAction:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    if (!self.outputTF.text.checkIsStock) {
        [MBProgressHUD showError:@"请输入有效数字"];
    } else {
        
        
        __weak typeof(self) weakSelf = self;
        int newStock = [self.model.stock intValue] - [self.outputTF.text intValue];
        if (newStock >= 0) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            int newOutput = [self.model.output intValue] + [self.outputTF.text intValue];
            
            [self updateSuppliesStockWithNumber:self.model.number newStock:[NSString stringWithFormat:@"%d",newStock] newOutput:[NSString stringWithFormat:@"%d",newOutput] result:^(BOOL success) {
                if (success) {
                    [weakSelf updateOutputWithNumber:self.model.number newStock:[NSString stringWithFormat:@"%d",newOutput] newOutput:self.outputTF.text creatName:self.outputPeopleNameTF.text describe:self.describeTV.text result:^(BOOL success) {
                        if (success) {
                            [MBProgressHUD showSuccess:@"出库成功"];
                            if ([self.delegate respondsToSelector:@selector(addOutputWithSuccess)]) {
                                [self.delegate addOutputWithSuccess];
                            }
                            [self.navigationController popViewControllerAnimated:YES];
                        } else {
                            [MBProgressHUD showError:@"出库失败"];
                        }
                        [hud hideAnimated:YES];
                    }];
                }
            }];
        } else {
            
            [MBProgressHUD showError:@"出库数量大于库存，请重新输入"];
        }
    }
    
}

- (void) updateOutputWithNumber: (NSString *) number
                       newStock: (NSString *) newStock
                      newOutput: (NSString *) newOutput
                      creatName: (NSString *) creatName
                       describe: (NSString *) describe
                         result: (void (^) (BOOL success)) result
{
    DBManager *db = [DBManager shareDBManagerA];
    
    [db insertOutputTableNumber:number name:self.model.name stock:newStock storage:@"0" output:newOutput date:self.dateTF.text creatPName:creatName typeName:self.model.typeNumber describe:describe result:^(BOOL success) {
        if (success) {
            NSLog(@"插入出库表成功");
        } else {
            NSLog(@"插入出库表失败");
        }
        result(success);
    }];
    
}

- (void) updateSuppliesStockWithNumber: (NSString *) number
                              newStock: (NSString *) newStock
                             newOutput: (NSString *) newOutput
                                result: (void (^) (BOOL success)) result
{
    
    
    DBManager *db = [DBManager shareDBManagerA];
    
    [db updateSuppliesTableWithNumber:number name:self.model.name stock:newStock storage:self.model.storage output:newOutput date:self.model.date creatPName:self.model.creatPeopleName typeName:self.model.typeNumber describe:self.model.describe result:^(BOOL success) {
        if (success) {
            NSLog(@"更新物料表成功");
        } else {
            NSLog(@"更新物料表失败");
        }
        result(success);
    }];
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
