//
//  SuppliesListTableViewController.m
//  Storage
//
//  Created by Sam on 16/12/19.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import "SuppliesListTableViewController.h"
#import "SuppliesTableViewCell.h"
#import "SuppliesModel.h"

@interface SuppliesListTableViewController ()

@property (nonatomic, strong) NSMutableArray *numberMA;

@end

@implementation SuppliesListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self getData];
}

- (void) getData {
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.numberMA = [NSMutableArray array];
    DBManager *dbM = [DBManager shareDBManagerA];
    __weak typeof(self) weakSelf = self;
    [self.numberArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.numberArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SuppliesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SuppliesTableViewCellIden" forIndexPath:indexPath];
    
    [cell setModelWithCell:self.numberMA[indexPath.row]];
    // Configure the cell...
    
    return cell;
}

//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *headerView = [[UIView alloc] init];
//    
//    headerView.backgroundColor = [UIColor whiteColor];
//    
//    UILabel *numberL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
//    numberL.text = @"编号";
//    numberL.font = [UIFont systemFontOfSize:14.0];
//    numberL.textAlignment = NSTextAlignmentCenter;
//    [headerView addSubview:numberL];
//    
//    UILabel *nameL = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 190, 30)];
//    nameL.text = @"名称";
//    nameL.font = [UIFont systemFontOfSize:14.0];
//    nameL.textAlignment = NSTextAlignmentLeft;
//    [headerView addSubview:nameL];
//    
//    UILabel *stockL = [[UILabel alloc] initWithFrame:CGRectMake(270, 0, 72, 30)];
//    stockL.text = @"库存";
//    stockL.font = [UIFont systemFontOfSize:14.0];
//    stockL.textAlignment = NSTextAlignmentLeft;
//    [headerView addSubview:stockL];
//    
//    return headerView;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 30;
//}
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
