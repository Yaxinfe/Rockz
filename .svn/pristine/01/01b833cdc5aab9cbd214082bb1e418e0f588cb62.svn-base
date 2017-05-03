//
//  SearchResultsViewController.m
//  Rockz
//
//  Created by Admin on 10/31/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "SearchResultsViewController.h"

#import "UserProfileViewController.h"
#import "GlobalFunction.h"
#import "Globalvariables.h"
#import "Constants.h"
#import "UserCell.h"
#import "User.h"

@implementation SearchResultsViewController

@synthesize dataArray, searchKey;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.backgroundColor = [UIColor clearColor];
    dataArray = [[NSMutableArray alloc] init];
    //    self.attendersTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    dataArray = gArrSearchUsers;
        [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _searchKeyTextField.text = searchKey;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"UserCell";
    
    UserCell *cell = (UserCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = (UserCell*)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    User *user = (User*)[dataArray objectAtIndex:indexPath.row];
    [cell setContents:user index:indexPath.row];
    return cell;
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField {
    [textField resignFirstResponder];
    return NO; // We do not want UITextField to insert line-breaks.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)searchUser {
    
    NSString *urlString = [NSString stringWithFormat:@"%@/%@?userid=%@&text=%@", ROCKZ_SERVICE_URL, API_SEARCH_USER, gUserID, searchKey];
    NSLog(@"search url - %@", urlString);
    NSDictionary *resultDic = sendHttpRequestSynchronous(urlString, @"GET");
    if (resultDic == nil) {
        [self showAlert:@"warning" message:@"failed to connect internal server"];
        return;
    }
    NSString *str = resultDic[@"result"];
    if ([str isEqualToString:@"fail"]) {
        [self showAlert:@"Warning" message:@"No anybody."];
        return;
    }
    [dataArray removeAllObjects];
    NSArray *resultArr = (NSArray *)resultDic[@"users"];
    for (NSDictionary *dic in resultArr) {
        User *user = [[User alloc] init];
        user.userID = dic[@"id"];
        user.firstName = dic[@"firstname"];
        user.lastName = dic[@"lastname"];
        user.photoURL = dic[@"photo"];
        user.coverURL = dic[@"coverphoto"];
        [dataArray addObject:user];
    }
    [_tableView reloadData];
}

- (IBAction)searchUser:(id)sender {
    searchKey = self.searchKeyTextField.text;
    [self searchUser];
}

- (IBAction)showUser:(id)sender {
    UIButton *button = (UIButton*)sender;
    NSInteger index = button.tag;
    
    User* user = (User*)[dataArray objectAtIndex:index];
    UserProfileViewController *userProfileviewController = [self.storyboard instantiateViewControllerWithIdentifier:@"UserProfileViewController"];
    [userProfileviewController setUser:user];
    [self.navigationController pushViewController:userProfileviewController animated:YES];
}

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)showMenu:(id)sender {
    showSideMenu(self);
}

- (void) showAlert:(NSString *)title message:(NSString *)message{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
    [alertView show];
}

#pragma mark - side menu event
- (void)hideSideMenu{
    [ApplicationDelegate.sideMenuViewController.view removeFromSuperview];
}

@end

//NSMutableArray* searchUserByName(NSString* key) {
//    return nil;
//}
