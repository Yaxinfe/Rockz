//
//  DetailsOfPartyViewController.m
//  Rockz
//
//  Created by Admin on 10/31/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "DetailsOfPartyViewController.h"

#import "UserProfileViewController.h"
#import "AttendersViewController.h"
#import "LocationViewController.h"
#import "UIImageView+WebCache.h"
#import "Constants.h"
#import "GlobalFunction.h"
#import "Constants.h"
#import "UIImageView+WebCache.h"
#import "Globalvariables.h"
#import "Party.h"
#import "InviteViewController.h"

@implementation DetailsOfPartyViewController

@synthesize mParty;

- (void)viewDidLoad{
    [super viewDidLoad];
    _userPhotoImageView.layer.borderColor = RGB(171, 171, 171, 1).CGColor;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (mParty) {
        [self.partyPhotoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",ROCKZ_PARTYIMAGE_URL,mParty.pictureURL]]];
        if (mParty.creator) {
            [self.userPhotoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",ROCKZ_PHOTO_URL,mParty.creator.photoURL]]];
            if (mParty.hostList.count == 0){
                self.userNameLabel.text = [NSString stringWithFormat:@"%@ %@", mParty.creator.firstName, mParty.creator.lastName];
            }else{
                self.userNameLabel.text = [NSString stringWithFormat:@"%@ %@ +%lu", mParty.creator.firstName, mParty.creator.lastName, mParty.hostList.count];
            }
        }
        [self updateAttendList];
    }
}

- (void) updateAttendList{
    if (mParty) {
        self.attendNumberLabel.text = [NSString stringWithFormat:@"%@ attending >",mParty.numGuest];
        [self.attend0PhotoImageView setHidden:YES];
        [self.attend1PhotoImageView setHidden:YES];
        [self.attend2PhotoImageView setHidden:YES];
        [self.attend3PhotoImageView setHidden:YES];
        [self.attend4PhotoImageView setHidden:YES];
        for (int i = 0; i < mParty.attendList.count; i++) {
            User *user = (User *)mParty.attendList[i];
            switch (i) {
                case 0:
                    [self.attend0PhotoImageView setHidden:NO];
                    self.attend0PhotoImageView.layer.borderColor = RGB(171, 171, 171, 1).CGColor;
                    [self.attend0PhotoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@_photo.png", ROCKZ_PHOTO_URL, user.userID]]];
                    break;
                case 1:
                    [self.attend1PhotoImageView setHidden:NO];
                    self.attend1PhotoImageView.layer.borderColor = RGB(171, 171, 171, 1).CGColor;
                    [self.attend1PhotoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@_photo.png", ROCKZ_PHOTO_URL, user.userID]]];
                    break;
                case 2:
                    [self.attend2PhotoImageView setHidden:NO];
                    self.attend2PhotoImageView.layer.borderColor = RGB(171, 171, 171, 1).CGColor;
                    [self.attend2PhotoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@_photo.png", ROCKZ_PHOTO_URL, user.userID]]];
                    break;
                case 3:
                    [self.attend3PhotoImageView setHidden:NO];
                    self.attend3PhotoImageView.layer.borderColor = RGB(171, 171, 171, 1).CGColor;
                    [self.attend3PhotoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@_photo.png", ROCKZ_PHOTO_URL, user.userID]]];
                    break;
                case 4:
                    [self.attend4PhotoImageView setHidden:NO];
                    self.attend4PhotoImageView.layer.borderColor = RGB(171, 171, 171, 1).CGColor;
                    [self.attend4PhotoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@_photo.png", ROCKZ_PHOTO_URL, user.userID]]];
                    break;
                default:
                    break;
            }
        }
        
        self.partyNameLabel.text = mParty.name;
        self.partyLocationLabel.text = mParty.address;
        self.partyDateLabel.text = mParty.date;
        self.partyTimeLabel.text = [NSString stringWithFormat:@"%@ - %@", mParty.startTime, mParty.endTime];
        self.partyTypeLabel.text = mParty.type == PT_PREPARTY ? @"Pre party" : mParty.type == PT_PARTY ? @"Party" : @"After Party";
        self.partyStatusLabel.text = mParty.status == PS_INVITEONLY ? @"Invite only" : mParty.status == PS_PUBLIC ? @"Public" : @"Private";
        self.partyCommentTextView.text = mParty.rollDescription;
        self.partyPriceLabel.text = mParty.price;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    makeCircleImageView(self.userPhotoImageView, 1);
    
    if (mParty.status == PS_PUBLIC) {
        BOOL bIsAttend = FALSE;
        if (mParty.attendList != nil && mParty.attendList.count > 0) {
            for (User *user in mParty.attendList) {
                if ([user.userID isEqualToString:gUserID]) {
                    [self showInviteButtonOnly];
                    bIsAttend = TRUE;
                }
            }
        }
        if (mParty.hostList != nil && mParty.hostList.count > 0) {
            for (User *user in mParty.hostList) {
                if (user != nil || [user.userID isEqualToString:gUserID]) {
                    [self showInviteButtonOnly];
                    bIsAttend = TRUE;
                }
            }
        }
        if (!bIsAttend) {
            [self showAttendAndIviteBoth];
        }
    }
    
    if (mParty.status == PS_PRIVATE) {
        BOOL bIsAttend = FALSE;
        if (mParty.attendList != nil && mParty.attendList.count > 0) {
            for (User *user in mParty.attendList) {
                if ([user.userID isEqualToString:gUserID]) {
                    [self hiddenAttendAndInviteBoth];
                    bIsAttend = TRUE;
                }
            }
        }
        if (mParty.hostList != nil && mParty.hostList.count > 0) {
            for (User *user in mParty.hostList) {
                if ([user.userID isEqualToString:gUserID]) {
                    [self showInviteButtonOnly];
                    bIsAttend = TRUE;
                }
            }
        }
        if (!bIsAttend) {
            [self showAttendButtonOnly];
        }
    }
}

- (void) showAttendButtonOnly{
    _attendButton.hidden = NO;
    _inviteButton.hidden = YES;
    _scrollViewHeight.constant = 500;
    _attendButtonTopSpace.constant = 20;
}

- (void) showInviteButtonOnly{
    _attendButton.hidden = YES;
    _inviteButton.hidden = NO;
    _scrollViewHeight.constant = 500;
    _inviteButtonTopSpace.constant = 20;
}

- (void) showAttendAndIviteBoth{
    _attendButton.hidden = NO;
    _inviteButton.hidden = NO;
    _scrollViewHeight.constant = 580;
    _inviteButtonTopSpace.constant = 84;
    _attendButtonTopSpace.constant = 20;
}

- (void) hiddenAttendAndInviteBoth{
    _attendButton.hidden = YES;
    _inviteButton.hidden = YES;
    _scrollViewHeight.constant = 450;
}

- (void)setParty:(Party*)party {
    mParty = party;
}

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)showMenu:(id)sender {
    showSideMenu(self);
}

- (IBAction)doAction:(id)sender {
    NSString *urlString;
    [_indicator startAnimating];
    if (mParty.status == PS_PUBLIC) {
        urlString = [NSString stringWithFormat:@"%@/%@?userid=%@&partyid=%@&hostid=%@", ROCKZ_SERVICE_URL, API_ATTEND_PUBLICPARTY, gUserID, mParty.partyID, mParty.creator.userID];
    }
    if (mParty.status == PS_PRIVATE) {
        //urlString = [NSString stringWithFormat:@"%@/%@?userid=%@&partyid=%@&hostid=%@", ROCKZ_SERVICE_URL,]
    }
    if (mParty.status == PS_INVITEONLY) {
        
    }
    NSLog(@"attend url --%@", urlString);
    NSDictionary *resultDic = sendHttpRequestSynchronous(urlString, @"GET");
    
    if (resultDic == nil) {
        
    }else{
        NSString *resultStr = (NSString *) resultDic[@"result"];
        if ([resultStr isEqualToString:@"success"]) {
            [self showAlert:@"notice" message:[NSString stringWithFormat:@"You are attending %@ now.", mParty.name]];
            [mParty.attendList addObject:getMyInfo()];
            mParty.numGuest = [NSString stringWithFormat:@"%d", [mParty.numGuest intValue] + 1 ];
            [self showInviteButtonOnly];
            [self updateAttendList];
        }
        if ([resultStr isEqualToString:@"fail"]) {
            [self showAlert:@"notice" message:[NSString stringWithFormat:@"You're not attending %@ now.", mParty.name]];
        }
    }
    [_indicator stopAnimating];
}
- (IBAction)onInvite:(id)sender {
    InviteViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"InviteViewController"];
    viewController.strCallFromWhichController = @"DetailsOfPartyViewControler";
    viewController.party = mParty;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)showUser:(id)sender {
    User* user = mParty.creator;
    UserProfileViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"UserProfileViewController"];
    [viewController setUser:user];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)showAttenders:(id)sender {
    AttendersViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AttendersViewController"];
    [viewController setParty:mParty];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)showLocation:(id)sender {
    LocationViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LocationViewController"];
    [viewController setParty:mParty];
    [self.navigationController pushViewController:viewController animated:YES];
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
