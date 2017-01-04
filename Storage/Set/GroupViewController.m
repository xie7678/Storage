//
//  GroupViewController.m
//  Storage
//
//  Created by Sam on 16/12/16.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import "GroupViewController.h"
#import "GroupDetialTableViewController.h"
#import "GroupOutputTableViewController.h"
@interface GroupViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) int page;

@property (nonatomic, assign) int size;

@property (nonatomic, strong) NSMutableArray *modelArray;

@property (nonatomic, strong) GroupModel *model;

@property (nonatomic, strong) DBManager *dbM;

@property (nonatomic, assign) int selectedRow;

@end

@implementation GroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_groupType == GroupTypeOutput) {
//        self.navigationItem.rightBarButtonItem = nil;
    }
    
    self.size = 20;
    self.selectedRow = 0;
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    // Do any additional setup after loading the view.
    
    self.modelArray = [NSMutableArray array];
    
    self.dbM = [DBManager shareDBManagerA];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        
        weakSelf.page = 0;
        
//        weakSelf.size = 10;
        
        [weakSelf.dbM selectGroupAndSuppliesWithPage:weakSelf.page size:weakSelf.size result:^(NSArray *arr) {
            
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
//            weakSelf.size = 10;
            [weakSelf.dbM selectGroupAndSuppliesWithPage:self.page size:weakSelf.size result:^(NSArray *arr) {
                
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

#pragma mark - tableDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    [self.tableView tableViewNoDataWithRowCount:(int)self.modelArray.count showMessage:@"暂无分组数据"];
    return self.modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GroupCellIden" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[GroupTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GroupCellIden"];
    }
    
    [cell setGroupModel:self.modelArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectedRow = (int)indexPath.row;
    if (_groupType == GroupTypeOutput) {
        [self performSegueWithIdentifier:@"addGroupOutputSegue" sender:nil];
    } else {
        [self performSegueWithIdentifier:@"groupDetialSegue" sender:nil];
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
    if ([segue.identifier isEqualToString:@"groupDetialSegue"]) {
        GroupDetialTableViewController *vc = (GroupDetialTableViewController *)[segue destinationViewController];
        vc.model = self.modelArray[_selectedRow];
    } else if ([segue.identifier isEqualToString:@"addGroupOutputSegue"]) {
        GroupOutputTableViewController *vc = (GroupOutputTableViewController *)[segue destinationViewController];
        vc.model = self.modelArray[_selectedRow];
        
    }
}


@end
