//
//  DetailsOfPartyForHostViewController.m
//  Rockz
//
//  Created by Admin on 10/31/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "DetailsOfPartyForHostViewController.h"

#import "AttendersViewController.h"
#import "LocationViewController.h"
#import "Constants.h"
#import "UIImageView+WebCache.h"
#import "Globalvariables.h"
#import "GlobalFunction.h"
#import "EditProfileViewController.h"
#import "CreatePartyViewController.h"
#import "InviteViewController.h"

#import "Party.h"

@implementation DetailsOfPartyForHostViewController

@synthesize mParty;
- (void)viewDidLoad{
    [super viewDidLoad];
    _httpClient = [[Httpclient alloc] init];
    _httpClient.controller = self;
    self.attend0PhotoImageView.layer.borderColor = RGB(171, 171, 171, 1).CGColor;
    self.attend1PhotoImageView.layer.borderColor = RGB(171, 171, 171, 1).CGColor;
    self.attend2PhotoImageView.layer.borderColor = RGB(171, 171, 171, 1).CGColor;
    self.attend3PhotoImageView.layer.borderColor = RGB(171, 171, 171, 1).CGColor;
    self.attend4PhotoImageView.layer.borderColor = RGB(171, 171, 171, 1).CGColor;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (mParty) {
        [self.partyPhotoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", ROCKZ_PARTYIMAGE_URL, mParty.pictureURL]]];
        
        self.partyNameLabel.text = mParty.name;
        self.partyLocationLabel.text = mParty.address;
        self.partyDateLabel.text = mParty.date;
        self.partyTimeLabel.text = [NSString stringWithFormat:@"%@ - %@", mParty.startTime, mParty.endTime];
        self.partyTypeLabel.text = mParty.type == PT_PREPARTY ? @"Pre party" : mParty.type == PT_PARTY ? @"Party" : @"After Party";
        self.partyStatusLabel.text = mParty.status == PS_INVITEONLY ? @"Invite only" : mParty.status == PS_PUBLIC ? @"Public" : @"Private";
        self.partyCommentTextView.text = mParty.rollDescription;
        self.partyPriceLabel.text = mParty.price;
        self.attendNumberLabel.text = [NSString stringWithFormat:@"%lu attending >", mParty.attendList.count];
    }
    
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
- (IBAction)editParty:(id)sender {
    CreatePartyViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CreatePartyViewController"];
    viewController.strCallFromWhichController = @"DetailsOfPartyForHostViewController";
    [self.navigationController pushViewController:viewController animated:YES];
}
- (IBAction)deleteParty:(id)sender {
    UIAlertController* alertController =
    [UIAlertController alertControllerWithTitle:@"confirmation"
                                        message:@"Do you want to delete the party?"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:
     [UIAlertAction actionWithTitle:@"No"
                              style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction * action) {
                                
    }]];
    [alertController addAction:
     [UIAlertAction actionWithTitle:@"Yes"
                              style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction * action) {
            [self deleteMyParty:mParty CreaterID:gUserID];
     }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void) deleteMyParty:(Party *)party CreaterID:(NSString *) userID{
    //delete party in backend
    NSString *urlString = [NSString stringWithFormat:@"%@/%@?userid=%@&partyid=%@", ROCKZ_SERVICE_URL, API_DELETE_PARTY, userID, party.partyID];
    NSLog(@"delete party url --%@", urlString);
    [_httpClient setServerAddress:urlString];
    [_httpClient setGetway];
    [_httpClient start];
    for (int i = 0 ; i < gArrPartyFeed.count ; i++ ) {
        Party *partyTemp  = (Party *) gArrPartyFeed[i];
        if ([partyTemp.partyID isEqualToString:party.partyID]) {
            [gArrPartyFeed removeObjectAtIndex:i];
        }
    }
    for (int i = 0 ; i < gArrMyGuestParties.count ; i++ ) {
        Party *partyTemp  = (Party *) gArrMyGuestParties[i];
        if ([partyTemp.partyID isEqualToString:party.partyID]) {
            [gArrMyGuestParties removeObjectAtIndex:i];
        }
    }
    for (int i = 0 ; i < gArrMyHostParties.count ; i++ ) {
        Party *partyTemp  = (Party *) gArrMyHostParties[i];
        if ([partyTemp.partyID isEqualToString:party.partyID]) {
            [gArrMyHostParties removeObjectAtIndex:i];
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)doAction:(id)sender {
    InviteViewController *inviteViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"InviteViewController"];
    inviteViewController.strCallFromWhichController = @"DetailsOfPartyForHostViewController";
    inviteViewController.party = mParty;
    [self.navigationController pushViewController:inviteViewController animated:YES];
}

- (IBAction)showAttenders:(id)sender {
    AttendersViewController *attenderViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AttendersViewController"];
    [attenderViewController setParty:mParty];
    [self.navigationController pushViewController:attenderViewController animated:YES];
}

- (IBAction)showLocation:(id)sender {
    LocationViewController *locationViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LocationViewController"];
    [locationViewController setParty:mParty];
    [self.navigationController pushViewController:locationViewController animated:YES];
}

#pragma mark - http client event
-(void) requestSuccess:(NSDictionary *) dictionary{
    __weak NSString *resultStr = (NSString *)dictionary[@"result"];
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

@end
