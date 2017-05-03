//
//  PartyFeedViewController.m
//  Rockz
//
//  Created by Admin on 10/25/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "PartyFeedViewController.h"

#import "AttendersViewController.h"
#import "CreatePartyViewController.h"
#import "DetailsOfPartyViewController.h"
#import "DetailsOfPartyForHostViewController.h"
#import "LocationViewController.h"
#import "SideMenuViewController.h"
#import "SorryViewController.h"
#import "UserProfileViewController.h"
#import "SideMenuViewController.h"
#import "PartyCell.h"
#import "User.h"
#import "Party.h"
#import "Globalvariables.h"
#import "GlobalFunction.h"

@interface PartyFeedViewController ()
@property (weak, nonatomic) UIView *menuView;
@end

@implementation PartyFeedViewController

UIImageView *typeFilterImageView[4];
UILabel *typeFilterLabel[4];
NSString *typeIcon[4];
UIImageView *statusFilterImageView[4];
UILabel *statusFilterLabel[4];
NSString *statusIcon[4];

int typeFilterID = -1;
int statusFilterID = -1;


- (void)viewDidLoad {
    [super viewDidLoad];
    _partiesArray = [[NSMutableArray alloc] init];
    
    ApplicationDelegate.sideMenuViewController.controller = self;
    _menuView = ApplicationDelegate.sideMenuViewController.view;
    ApplicationDelegate.sideMenuViewController.owner = self;
    
    _createPartyBtn.layer.zPosition = 10;
    typeFilterImageView[0] = self.typeAllImageView;
    typeFilterImageView[1] = self.typePrepartyImageView;
    typeFilterImageView[2] = self.typePartyImageView;
    typeFilterImageView[3] = self.typeAfterpartyImageView;
    
    typeFilterLabel[0] = self.typeAllLabel;
    typeFilterLabel[1] = self.typePrepartyLabel;
    typeFilterLabel[2] = self.typePartyLabel;
    typeFilterLabel[3] = self.typeAfterpartyLabel;
    
    typeIcon[0] = @"icon_dot";
    typeIcon[1] = @"icon_preparty";
    typeIcon[2] = @"icon_playparty";
    typeIcon[3] = @"icon_afterparty";
    
    statusFilterImageView[0] = self.statusAllImageView;
    statusFilterImageView[1] = self.statusPublicImageView;
    statusFilterImageView[2] = self.statusPrivateImageView;
    statusFilterImageView[3] = self.statusInviteonlyImageView;
    
    statusFilterLabel[0] = self.statusAllLabel;
    statusFilterLabel[1] = self.statusPublicLabel;
    statusFilterLabel[2] = self.statusPrivateLabel;
    statusFilterLabel[3] = self.statusInviteonlyLabel;
    
    statusIcon[0] = @"icon_dot";
    statusIcon[1] = @"icon_public";
    statusIcon[2] = @"icon_private";
    statusIcon[3] = @"icon_invite";
    
    // Do any additional setup after loading the view.
    self.partiesTableView.backgroundColor = [UIColor clearColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    typeFilterID = -1;
    statusFilterID = -1;
    [self hidePopupMenus];
    [self setTypeFilterImpl:0];
    [self setStatusFilterImpl:0];
    [self loadPartyFeedData];
    [self.partiesTableView reloadData];
}

- (void) setTypeFilterImpl:(int)index {
    [self hidePopupMenuView:self.popupStatusView];
    if (typeFilterID == index) {
        [self hidePopupMenuView:self.popupTypeView];
        return;
    }
    
    for (int i = 0; i < 4; i++) {
        if (i == index) {
            typeFilterImageView[i].image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_on.png", typeIcon[i]]];
            [typeFilterLabel[i] setTextColor:RGB(171, 171, 171, 1)];
        } else {
            typeFilterImageView[i].image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_off.png", typeIcon[i]]];
            [typeFilterLabel[i] setTextColor:RGB(70, 70, 70, 1)];
        }
    }
    
    typeFilterID = index;
    [self loadPartyFeedData];
    [self hidePopupMenuView:self.popupTypeView];
    [_partiesTableView reloadData];
}

- (void) setStatusFilterImpl:(int)index {
    [self hidePopupMenuView:self.popupTypeView];
    if (statusFilterID == index) {
        [self hidePopupMenuView:self.popupStatusView];
        return;
    }
    
    for (int i = 0; i < 4; i++) {
        if (i == index) {
            statusFilterImageView[i].image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_on.png", statusIcon[i]]];
            [statusFilterLabel[i] setTextColor:RGB(171, 171, 171, 1)];
        } else {
            statusFilterImageView[i].image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_off.png", statusIcon[i]]];
            [statusFilterLabel[i] setTextColor:RGB(70, 70, 70, 1)];
        }
    }
    
    statusFilterID = index;
    [self loadPartyFeedData];
    [self hidePopupMenuView:self.popupStatusView];
    [_partiesTableView reloadData];
}

- (void)hidePopupMenus {
    [self hidePopupMenuView:self.popupTypeView];
    [self hidePopupMenuView:self.popupStatusView];
    //    self.popupTypeView.hidden = YES;
    //    self.popupStatusView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)popToSigninViewCtrl:(id)sender {
    //    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)showMenu:(id)sender {
    showSideMenu(self);
    
}

- (IBAction)pushAddPartyViewCtrl:(id)sender {
    CreatePartyViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CreatePartyViewController"];
    viewController.strCallFromWhichController = @"PartyFeedViewController";
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)showUser:(id)sender {
    UIButton *button = (UIButton*)sender;
    NSInteger index = button.tag;
    
    Party* party = (Party*)[gArrPartyFeed objectAtIndex:index];
    User* user = party.creator;
    UserProfileViewController *userProfileViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"UserProfileViewController"];
    [userProfileViewController setUser:user];
    [self.navigationController pushViewController:userProfileViewController animated:YES];
}

