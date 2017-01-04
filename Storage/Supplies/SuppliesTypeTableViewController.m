//
//  SuppliesTypeTableViewController.m
//  Storage
//
//  Created by Sam on 16/12/14.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import "SuppliesTypeTableViewController.h"
#import "DBManager.h"
@interface SuppliesTypeTableViewController ()<UITableViewDelegate>

@end

@implementation SuppliesTypeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sureAddWithTypeAction:(UIButton *)sender {
    [self.view endEditing:YES];
    
    if ([self.typeNumberTF.text isEqualToString:@""]) {
        
        [MBProgressHUD showError:@"请输入分类编号"];
        
    } else if ([self.typeNameTF.text isEqualToString:@""]) {
        
        [MBProgressHUD showError:@"请输入分类名称"];
        
    } else {
        
        DBManager *db = [DBManager shareDBManagerA];
        
        [db selectSuppliesTypeTableWithNumber:self.typeNumberTF.text result:^(NSArray *arr) {
            
            if (arr.count > 0 ) {
                [MBProgressHUD showError:@"该分类已存在，请重新添加"];
            } else {
                [db insertSuppliesTypeTableWithNumber:self.typeNumberTF.text name:self.typeNameTF.text describe:self.typeDesTF.text result:^(BOOL success) {
                    if (success) {
                        
                        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"添加分类成功，是否继续添加" preferredStyle:UIAlertControllerStyleAlert];
                        
                        UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                            
                        }];
                        
                        UIAlertAction *actionSure = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            [self.navigationController popViewControllerAnimated:YES];
                        }];
                        
                        [alertC addAction:actionCancel];
                        [alertC addAction:actionSure];
                        
                        [self presentViewController:alertC animated:YES completion:nil];
                    }
                }];  
            }
            
        }];
    
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 4;
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
