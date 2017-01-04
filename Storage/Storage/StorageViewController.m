//
//  StorageViewController.m
//  Storage
//
//  Created by Sam on 16/12/16.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import "StorageViewController.h"
#import "SuppliesModel.h"
#import "StrogeDetialTableViewController.h"
@interface StorageViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (nonatomic, assign) int page;

@property (nonatomic, assign) int size;

@property (nonatomic, strong) DBManager *dbM;

@property (nonatomic, strong) NSMutableArray *modelArray;

@property (nonatomic, strong) SuppliesModel *model;
@end

@implementation StorageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.tableView.estimatedRowHeight = 44
//    self.tableView.rowHeight = UITableViewAutomaticDimension
    
    _dbM = [DBManager shareDBManagerA];
    
    self.searchBar.delegate = self;
    
    _page = 0;
    
    _size = 20;
    
    self.modelArray = [NSMutableArray array];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        
        weakSelf.page = 0;
        
        [weakSelf.dbM getStorageTableWithPage:weakSelf.page size:weakSelf.size result:^(NSArray *arr) {
            
            if (arr.count != 0 && arr != nil) {
                _modelArray = [NSMutableArray arrayWithArray:arr];
                
                [weakSelf.tableView reloadData];
            }
        }];
        [weakSelf.view endEditing:YES];
        [weakSelf.tableView.mj_header endRefreshing];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        if (weakSelf.modelArray.count%20 == 0 && weakSelf.modelArray.count != 0) {
            
            weakSelf.page += 1;
            
            [weakSelf.dbM getStorageTableWithPage:weakSelf.page size:weakSelf.size result:^(NSArray *arr) {
                
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
   
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView.mj_header beginRefreshing];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    [self.tableView tableViewNoDataWithRowCount:(int)self.modelArray.count showMessage:@"暂无入库数据"];
    return self.modelArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    StorageTableViewCell *cell = (StorageTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"stroageCellIdent" forIndexPath:indexPath];
    if (!cell) {
        cell = [[StorageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"stroageCellIdent"];
    }
    
    [cell setStorageModel:self.modelArray[indexPath.row]];
    
    return cell;
    
}
//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *headerView = [[UIView alloc] init];
//    
//    headerView.backgroundColor = [UIColor whiteColor];
//    
//    UILabel *numberL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 44, 30)];
//    numberL.text = @"编号";
//    numberL.textAlignment = NSTextAlignmentCenter;
//    [headerView addSubview:numberL];
//    
//    UILabel *nameL = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 190, 30)];
//    nameL.text = @"名称";
//    nameL.textAlignment = NSTextAlignmentLeft;
//    [headerView addSubview:nameL];
//    
//    UILabel *stockL = [[UILabel alloc] initWithFrame:CGRectMake(270, 0, 72, 30)];
//    stockL.text = @"库存";
//    stockL.textAlignment = NSTextAlignmentLeft;
//    [headerView addSubview:stockL];
//    
//    return headerView;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 30;
//}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.view endEditing:YES];
    self.model = self.modelArray[indexPath.row];
    [self performSegueWithIdentifier:@"stroageDetialSegue" sender:Nil];
    
}
/**
 搜索
 */
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [self.view endEditing:YES];
    
    __weak typeof(self) weakSelf = self;
    
    if (searchBar.text.checkIsStock) {
        [self.dbM selectedStorageTabelWithNumber:searchBar.text name:@"" page:0 size:20 result:^(NSArray *arr) {
            
            weakSelf.modelArray = [NSMutableArray arrayWithArray:arr];
            
            [weakSelf.tableView reloadData];
            
        }];
    } else {
        
        [self.dbM selectedStorageTabelWithNumber:@"" name:searchBar.text page:0 size:20 result:^(NSArray *arr) {
            weakSelf.modelArray = [NSMutableArray arrayWithArray:arr];
            
            [weakSelf.tableView reloadData];
        }];
    }
    
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"stroageDetialSegue"]) {
        StrogeDetialTableViewController *detial = (StrogeDetialTableViewController *)[segue destinationViewController];
        detial.model = self.model;
        detial.stoargeOrOutput = 0;
        NSLog(@"model == %@",detial.model.number);
    }
    
}

@end