- (IBAction)showStatus:(id)sender {
    UIButton *button = (UIButton*)sender;
    NSInteger index = button.tag;
    
    Party* party = (Party*)[gArrPartyFeed objectAtIndex:index];
    
    if (party.status == PS_INVITEONLY) {
        //        showSorryCtrl(self);
    }
}

- (IBAction)showLocation:(id)sender {
    UIButton *button = (UIButton*)sender;
    NSInteger index = button.tag;
    Party* party = (Party*)[_partiesArray objectAtIndex:index];
    LocationViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LocationViewController"];
    [viewController setParty:party];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)showAttends:(id)sender {
    UIButton *button = (UIButton*)sender;
    NSInteger index = button.tag;
    Party* party = (Party*)[_partiesArray objectAtIndex:index];
    AttendersViewController *attendersViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AttendersViewController"];
    attendersViewController.mParty = party;
    [self.navigationController pushViewController:attendersViewController animated:YES];
}

- (IBAction)showParty:(id)sender {
    UIButton *button = (UIButton*)sender;
    NSInteger index = button.tag;
    Party* party = (Party*)[_partiesArray objectAtIndex:index];
    if ([party.creator.userID isEqualToString:gUserID]) {
        DetailsOfPartyForHostViewController *detailsOfPartyForHostViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsOfPartyForHostViewController"];
        [detailsOfPartyForHostViewController setParty:party];
        [self.navigationController pushViewController:detailsOfPartyForHostViewController animated:YES];
    }
    else{
        DetailsOfPartyViewController *detailsPartyController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsOfPartyViewController"];
        [detailsPartyController setParty:party];
        [self.navigationController pushViewController:detailsPartyController animated:YES];
    }
    
}

- (IBAction)setTypeFilter:(id)sender {
    long tag = ((UIButton*)sender).tag;
    [self setTypeFilterImpl:(int)tag];
}

- (IBAction)setStatusFilter:(id)sender {
    long tag = ((UIButton*)sender).tag;
    [self setStatusFilterImpl:(int)tag];
}

- (IBAction)showPopupMenu:(id)sender {
    long tag = ((UIButton*)sender).tag;
    
    if (tag == 0) {
        [self showPopupMenuView:self.popupTypeView];
    } else {
        [self showPopupMenuView:self.popupStatusView];
    }
}

- (void) showPopupMenuView:(UIView*)popupMenu {
    CGRect frame = popupMenu.frame;
    frame.size.height = 0;
    
    popupMenu.frame = frame;
    popupMenu.alpha = 0;
    
    frame.size.height = 180;
    [UIView animateWithDuration:0.2f
                          delay:0.0f
                        options:0
                     animations:^{
                         popupMenu.alpha = 1;
                         popupMenu.frame = frame;
                     }
                     completion:^(BOOL finished) {
                     }];
    
    
}

- (void) hidePopupMenuView:(UIView*)popupMenu {
    CGRect frame = popupMenu.frame;
    frame.size.height = 0;
    [UIView animateWithDuration:0.2f
                          delay:0.0f
                        options:0
                     animations:^{
                         popupMenu.alpha = 0;
                         popupMenu.frame = frame;
                     }
                     completion:^(BOOL finished) {
                     }];
}

- (IBAction)hidePopupMenu:(id)sender {
    long tag = ((UIButton*)sender).tag;
    
    if (tag == 0) {
        [self hidePopupMenuView:self.popupTypeView];
    } else {
        [self hidePopupMenuView:self.popupStatusView];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_partiesArray == nil) {
        return 0;
    }
    return [_partiesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"PartyCell";
    
    PartyCell *cell = (PartyCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = (PartyCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Party *party = (Party*)[_partiesArray objectAtIndex:indexPath.row];
    [cell setContents:party index:indexPath.row];
    return cell;
}

- (void)loadPartyFeedData {
    [_partiesArray removeAllObjects];
    if (typeFilterID == 0 && statusFilterID == 0) {
        _partiesArray = [NSMutableArray arrayWithArray:gArrPartyFeed];
        return;
    }
    
    if (typeFilterID == 0 && statusFilterID != 0) {
        for (Party *party in gArrPartyFeed) {
            if (party.status == statusFilterID - 1) {
                [_partiesArray addObject:party];
            }
        }
        return;
    }
    if (typeFilterID != 0 && statusFilterID == 0) {
        for (Party *party in gArrPartyFeed) {
            if (party.type == typeFilterID - 1) {
                [_partiesArray addObject:party];
            }
        }
        return;
    }
    if (typeFilterID != 0 && statusFilterID != 0) {
        for (Party *party in gArrPartyFeed ) {
            if (party.status == statusFilterID -1 && party.type == typeFilterID - 1) {
                [_partiesArray addObject:party];
            }
        }
        return;
    }
}

#pragma mark - side menu event
- (void)hideSideMenu{
    [_menuView removeFromSuperview];
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
