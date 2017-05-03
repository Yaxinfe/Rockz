//
//  FollowersViewController.m
//  Rockz
//
//  Created by Admin on 10/26/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "FollowersViewController.h"

#import "UserProfileViewController.h"
#import "FollowerCollectionViewCell.h"
#import "User.h"
#import "Constants.h"
#import "UIImageView+WebCache.h"
#import "Globalvariables.h"
#import "GlobalFunction.h"

@interface FollowersViewController ()

@end

@implementation FollowersViewController

@synthesize dataArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _httpClient = [[Httpclient alloc] init];
    _httpClient.controller = self;
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadFollowersData];
    [self.collectionView reloadData];
}

- (void)viewDidAppear:(BOOL)animated {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [dataArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FollowerCollectionViewCell";
    
    FollowerCollectionViewCell *cell=(FollowerCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    User *user = (User*)[dataArray objectAtIndex:indexPath.row];
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
    if (dataArray == nil) {
        dataArray = [[NSMutableArray alloc] init];
    }
    if (gArrFollower == nil) {
        gArrFollower = [[NSMutableArray alloc] init];
    }
    [dataArray removeAllObjects];
    [gArrFollower removeAllObjects];
    
    NSString *urlString = [NSString stringWithFormat:@"%@/%@/%@", ROCKZ_SERVICE_URL, API_GET_FOLLOWER, gUserID];
    NSDictionary *resultDic =  sendHttpRequestSynchronous(urlString, @"GET");
    if (resultDic == nil) {
        [self showAlert:@"warning" message:@"Failed to connect internal server."];
        return;
    }
    NSString *str = (NSString *)resultDic[@"result"];
    if ([str isEqualToString:@"fail"]) {
        return;
    }
    NSArray *arr = (NSArray *)resultDic[@"follower"];
    for (NSDictionary *dic in arr) {
        User *user = [[User alloc] init];
        user.userID = (NSString *)dic[@"id"];
        user.firstName = (NSString *)dic[@"firstname"];
        user.lastName = (NSString *)dic[@"lastname"];
        user.facebookID = (NSString *)dic[@"facebookid"];
        user.photoURL = (NSString *)dic[@"photo"];
        user.emailAddress = (NSString *)dic[@"email"];
        user.attend_status = [(NSString *)dic[@"allow"] intValue];
        [gArrFollower addObject:user];
    }
    dataArray = [NSMutableArray arrayWithArray:gArrFollower];
}


- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)showMenu:(id)sender {
    showSideMenu(self);
}

- (IBAction)search:(id)sender {
    [dataArray removeAllObjects];
    NSString *searchText = [NSString stringWithString:_searchKeyTextField.text];
    if ([searchText isEqualToString:@""]) {
        dataArray = [NSMutableArray arrayWithArray:gArrFollower];
        [_collectionView reloadData];
        return;
    }

    for (int i= 0 ; i < gArrFollower.count; i++) {
        User *user = (User *)gArrFollower[i];
        NSString *firstname = [NSString stringWithString:user.firstName];
        NSString *lastname = [NSString stringWithString:user.lastName];
        if ([firstname rangeOfString:searchText].location != NSNotFound || [lastname rangeOfString:searchText].location != NSNotFound) {
            [dataArray addObject:user];
        }
    }
    [_collectionView reloadData];
    
}

- (IBAction)showUser:(id)sender {
//    UIButton *button = (UIButton*)sender;
//    NSInteger index = button.tag;
    
//    User* user = (User*)[dataArray objectAtIndex:index];
//    UserProfileViewController *userProfileViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"UserProfileViewController"];
//    [userProfileViewController setUser:user];
//    [self.navigationController pushViewController:userProfileViewController animated:YES];
}

- (IBAction)doAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSInteger index = button.tag;
    [button.imageView setImage:[UIImage imageNamed:@"btn_attenders_following.png"]];
    User *user = (User *)dataArray[index];
    user.attend_status = 0;
    [_collectionView reloadData];
    NSString *urlString = [NSString stringWithFormat:@"%@/%@?userid=%@&allowid=%@",ROCKZ_SERVICE_URL, API_ALLOW_FOLLOWING_ME,  gUserID, user.userID];
    NSLog(@"unfollow url -- %@", urlString);
    [_httpClient setServerAddress:urlString];
    [_httpClient setGetway];
    [_httpClient start];

    
}

- (void) showAlert:(NSString *)title message:(NSString *)message{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
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
