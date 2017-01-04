//
//  AddGroupTableViewController.m
//  Storage
//
//  Created by Sam on 16/12/16.
//  Copyright © 2016年 Sam. All rights reserved.
//

#import "AddGroupTableViewController.h"
#import "AddSuppliesTableViewController.h"
@interface AddGroupTableViewController ()<UITableViewDelegate, GetSelectedSuppliesArrayDelegate>

@property (nonatomic, strong) NSArray *numberArray;

@end

@implementation AddGroupTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.numberArray = [NSArray array];
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


- (IBAction)sureAddGroupAction:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    if (self.numberArray.count > 0) {
        
        NSMutableString *numberStr = [NSMutableString string];
        
        for (int i = 0; i < self.numberArray.count; i ++) {
            if (i == 0) {
                [numberStr appendFormat:@"%@", self.numberArray[i]];
            } else {
                [numberStr appendFormat:@",%@", self.numberArray[i]];
            }
        }
        
        DBManager *dbM = [DBManager shareDBManagerA];
        [dbM insertGroupWithName:self.groupName.text describe:self.describeTV.text supplies:numberStr date:[Tool getDefauleDate] creatName:self.creatNameTF.text result:^(BOOL success) {
            if (success) {
                [MBProgressHUD showSuccess:@"添加分组成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    } else {
        [MBProgressHUD showError:@"请选择物料"];
    }
    
    
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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

- (void) getSelectedSuppliesArray: (NSArray *) arr {
    
    self.selectedSuppliesContentLabel.text = [NSString stringWithFormat:@"已选择 %lu 个物料",(unsigned long)arr.count];
    
    self.numberArray = arr;
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"groupSuppliesSegue"]) {
        AddSuppliesTableViewController *controller = (AddSuppliesTableViewController *)[segue destinationViewController];
        controller.delagate = self;
    }
}


@end
