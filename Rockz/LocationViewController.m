//
//  LocationViewController.m
//  Rockz
//
//  Created by Admin on 10/31/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "LocationViewController.h"
#import "UserProfileViewController.h"
#import "Party.h"
#import "GlobalFunction.h"
#import "UIImageView+WebCache.h"
#import "Constants.h"

@implementation LocationViewController

@synthesize mParty;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (mParty) {
        if (mParty.creator) {
            [self.userPhotoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", ROCKZ_PHOTO_URL, mParty.creator.photoURL]]];
            makeCircleImageView(self.userPhotoImageView, 1);
            self.userNameLabel.text = [NSString stringWithFormat:@"%@ %@", mParty.creator.firstName, mParty.creator.lastName];
        }
        
        self.partyNameLabel.text = mParty.name;
        self.partyLocation1Label.text = mParty.address;
        //self.partyLocation2Label.text = mParty.address;
        self.partyDateLabel.text = mParty.date;
        self.partyTimeLabel.text = [NSString stringWithFormat:@"%@ - %@", mParty.startTime, mParty.endTime];
        [self goLocation];
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

- (IBAction)showUser:(id)sender {
    User* user = mParty.creator;
    UserProfileViewController *userProfileViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"UserProfileViewController"];
    [userProfileViewController setUser:user];
    [self.navigationController pushViewController:userProfileViewController animated:YES];
}

-(void) goLocation {
    @try {
        MKCoordinateRegion newRegion;
        newRegion.center.latitude = mParty.latitude;
        newRegion.center.longitude = mParty.longitude;
        newRegion.span.latitudeDelta = 0.008388;
        newRegion.span.longitudeDelta = 0.016243;
        
        [self.mapView setRegion:newRegion animated:YES];
    }
    @catch (NSException *exception) {
        NSLog(@"You can't set the picture");
    }
    @finally {
        
    }
    
}

#pragma mark - side menu event
- (void)hideSideMenu{
    [ApplicationDelegate.sideMenuViewController.view removeFromSuperview];
}

@end
