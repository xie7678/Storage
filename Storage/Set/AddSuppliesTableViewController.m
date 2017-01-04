//
//  AddSuppliesTableViewController.m
//  Storage
//
//  Created by Sam on 16/12/15.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import "AddSuppliesTableViewController.h"
#import "AddSuppliesTableViewCell.h"
@interface AddSuppliesTableViewController ()<GetSelectedSuppliesDelegate>

@property (nonatomic, strong) NSMutableArray *modelArray;


@property (nonatomic, assign) int page;

@property (nonatomic, assign) int size;

@property (nonnull, strong) DBManager *dbM;

@property (nonatomic, strong) SuppliesModel *model;

@property (nonatomic, strong) NSMutableArray *numberMA;

@end

@implementation AddSuppliesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _numberMA = [NSMutableArray array];
    
//    [_numberMA addObject:@"1001"];
//    [_numberMA addObject:@"1002"];
    
    _dbM = [DBManager shareDBManagerA];
    
    _page = 0;
    
    _size = 10;
    
    self.modelArray = [NSMutableArray array];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    __weak typeof(self) weakSelf = self;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf.numberMA removeAllObjects];
        
        weakSelf.page = 0;
        weakSelf.size = 10;
        [weakSelf.dbM getSuppliesTableWithPage:weakSelf.page size:weakSelf.size = 10 result:^(NSArray *arr) {
            
            if (arr.count != 0 && arr != nil) {
                _modelArray = [NSMutableArray arrayWithArray:arr];
                [weakSelf.tableView reloadData];
            }
        }];
        [weakSelf.view endEditing:YES];
        [weakSelf.tableView.mj_header endRefreshing];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        if (weakSelf.modelArray.count%10 == 0 ) {
            weakSelf.page += 1;
            weakSelf.size = 10;
            [weakSelf.dbM getSuppliesTableWithPage:self.page size:10 result:^(NSArray *arr) {
                
                if (arr.count != 0 && arr != nil) {
                    [_modelArray addObjectsFromArray:arr];
                    
                    [weakSelf.tableView reloadData];
                    
                } else {
                    
                    weakSelf.page -= 1;
                    
                }
                
            }];
        }
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
    
    [self.tableView.mj_header beginRefreshing];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    [self.tableView tableViewNoDataWithRowCount:(int)self.modelArray.count showMessage:@"暂无物料请先添加物料"];
    return self.modelArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddSuppliesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"suppliesCellInden" forIndexPath:indexPath];
    
    [cell setSuppliesModel:self.modelArray[indexPath.row]];
    
    cell.delegate = self;
    // Configure the cell...
    
    return cell;
}

//确认
- (IBAction)sureAction:(UIButton *)sender {
    
    if (self.numberMA.count <= 0) {
        [MBProgressHUD showError:@"请选择物料加入分组"];
    } else {
        if ([self.delagate respondsToSelector:@selector(getSelectedSuppliesArray:)]) {
            [self.delagate getSelectedSuppliesArray:self.numberMA];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
}

#pragma mark - GetSelectedSuppliesDelegate

- (void) getSelectedSuppliesWithModel: (SuppliesModel *) model {
    
    __weak typeof(self) weakSelf = self;
    
    if (model.isOfSelected) {
        
        __block BOOL isOfSelected = NO;
        
        [self.numberMA enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([model.number isEqualToString:obj]) {
                *stop = YES;
                isOfSelected = YES;
            }
            
//            NSLog(@"3遍历array：%zi-->%@",idx,obj);
            
        }];
        if (!isOfSelected) {
            [self.numberMA addObject:model.number];
        }
        
    } else {
        
        [self.numberMA enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([model.number isEqualToString:obj]) {
                *stop = YES;
                [weakSelf.numberMA removeObject:obj];
            }
            
//            NSLog(@"3遍历array：%zi-->%@",idx,obj);
            
        }];
    }
    NSLog(@"number == %@", self.numberMA);
    
}

//- (void) check

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
