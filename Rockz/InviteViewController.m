//
//  InviteViewController.m
//  Rockz
//
//  Created by Admin on 10/31/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "InviteViewController.h"
#import "Globalvariables.h"
#import "GlobalFunction.h"
#import "Constants.h"
#import "PartyFeedViewController.h"
#import "UserCell.h"
#import "User.h"
#import "CreatePartyViewController.h"

@implementation InviteViewController

@synthesize dataArray;

- (void)viewDidLoad{
    [super viewDidLoad];
    _inviteStatusList = [[NSMutableDictionary alloc] init];
    dataArray = [[NSMutableArray alloc] init];
    _originalArray = [[NSMutableArray alloc] init];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_inviteStatusList removeAllObjects];
    [self loadData];
    [_tableView reloadData];
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
    NSString *cellCheckStatus = [_inviteStatusList objectForKey:user.userID];
    if ([cellCheckStatus isEqualToString:@"check"]) {
        [cell.inviteCheckImage setImage:[UIImage imageNamed:@"btn_invite_check.png"]];
    }else{
        [cell.inviteCheckImage setImage:[UIImage imageNamed:@"btn_invite_uncheck.png"]];
    }
    [cell setContents:user index:indexPath.row];
    
    return cell;
}

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)showMenu:(id)sender {
    showSideMenu(self);
}

- (IBAction)searchUser:(id)sender {
    [dataArray removeAllObjects];
    NSString *searchText = [NSString stringWithString:_searchKeyTextField.text];
    if ([searchText isEqualToString:@""]) {
        [dataArray addObjectsFromArray:_originalArray];
        [_tableView reloadData];
        return;
    }

    for (int i= 0 ; i < _originalArray.count; i++) {
        User *user = (User *)_originalArray[i];
        NSString *firstname = [NSString stringWithString:user.firstName];
        NSString *lastname = [NSString stringWithString:user.lastName];
        if ([firstname rangeOfString:searchText].location != NSNotFound || [lastname rangeOfString:searchText].location != NSNotFound) {
            [dataArray addObject:user];
        }
    }
    [_tableView reloadData];

}

- (IBAction)checkUser:(id)sender {
    
}

- (IBAction)showUser:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSInteger tag = button.tag;
    User *user = (User *)dataArray[tag];
    NSString * InviteStatus = [_inviteStatusList objectForKey:user.userID];
    if ([InviteStatus isEqualToString:@"check"]) {
        [_inviteStatusList setObject:@"uncheck" forKey:user.userID];
    }else{
        [_inviteStatusList setObject:@"check" forKey:user.userID];
    }
    [_tableView reloadData];
}
- (IBAction)onInviteAll:(id)sender {
    for (User *user in dataArray) {
        if (_inviteAllSwitch.on) {
            [_inviteStatusList setObject:@"check" forKey:user.userID];
        }else{
            [_inviteStatusList setObject:@"uncheck" forKey:user.userID];
        }
    }
    [_tableView reloadData];
}

- (IBAction)doneInvite:(id)sender {
    if ([_strCallFromWhichController isEqualToString:@"addhost"]) {
        NSMutableArray *inviteHostLists = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < dataArray.count; i++) {
            User *user = (User *)dataArray[i];
            NSString *userID = user.userID;
            NSString *status = [_inviteStatusList objectForKey:userID];
            if ([status isEqualToString:@"check"]) {
                [inviteHostLists addObject:user];
            }
        }
        
        NSUInteger countNav = self.navigationController.viewControllers.count;
        CreatePartyViewController *viewController = (CreatePartyViewController *)[self.navigationController.viewControllers objectAtIndex:countNav - 2];
        viewController.strCallFromWhichController = @"InviteViewController";
        viewController.invitedHostList = [NSMutableArray arrayWithArray:inviteHostLists];
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
    if ([_strCallFromWhichController isEqualToString:@"CreatePartyViewController"]) {
        [self invite];
        PartyFeedViewController *viewController = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-3];
        [self.navigationController popToViewController:viewController animated:YES];
    }
    
    if ([_strCallFromWhichController isEqualToString:@"DetailsOfPartyForHostViewController"]) {
        [self invite];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    if ([_strCallFromWhichController isEqualToString:@"DetailsOfPartyViewControler"]) {
        [self invite];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}


- (void) loadData{
    NSDictionary *resultDic = nil;
    
    if ([_strCallFromWhichController isEqualToString:@"DetailsOfPartyViewControler"]) {
        NSString *urlString = [NSString stringWithFormat:@"%@/%@?userid=%@&partyid=%@&mainhostid=%@", ROCKZ_SERVICE_URL, API_GET_INVITELIST_FORAPARTY, gUserID, _party.partyID,_party.creator.userID];
        NSLog(@"getinvitelistURL-- %@", urlString);
        resultDic = sendHttpRequestSynchronous(urlString, @"GET");
    }
    if ([_strCallFromWhichController isEqualToString:@"CreatePartyViewController"]) {
        NSString *urlString = [NSString stringWithFormat:@"%@/%@?userid=%@", ROCKZ_SERVICE_URL, API_GET_INVITELIST, gUserID];
        NSLog(@"getinvitelistURL-- %@", urlString);
        resultDic = sendHttpRequestSynchronous(urlString, @"GET");
    }
    
    if ([_strCallFromWhichController isEqualToString:@"DetailsOfPartyForHostViewController"]){
        NSString *urlString = [NSString stringWithFormat:@"%@/%@?userid=%@&partyid=%@&mainhostid=%@", ROCKZ_SERVICE_URL, API_GET_INVITELIST_FORAPARTY, gUserID, _party.partyID,_party.creator.userID];
        NSLog(@"getinvitelistURL-- %@", urlString);
        resultDic = sendHttpRequestSynchronous(urlString, @"GET");
    }
    
    if ([_strCallFromWhichController isEqualToString:@"addhost"]) {
        NSString *urlString = [NSString stringWithFormat:@"%@/%@?userid=%@", ROCKZ_SERVICE_URL, API_GET_INVITELIST, gUserID];
        NSLog(@"getinvitelistURL-- %@", urlString);
        resultDic = sendHttpRequestSynchronous(urlString, @"GET");
    }

    if (resultDic == nil) {
        [self showNoFriendAlert];
        return;
    }
    NSString *resultStr = resultDic[@"result"];
    if ([resultStr isEqualToString:@"fail"]) {
        [self showNoFriendAlert];
        return;
    }
    
    [dataArray removeAllObjects];
    [_originalArray removeAllObjects];
    if ([resultStr isEqualToString:@"success"]) {
        NSArray *usersArr = resultDic[@"users"];
        for (NSDictionary *dic in usersArr) {
            User *user = [[User alloc] init];
            user.userID = dic[@"id"];
            user.firstName = dic[@"firstname"];
            user.lastName = dic[@"lastname"];
            user.photoURL = dic[@"photo"];
            [dataArray addObject:user];
            [_originalArray addObject:user];
            [_inviteStatusList setObject:@"uncheck" forKey:user.userID];
        }
    }
}

- (void) showAlert:(NSString *)title message:(NSString *)message{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"okay" otherButtonTitles:nil];
    [alertView show];
    
}

