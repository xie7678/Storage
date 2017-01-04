//
//  SuppliesDetialTableViewController.m
//  Storage
//
//  Created by Sam on 16/12/13.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import "SuppliesDetialTableViewController.h"
#import "MBProgressHUD+MJ.h"
#import "GetSuppliesDetialTableViewController.h"
#import "SuppliesModel.h"
#import "SuppliesTypeModel.h"
@interface SuppliesDetialTableViewController ()<UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) NSArray *heightWithRow;

@property (nonatomic, assign) BOOL isOfSelected;

@property (nonatomic, strong) NSArray *typeArray;

@property (nonatomic, assign) int selectType;

@end

@implementation SuppliesDetialTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _isOfSelected = NO;
    
    _selectType = 0;
    
    _heightWithRow = [NSArray arrayWithObjects:@44, @44, @44, @0, @44, @44, @44, @125, @70, nil];
    
    _typeArray = [NSArray array];
    
    self.tableView.delegate = self;
    
    self.pickerView.delegate = self;
    
    self.pickerView.dataSource = self;
    
    self.dateTF.text = [Tool getDefauleDate];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self getSuppliesWithType];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**物料分类*/
- (void) getSuppliesWithType {
    
    DBManager *db = [DBManager shareDBManagerA];
    [db selectSuppliesTypeTableWithAll:^(NSArray *arr) {
        if (arr.count > 0) {
            self.typeArray = arr;
        }
    }];
    
}

- (IBAction)sureAction:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    if ([self.numberTF.text isEqualToString:@""]) {
        
        [MBProgressHUD showError:@"请输入物料编号" toView:self.view];
        
    } else if ([self.nameTF.text isEqualToString:@""]) {
        
        [MBProgressHUD showError:@"请输入物料名称" toView:self.view];
        
    } else if ([self.stockTF.text isEqualToString:@""]) {
        
        [MBProgressHUD showError:@"请输入物料数量" toView:self.view];
        
    } else if ([self.storageNameTF.text isEqualToString:@""]) {
        
        [MBProgressHUD showError:@"请输入物料入库人姓名" toView:self.view];
        
    } else if ([self.typeTF.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请选择物料类型" toView:self.view];
    } else {
        
        DBManager *db = [DBManager shareDBManagerA];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        [db selectSuppliesTableWithNumber:self.numberTF.text name:@"" result:^(NSArray *arr) {
            
            [hud hideAnimated:YES];
            
            if (arr.count != 0) {
                
                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"当前编号物料已存在，取消留在当前界面修改，确定前往该编号对应详情" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                UIAlertAction *actionSure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    self.model = arr[0];
                    [self performSegueWithIdentifier:@"addToDetialSegue" sender:nil];
                }];
                
                [alertC addAction:actionCancel];
                [alertC addAction:actionSure];
                
                [self presentViewController:alertC animated:YES completion:nil];
                
                
            } else {
                /**
                 插入物料数据
                 */
                SuppliesTypeModel *typeModel = (SuppliesTypeModel *)self.typeArray[self.selectType];
                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否检查入库数据，取消留在当前界面修改，确定添加入库" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                UIAlertAction *actionSure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    /**插入物料表*/
                    [db insertSuppliesTableNumber:self.numberTF.text name:self.nameTF.text stock:self.stockTF.text storage:self.stockTF.text output:@"0" date:self.dateTF.text creatPName:self.storageNameTF.text typeName:typeModel.type_number describe:self.describeTV.text result:^(BOOL success) {
                        if (success) {
                            [db insertStorageTableNumber:self.numberTF.text name:self.nameTF.text stock:self.stockTF.text storage:self.stockTF.text output:@"0" date:self.dateTF.text creatPName:self.storageNameTF.text typeName:typeModel.type_number describe:self.describeTV.text result:^(BOOL success) {
                                if (success) {
                                    NSLog(@"插入入库表成功");
                                    [self.navigationController popViewControllerAnimated:YES];
                                }
                            }];
                            
                        }
                    }];
                }];
                
                [alertC addAction:actionCancel];
                [alertC addAction:actionSure];
                
                [self presentViewController:alertC animated:YES completion:nil];
                
            }
            
        }];
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [_heightWithRow[indexPath.row] floatValue];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self.view endEditing:YES];
    if (indexPath.row == 2) {
        
        if (self.typeArray.count > 0) {
            _isOfSelected = !_isOfSelected;
            if (self.typeTF.text == nil || [self.typeTF.text isEqualToString:@""]) {
                SuppliesTypeModel *typeModel = (SuppliesTypeModel *)self.typeArray[0];
                self.typeTF.text = typeModel.type_name;//为物料分类赋初值
                self.selectType = 0;
            }
            _heightWithRow = @[@44, @44, @44, _isOfSelected ? @144 : @0, @44, @44, @44, @125, @70];
            [self.tableView reloadData];
        } else {
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"尚未添加物料分类，请点击右上角‘＋’前往添加分类" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alertC addAction:actionCancel];
            
            [self presentViewController:alertC animated:YES completion:nil];
        }
    }
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.typeArray.count;
}
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component __TVOS_PROHIBITED {
    SuppliesTypeModel *type = (SuppliesTypeModel *)self.typeArray[row];
    return type.type_name;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    //    NSLog(@"row == %ld",(long)row);
    SuppliesTypeModel *typeModel = (SuppliesTypeModel *)self.typeArray[row];
    self.typeTF.text = typeModel.type_name;//为物料分类赋初值
    self.selectType = (int)row;
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 6;
//}

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
    if ([segue.identifier isEqualToString:@"addToDetialSegue"]) {
        GetSuppliesDetialTableViewController *detial = (GetSuppliesDetialTableViewController *)[segue destinationViewController];
        detial.model = self.model;
        //         NSLog(@"model == %@",detial.model.number);
    }
}
- (IBAction)cancelAction:(UIButton *)sender {
    _isOfSelected = !_isOfSelected;
    _heightWithRow = @[@44, @44, @44, @0, @44, @44, @44, @125, @70];
    [self.tableView reloadData];
}

- (IBAction)getTypeAction:(UIButton *)sender {
    _isOfSelected = !_isOfSelected;
    _heightWithRow = @[@44, @44, @44, @0, @44, @44, @44, @125, @70];
    [self.tableView reloadData];
}


@end
