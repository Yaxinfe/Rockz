//
//  MyPartiesViewController.m
//  Rockz
//
//  Created by Admin on 10/26/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "MyPartiesViewController.h"

#import "AttendersViewController.h"
#import "DetailsOfPartyForHostViewController.h"
#import "DetailsOfPartyViewController.h"
#import "LocationViewController.h"
#import "SideMenuViewController.h"
#import "SorryViewController.h"
#import "UserProfileViewController.h"
#import "GlobalFunction.h"
#import "Globalvariables.h"
#import "Constants.h"
#import "PartyCell.h"
#import "User.h"
#import "Party.h"


@interface MyPartiesViewController ()
@property (nonatomic, strong) NSString *mFilter;
@end

@implementation MyPartiesViewController

@synthesize dataArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mFilter = @"";
    // Do any additional setup after loading the view.
    self.tableView.backgroundColor = [UIColor clearColor];
}

- (void)viewDidAppear:(BOOL)animated {
    
}

- (void)viewWillAppear:(BOOL)animated{
    [self setFilterMode:@"Host"];
    [self loadPartyFeedData];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([_mFilter isEqualToString:@"Host"]) {
        return gArrMyHostParties.count;
    }
    return gArrMyGuestParties.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"PartyCell";
    
    PartyCell *cell = (PartyCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = (PartyCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    Party *party;
    if ([_mFilter isEqualToString:@"Host"]) {
        party = (Party*)[gArrMyHostParties objectAtIndex:indexPath.row];
    }
    if ([_mFilter isEqualToString:@"Guest"]) {
        party = (Party*)[gArrMyGuestParties objectAtIndex:indexPath.row];
    }
    [cell setContents:party index:indexPath.row];
    return cell;
}

- (void)loadPartyFeedData {
    if (dataArray == nil) {
        dataArray = [[NSMutableArray alloc] init];
    }
    NSString *urlString = [NSString stringWithFormat:@"%@/%@/%@", ROCKZ_SERVICE_URL, API_GET_MYPARTY, gUserID];
    NSLog(@"GetMyParty URL-- %@", urlString);
    NSDictionary *resultDic = sendHttpRequestSynchronous(urlString, @"GET");
    if (resultDic == nil) {
        return;
    }
    gArrMyGuestParties = [[NSMutableArray alloc] init];
    gArrMyHostParties  = [[NSMutableArray alloc] init];
    NSString *resultStr = resultDic[@"result"];
    if ([resultStr isEqualToString:@"emptyall"]) {
        return;
    }
    if ([resultStr isEqualToString:@"emptyguestparty"]) {
        gArrMyHostParties = [self parseMyParty:resultDic[@"hostparty"]];
        return;
    }
    if ([resultStr isEqualToString:@"emptyhostparty"]) {
        gArrMyGuestParties = [self parseMyParty:resultDic[@"guestparty"]];
        return;
    }
    if ([resultStr isEqualToString:@"success"]) {
        gArrMyHostParties = [self parseMyParty:resultDic[@"hostparty"]];
        gArrMyGuestParties = [self parseMyParty:resultDic[@"guestparty"]];
        return;
    }
}

- (NSMutableArray *) parseMyParty:(NSArray *)arr{
    NSMutableArray *returnArr = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in arr) {
        @try {
            NSDictionary *mainDic = (NSDictionary *)((NSArray *)dic[@"main"])[0];
            NSArray *attenderDic = (NSArray *)dic[@"attender"];
            Party *party = [[Party alloc] init];
            party.partyID = mainDic[@"partyid"];
            party.name = mainDic[@"name"];
            party.pictureURL = mainDic[@"picture"];
            party.date = mainDic[@"date"];
            party.startTime = mainDic[@"starttime"];
            party.endTime = mainDic[@"endtime"];
            party.numHost = mainDic[@"hostnum"];
            party.numGuest = mainDic[@"attenderNum"];
            party.status = [mainDic[@"status"] intValue];
            party.type = [mainDic[@"type"] intValue];
            User *user = [[User alloc] init];
            user.userID = mainDic[@"id"];
            user.firstName = mainDic[@"firstname"];
            user.lastName = mainDic[@"lastname"];
            user.photoURL = mainDic[@"photo"];
            party.creator = user;
            party.attendList = [[NSMutableArray alloc] init];
            for (NSDictionary *userDic in attenderDic) {
                User *attendUser =  [[User alloc] init];
                attendUser.userID = userDic[@"id"];
                attendUser.firstName = userDic[@"firstname"];
                attendUser.lastName = userDic[@"lastname"];
                attendUser.photoURL = userDic[@"photo"];
                attendUser.attend_status = [userDic[@"allow"] intValue];
                [party.attendList addObject:attendUser];
            }
            [returnArr addObject:party];
        }
        @catch (NSException *exception) {
        }
        @finally {
        }
    }
    return  returnArr;
}

- (IBAction)showUser:(id)sender {
//    UIButton *button = (UIButton*)sender;
//    NSInteger index = button.tag;
//    
//    Party* party;
//    if ([_mFilter isEqualToString:@"Host"]) {
//        party = (Party*)[gArrMyHostParties objectAtIndex:index];
//    }
//    if ([_mFilter isEqualToString:@"Guest"]) {
//        party = (Party*)[gArrMyGuestParties objectAtIndex:index];
//    }
//    User* user = party.creator;
//    UserProfileViewController *userProfileViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"UserProfileViewController"];
//    [userProfileViewController setUser:user];
//    [self.navigationController pushViewController:userProfileViewController animated:YES];
}

- (IBAction)showStatus:(id)sender {
    UIButton *button = (UIButton*)sender;
    NSInteger index = button.tag;
    Party* party;
    if ([_mFilter isEqualToString:@"Host"]) {
        party = (Party*)[gArrMyHostParties objectAtIndex:index];
    }
    if ([_mFilter isEqualToString:@"Guest"]) {
        party = (Party*)[gArrMyGuestParties objectAtIndex:index];
    }
    if (party.status == PS_INVITEONLY) {
//        showSorryCtrl(self);
    }
}

- (IBAction)showLocation:(id)sender {
    UIButton *button = (UIButton*)sender;
    NSInteger index = button.tag;
    Party* party;
    if ([_mFilter isEqualToString:@"Host"]) {
        party = (Party*)[gArrMyHostParties objectAtIndex:index];
    }
    if ([_mFilter isEqualToString:@"Guest"]) {
        party = (Party*)[gArrMyGuestParties objectAtIndex:index];
    }
    LocationViewController *locationViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LocationViewController"];
    [locationViewController setParty:party];
    [self.navigationController pushViewController:locationViewController animated:YES];
}

- (IBAction)showAttends:(id)sender {
    UIButton *button = (UIButton*)sender;
    NSInteger index = button.tag;
    Party* party;
    if ([_mFilter isEqualToString:@"Host"]) {
        party = (Party*)[gArrMyHostParties objectAtIndex:index];
    }
    if ([_mFilter isEqualToString:@"Guest"]) {
        party = (Party*)[gArrMyGuestParties objectAtIndex:index];
    }
    AttendersViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AttendersViewController"];
    [viewController setParty:party];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)showParty:(id)sender {
    UIButton *button = (UIButton*)sender;
    NSInteger index = button.tag;
    Party* party;
    if ([_mFilter isEqualToString:@"Host"]) {
        party = (Party*)[gArrMyHostParties objectAtIndex:index];
    }
    if ([_mFilter isEqualToString:@"Guest"]) {
        party = (Party*)[gArrMyGuestParties objectAtIndex:index];
    }
    
    if ([party.creator.userID isEqualToString:gUserID]) {
        DetailsOfPartyForHostViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsOfPartyForHostViewController"];
        [viewController setParty:party];
        [self.navigationController pushViewController:viewController animated:YES];
    }else{
        DetailsOfPartyViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsOfPartyViewController"];
        [viewController setParty:party];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

- (IBAction)goBack:(id)sender {
   [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)showMenu:(id)sender {
    showSideMenu(self);
}

- (IBAction)selectHost:(id)sender {
    [self setFilterMode:@"Host"];
    [self.tableView reloadData];
}

- (IBAction)selecGuest:(id)sender {
    [self setFilterMode:@"Guest"];
    [self.tableView reloadData];
}

- (void)setFilterMode:(NSString*)filter {
    if ([filter isEqualToString:self.mFilter]) {
        return;
    }
    
    self.mFilter = filter;
    if ([filter isEqualToString:@"Host"]) {
        self.hostLabel.textColor = RGB(171, 171, 171, 1);
        self.guestLabel.textColor = RGB( 69,  69,  69, 1);
    } else {
        self.guestLabel.textColor = RGB(171, 171, 171, 1);
        self.hostLabel.textColor = RGB( 69,  69,  69, 1);
    }
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
