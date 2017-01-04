//
//  GroupOutputTableViewController.m
//  Storage
//
//  Created by Sam on 16/12/20.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import "GroupOutputTableViewController.h"

#import "GroupDetialTableViewCell.h"

#import "OutputSuppliesDetialTableViewCell.h"

@interface GroupOutputTableViewController ()<OutputSuppliesDetialDelegate, GroupDetialDelegate>

@property (nonatomic, strong) NSArray *numberArray;

@property (nonatomic, strong) NSMutableArray *numberMA;

@property (nonatomic, strong) NSMutableDictionary *outputNumberMD;

@property (nonatomic, strong) NSString *peopleName;

@property (nonatomic, strong) NSString *date;

@property (nonatomic, strong) NSString *describe;

@end

@implementation GroupOutputTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.model.group_name;
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    self.outputNumberMD = [NSMutableDictionary dictionary];
    
    self.numberArray = [self.model.suppliesA componentsSeparatedByString:@","];
    
    [self updateData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) updateData {
    self.numberMA = [NSMutableArray array];
    DBManager *dbM = [DBManager shareDBManagerA];
    __weak typeof(self) weakSelf = self;
    [self.numberArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [dbM selectSuppliesTableWithNumber:obj name:@"" result:^(NSArray *arr) {
            if (arr.count>0) {
                [weakSelf.numberMA addObject:arr[0]];
            }
        }];
    }];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    if (section == 0) {
        return self.numberMA.count;
    } else {
       return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 135;
    } else {
        return 230;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        OutputSuppliesDetialTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"outputSuppliesDetialIdentifier" forIndexPath:indexPath];
        
        [cell setSuppliesModel:self.numberMA[indexPath.row]];
        
        cell.delegate = self;
        
        return cell;
    } else {
        
        GroupDetialTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"groupDetialIdentifier" forIndexPath:indexPath];
        
        [cell setGroupModel:self.model];

        cell.delegate = self;
        
        return cell;
    }
}

#pragma mark - CustomDelegate

- (void) getGroupDetialWithEidt: (NSString *) peopleName date: (NSString *) date {
    
    self.peopleName = peopleName;
    
    self.date = date;
    
}

- (void) getOutputSuppliesDetialWithNumber: (NSString *) outputNumber suppliesNumber: (NSString *) suppliesNumber {
    
    [self.outputNumberMD setValue:outputNumber forKey:suppliesNumber];
    
    
//    NSLog(@"outputNum == %@",self.outputNumberMD);
    
}
/**
 检索物料出库
 */
- (void) checkOutputSuppliesWithResult: (void (^) (BOOL success)) result {
    
    
    __block BOOL isOfOutput = YES;
    
    __block BOOL isSuccess;
    
    [self.numberMA enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        SuppliesModel *suppliesModel = (SuppliesModel *)obj;
        
        if (self.outputNumberMD[suppliesModel.number] == nil) {
            isOfOutput = NO;
            *stop = YES;
            [MBProgressHUD showError:[NSString stringWithFormat:@"%@尚未添加出库数量",suppliesModel.name]];
        } else {
            
            int newStock = [suppliesModel.stock intValue] - [self.outputNumberMD[suppliesModel.number] intValue];
            
            if (newStock >= 0) {
                
            } else {
                isOfOutput = NO;
                *stop = YES;
                [MBProgressHUD showError:[NSString stringWithFormat:@"%@添加出库数量大于库存",suppliesModel.name]];
            }
        }
    }];
    
    if (isOfOutput) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        __weak typeof(self) weakSelf = self;
        [self.numberMA enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            SuppliesModel *suppliesModel = (SuppliesModel *)obj;
            int newStock = [suppliesModel.stock intValue] - [self.outputNumberMD[suppliesModel.number] intValue];
            
            if (newStock >= 0) {
                int newOutput = [suppliesModel.output intValue] + [self.outputNumberMD[suppliesModel.number] intValue];
                
                [weakSelf updateSuppliesStockWithModel:suppliesModel newStock:[NSString stringWithFormat:@"%d",newStock] newOutput:[NSString stringWithFormat:@"%d",newOutput] result:^(BOOL success) {
                    if (success) {
                        [weakSelf updateOutputWithModel:suppliesModel newStock:[NSString stringWithFormat:@"%d",newOutput] newOutput:self.outputNumberMD[suppliesModel.number] creatName:self.peopleName describe:self.describe result:^(BOOL success) {
                            
                            isSuccess = success;
                            
//                            NSLog(@"status111 == %d",success);
                        }];
                    }
                }];
                
            }
            
            
        }];
        [hud hideAnimated:YES];
    }
    
//    NSLog(@"status == %d",isSuccess);
    
    result(isSuccess);
    
}




/**
 确定出库
 */
- (IBAction)sureAction:(UIButton *)sender {
    
//    [self checkOutputSupplies];
    [self.view endEditing:YES];
    [self checkOutputSuppliesWithResult:^(BOOL success) {
        if (success) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }];
    
}

- (void) inserttabel {
    
    
}

- (void) updateOutputWithModel: (SuppliesModel *) model
                      newStock: (NSString *) newStock
                     newOutput: (NSString *) newOutput
                     creatName: (NSString *) creatName
                      describe: (NSString *) describe
                        result: (void (^) (BOOL success)) result
{
    DBManager *db = [DBManager shareDBManagerA];
    
    [db insertOutputTableNumber:model.number name:model.name stock:newStock storage:@"0" output:newOutput date:self.date creatPName:creatName typeName:model.typeNumber describe:_describe == nil ? @"" : self.describe result:^(BOOL success) {
        if (success) {
            NSLog(@"插入出库表成功");
        } else {
            NSLog(@"插入出库表失败");
        }
        result(success);
    }];
    
}

- (void) updateSuppliesStockWithModel: (SuppliesModel *) model
                             newStock: (NSString *) newStock
                            newOutput: (NSString *) newOutput
                               result: (void (^) (BOOL success)) result
{
    
    
    DBManager *db = [DBManager shareDBManagerA];
    
    [db updateSuppliesTableWithNumber:model.number name:model.name stock:newStock storage:model.storage output:newOutput date:model.date creatPName:model.creatPeopleName typeName:model.typeNumber describe:_describe == nil ? @"" : self.describe result:^(BOOL success) {
        if (success) {
            NSLog(@"更新物料表成功");
        } else {
            NSLog(@"更新物料表失败");
        }
        result(success);
    }];
}

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
