//
//  FollowingViewController.m
//  Rockz
//
//  Created by Admin on 10/26/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "FollowingViewController.h"

#import "UserProfileViewController.h"
#import "UserCollectionCell.h"
#import "User.h"
#import "Globalvariables.h"
#import "GlobalFunction.h"
#import "Constants.h"

@interface FollowingViewController ()
@end

@implementation FollowingViewController

//@synthesize dataArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _httpclient = [[Httpclient alloc] init];
    _httpclient.controller = self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadFollowersData];
    [self.collectionView reloadData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_dataArray  == nil ) {
        return 0;
    }
    return [_dataArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UserCollectionCell";
    
    UserCollectionCell *cell=(UserCollectionCell*)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    User *user = (User*)[_dataArray objectAtIndex:indexPath.row];
    [cell setContents:user index:indexPath.row];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(86, 150);
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField {
    [textField resignFirstResponder];
    return NO; // We do not want UITextField to insert line-breaks.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)loadFollowersData {
    NSString *urlString = [NSString stringWithFormat:@"%@/%@/%@", ROCKZ_SERVICE_URL, API_GET_FOLLOWING, gUserID];
    NSLog(@"%@", urlString);
    if (gArrFollowing == nil) {
        gArrFollowing = [[NSMutableArray alloc] init];
    }
    [gArrFollowing removeAllObjects];
    NSDictionary *resultDic = sendHttpRequestSynchronous(urlString, @"GET");
    if (resultDic == nil) {
        [self showAlert:@"failed to connect internal server"];
        return;
    }
    NSString *resultStr = resultDic[@"result"];
    if ([resultStr isEqualToString:@"fail"]) {
        gArrFollowing = nil;
        return;
    }
    NSArray *arr = resultDic[@"following"];
    for (NSDictionary *dic in arr) {
        User *user = [[User alloc] init];
        user.userID = dic[@"id"];
        user.emailAddress = dic[@"email"];
        user.facebookID = dic[@"facebookid"];
        user.firstName = dic[@"firstname"];
        user.lastName = dic[@"lastname"];
        user.photoURL = dic[@"photo"];
        user.coverURL = dic[@"coverphoto"];
        [gArrFollowing addObject:user];
    }
    _dataArray  = [NSMutableArray arrayWithArray:gArrFollowing];
}

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)showMenu:(id)sender {
    showSideMenu(self);
}

- (IBAction)search:(id)sender {
    [_dataArray removeAllObjects];
    NSString *searchText = [NSString stringWithString:_searchKeyTextField.text];
    if ([searchText isEqualToString:@""]) {
        _dataArray = [NSMutableArray arrayWithArray:gArrFollowing];
        [_collectionView reloadData];
        return;
    }

    for (int i= 0 ; i < gArrFollowing.count; i++) {
        User *user = (User *)gArrFollowing[i];
        NSString *firstname = [NSString stringWithString:user.firstName];
        NSString *lastname = [NSString stringWithString:user.lastName];
        if ([firstname rangeOfString:searchText].location != NSNotFound || [lastname rangeOfString:searchText].location != NSNotFound) {
            [_dataArray addObject:user];
        }
    }
    [_collectionView reloadData];
}

- (IBAction)showUser:(id)sender {
//    UIButton *button = (UIButton*)sender;
//    NSInteger index = button.tag;
//    User* user = (User*)[gArrFollowing objectAtIndex:index];
//    UserProfileViewController *userProfileViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"UserProfileViewController"];
//    [userProfileViewController setUser:user];
//    [self.navigationController pushViewController:userProfileViewController animated:YES];
}

- (IBAction)doAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSInteger index = button.tag;
    User *user = (User *)_dataArray[index];
    NSString *urlString = [NSString stringWithFormat:@"%@/%@?userid=%@&unfollowid=%@",ROCKZ_SERVICE_URL, API_UNFOLLOW,  gUserID, user.userID];
    NSLog(@"unfollow url -- %@", urlString);
    [_httpclient setServerAddress:urlString];
    [_httpclient setGetway];
    [_httpclient start];
    [_dataArray removeObjectAtIndex:index];
    [_collectionView reloadData];
    
}

- (void) showAlert:(NSString *) message{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warning" message:message delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
    [alertView show];
}

#pragma mark - http client event
-(void) requestSuccess:(NSDictionary *) dictionary{
    NSString *resultStr = dictionary[@"result"];
    NSLog(@"result- %@", resultStr);
}
-(void) requestSuccessWithEmptyData{
    
}
-(void) requestError:(NSError *) error{
    
}

#pragma mark - side menu event
- (void)hideSideMenu{
    [ApplicationDelegate.sideMenuViewController.view removeFromSuperview];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