- (void) showNoFriendAlert{
    UIAlertController* alertController =
    [UIAlertController alertControllerWithTitle:@"notice"
                                        message:@"No friends who can be invited."
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:
    [UIAlertAction actionWithTitle:@"ok"
                              style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction * action) {
                                if ([_strCallFromWhichController isEqualToString:@"CreatePartyViewController"]) {
                                    
                                    NSInteger count = [self.navigationController.viewControllers count];
                                    PartyFeedViewController *viewController = self.navigationController.viewControllers[count - 2];
                                    [self.navigationController popToViewController:viewController animated:YES];
                                    
                                } else{
                                    [self.navigationController popViewControllerAnimated:YES];
                                }
                            }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (BOOL) invite{
    //Make guest IDs list as like " 1,5,05,8 "
    NSArray *keyArr = [_inviteStatusList allKeys];
    NSString *guestIDs = @"";
    int countInvite = 0;
    for (int i= 0; i < keyArr.count; i++) {
        NSString *userKey = (NSString *) keyArr[i];
        NSString *userStatus = (NSString *)[_inviteStatusList objectForKey:userKey];
        if ([userStatus isEqualToString:@"check"]) {
            if (countInvite == 0 ) {
                guestIDs = (NSString *)keyArr[i];
            }else{
                guestIDs = [NSString stringWithFormat:@"%@,%@", guestIDs,keyArr[i]];
            }
            countInvite++;
        }
    }
    if ([guestIDs isEqualToString:@""]) {
        return NO;
    }
    
    //send the request
    NSDictionary *resultDic = nil;
    NSString *urlString;
    if ([_strCallFromWhichController isEqualToString:@"DetailsOfPartyForHostViewController"]) {
        urlString = [NSString stringWithFormat:@"%@/%@?userid=%@&partyid=%@&guestids=%@", ROCKZ_SERVICE_URL, API_INVITE_SOMEONE_PUBLICPARTY, gUserID, _party.partyID, guestIDs];
        NSLog(@"invite URL--%@", urlString);
        resultDic = sendHttpRequestSynchronous(urlString, @"GET");
    }
    if ([_strCallFromWhichController isEqualToString:@"CreatePartyViewController"]) {
        urlString = [NSString stringWithFormat:@"%@/%@?userid=%@&partyid=%@&guestids=%@", ROCKZ_SERVICE_URL, API_INVITE_SOMEONE_PUBLICPARTY, gUserID, _party.partyID, guestIDs];
        NSLog(@"invite URL--%@", urlString);
        resultDic = sendHttpRequestSynchronous(urlString, @"GET");
    }
    if ([_strCallFromWhichController isEqualToString:@"DetailsOfPartyViewControler"]) {
        urlString = [NSString stringWithFormat:@"%@/%@?userid=%@&partyid=%@&guestids=%@", ROCKZ_SERVICE_URL, API_INVITE_SOMEONE_PUBLICPARTY_AS_GUEST, gUserID, _party.partyID, guestIDs];
        NSLog(@"invite URL--%@", urlString);
        sendHttpRequestSynchronous(urlString, @"GET");
        return TRUE;
    }
    
    if (resultDic == nil) {
        [self showAlert:@"warning" message:@"failed to invite to the party."];
        return FALSE;
    }
    NSString *resultStr = resultDic[@"result"];
    if ([resultStr isEqualToString:@"fail"]) {
        [self showAlert:@"Notice" message:@"failed to invite to the party."];
    }
    if ([resultStr isEqualToString:@"success"]) {
        NSArray  *arr = (NSArray *)resultDic[@"attender"];
        for (NSDictionary *dic in arr) {
            User *user = [[User alloc] init];
            user.userID = (NSString *)dic[@"id"];
            user.firstName = (NSString *)dic[@"firstname"];
            user.lastName = (NSString *)dic[@"lastname"];
            user.photoURL = (NSString *)dic[@"photo"];
            user.coverURL = (NSString *)dic[@"coverphoto"];
            
            [_party.attendList addObject:user];
        }
        _party.numGuest = [NSString stringWithFormat:@"%lu", ([_party.numGuest integerValue] + arr.count)];
    }
    
    return TRUE;
}

#pragma mark - side menu event
- (void)hideSideMenu{
    [ApplicationDelegate.sideMenuViewController.view removeFromSuperview];
}

@end
