//
//  LocationViewController.h
//  Rockz
//
//  Created by Admin on 10/31/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class Party;

@interface LocationViewController : UIViewController <MKMapViewDelegate, SideMenuEvent>

@property (nonatomic, strong) Party *mParty;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIImageView    *userPhotoImageView;
@property (weak, nonatomic) IBOutlet UILabel        *userNameLabel;

@property (weak, nonatomic) IBOutlet UILabel        *partyNameLabel;
@property (weak, nonatomic) IBOutlet UILabel        *partyLocation1Label;
@property (weak, nonatomic) IBOutlet UILabel        *partyLocation2Label;
@property (weak, nonatomic) IBOutlet UILabel        *partyDateLabel;
@property (weak, nonatomic) IBOutlet UILabel        *partyTimeLabel;

- (void)setParty:(Party*)party;

@end
