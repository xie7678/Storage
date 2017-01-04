//
//  AddStrogeTableViewController.m
//  Storage
//
//  Created by Sam on 16/12/15.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import "AddStrogeTableViewController.h"

@interface AddStrogeTableViewController ()

@end

@implementation AddStrogeTableViewController

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
    
//    self.describeTV.text = self.model.describe;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (IBAction)sureAddAction:(UIButton *)sender {
    [self.view endEditing:YES];
    if (!self.addStrogeNumberTF.text.checkIsStock) {
        [MBProgressHUD showError:@"请输入有效数字"];
    } else {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        __weak typeof(self) weakSelf = self;
       int newStock = [self.model.stock intValue] + [self.addStrogeNumberTF.text intValue];
        int newStroge = [self.model.storage intValue] + [self.addStrogeNumberTF.text intValue];
        [self updateSuppliesStockWithNumber:self.model.number newStock:[NSString stringWithFormat:@"%d",newStock] newStorage:[NSString stringWithFormat:@"%d",newStroge] result:^(BOOL success) {
            if (success) {
                [weakSelf updateStorageWithNumber:self.model.number newStock:[NSString stringWithFormat:@"%d",newStroge] newStorage:self.addStrogeNumberTF.text creatName:self.addStrogePeopleName.text describe:self.describeTV.text result:^(BOOL success) {
                    if (success) {
                        [MBProgressHUD showSuccess:@"添加入库成功"];
                        
                        if ([self.delegate respondsToSelector:@selector(addStrogeSuccess)]) {
                            [self.delegate addStrogeSuccess];
                            
                        }
                        [self.navigationController popViewControllerAnimated:YES];
                    } else {
                        [MBProgressHUD showError:@"添加入库失败"];
                    }
                    [hud hideAnimated:YES];
                }];
            }
        }];
    }
    
}

- (void) updateStorageWithNumber: (NSString *) number
                        newStock: (NSString *) newStock
                      newStorage: (NSString *) newStorage
                       creatName: (NSString *) creatName
                        describe: (NSString *) describe
                          result: (void (^) (BOOL success)) result
{
    DBManager *db = [DBManager shareDBManagerA];
    
    [db insertStorageTableNumber:number name:self.model.name stock:newStock storage:newStorage output:@"0" date:self.dateTF.text creatPName:creatName typeName:self.model.typeNumber describe:describe result:^(BOOL success) {
        if (success) {
            NSLog(@"插入入库表成功");
        } else {
            NSLog(@"插入入库表失败");
        }
         result(success);
    }];
    
}

- (void) updateSuppliesStockWithNumber: (NSString *) number
                              newStock: (NSString *) newStock
                            newStorage: (NSString *) newStorage
                                result: (void (^) (BOOL success)) result
{
    
    
    DBManager *db = [DBManager shareDBManagerA];
    
    [db updateSuppliesTableWithNumber:number name:self.model.name stock:newStock storage:newStorage output:self.model.output date:self.model.date creatPName:self.model.creatPeopleName typeName:self.model.typeNumber describe:self.model.describe result:^(BOOL success) {
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
