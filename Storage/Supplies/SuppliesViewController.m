//
//  SuppliesViewController.m
//  Storage
//
//  Created by Sam on 16/12/13.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import "SuppliesViewController.h"
#import "SuppliesTableViewCell.h"
#import "SuppliesModel.h"
#import "DBManager.h"

#import "GetSuppliesDetialTableViewController.h"
#import "AddOutputTableViewController.h"

static NSString *cellIden = @"SuppliesTableViewCellIden";
@interface SuppliesViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (nonatomic, strong) NSMutableArray *modelArray;


@property (nonatomic, assign) int page;

@property (nonatomic, assign) int size;

@property (nonnull, strong) DBManager *dbM;

@property (nonatomic, strong) SuppliesModel *model;

@end

@implementation SuppliesViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    if (_handelType == HandelTypeOutput) {
        self.navigationItem.rightBarButtonItem = nil;
    }
    
    
    _dbM = [DBManager shareDBManagerA];
    
    self.searchBar.delegate = self;
    
    _page = 0;
    
    _size = 10;
    
    self.modelArray = [NSMutableArray array];
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    self.tableView.tableFooterView = [[UIView alloc] init];

    __weak typeof(self) weakSelf = self;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        weakSelf.page = 0;

        [weakSelf.dbM getSuppliesTableWithPage:weakSelf.page size:weakSelf.size result:^(NSArray *arr) {
            
            if (arr.count != 0 && arr != nil) {
                _modelArray = [NSMutableArray arrayWithArray:arr];
                
                [weakSelf.tableView reloadData];
            }
        }];
        [weakSelf.view endEditing:YES];
        [weakSelf.tableView.mj_header endRefreshing];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        
        
        if (weakSelf.modelArray.count%20 == 0 ) {
            weakSelf.page += 1;
            [weakSelf.dbM getSuppliesTableWithPage:weakSelf.page size:weakSelf.size result:^(NSArray *arr) {
                
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
    
    // Do any additional setup after loading the view.
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.tableView.mj_header beginRefreshing];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    [self.tableView tableViewNoDataWithRowCount:(int)self.modelArray.count showMessage:@"暂无更多数据"];
    
    return self.modelArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SuppliesTableViewCell *cell = (SuppliesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIden forIndexPath:indexPath];
    if (!cell) {
        cell = [[SuppliesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIden];
    }
    
    [cell setModelWithCell:self.modelArray[indexPath.row]];
    
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
    
    if (_handelType == HandelTypeDefaul) {
        
        [self performSegueWithIdentifier:@"SuppliesDetialSegue" sender:Nil];
        
    } else if (_handelType == HandelTypeStorage) {
        
        [self performSegueWithIdentifier:@"" sender:Nil];
        
    } else if (_handelType == HandelTypeOutput) {
        
        [self performSegueWithIdentifier:@"outputToSuppliesSegue" sender:Nil];
        
    }
    
    
        
}
/**
 搜索
 */
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.view endEditing:YES];
    
    NSLog(@"text == %@",searchBar.text);
    
    __weak typeof(self) weakSelf = self;
    
    if (searchBar.text.checkIsStock) {
        [self.dbM selectSuppliesTableWithNumber:searchBar.text name:@"" result:^(NSArray *arr) {
            
            weakSelf.modelArray = [NSMutableArray arrayWithArray:arr];
            
            [weakSelf.tableView reloadData];
            
        }];
    } else {
        
        [self.dbM selectSuppliesTableWithNumber:@"" name:searchBar.text  result:^(NSArray *arr) {
            
            weakSelf.modelArray = [NSMutableArray arrayWithArray:arr];
            
            [weakSelf.tableView reloadData];
            
        }];
    }
}

- (IBAction)addSuppliesAction:(UIBarButtonItem *)sender {
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.view endEditing:YES];
//    [self.searchBar endEditing:YES];
//    [self.tableView endEditing:YES];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"SuppliesDetialSegue"]) {
        GetSuppliesDetialTableViewController *detial = (GetSuppliesDetialTableViewController *)[segue destinationViewController];
        detial.model = self.model;
        NSLog(@"model == %@",detial.model.number);
    }else if ([segue.identifier isEqualToString:@"outputToSuppliesSegue"]) {
        AddOutputTableViewController *detial = (AddOutputTableViewController *)[segue destinationViewController];
        detial.model = self.model;
    }
    
}


@end
