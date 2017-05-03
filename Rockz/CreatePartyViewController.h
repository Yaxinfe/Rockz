//
//  CreatePartyViewController.h
//  Rockz
//
//  Created by Admin on 10/25/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <CoreLocation/CoreLocation.h>


@interface CreatePartyViewController : UIViewController <SideMenuEvent, CLLocationManagerDelegate>


@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentsView;
@property (weak, nonatomic) IBOutlet UIImageView *partyPhotoImageView;
@property (weak, nonatomic) IBOutlet UIView *pickerContainerView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (weak, nonatomic) IBOutlet UITextField *partyNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *partyAddressTextField;

@property (weak, nonatomic) IBOutlet UITextField *partyDateDdTextField;
@property (weak, nonatomic) IBOutlet UITextField *partyDateMmTextField;
@property (weak, nonatomic) IBOutlet UITextField *partyDateYearTextField;

@property (weak, nonatomic) IBOutlet UITextField *partyStartTimeHhTextField;
@property (weak, nonatomic) IBOutlet UITextField *partyStartTimeMmTextField;
@property (weak, nonatomic) IBOutlet UITextField *partyStartTimeApTextField;
@property (weak, nonatomic) IBOutlet UITextField *partyEndTimeHhTextField;
@property (weak, nonatomic) IBOutlet UITextField *partyEndTimeMmTextField;
@property (weak, nonatomic) IBOutlet UITextField *partyEndTimeApTextField;

@property (weak, nonatomic) IBOutlet UILabel *addHostLabel;
@property (weak, nonatomic) IBOutlet UIView *hostView;
@property (weak, nonatomic) IBOutlet UIImageView *hostUser1ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *hostUser2ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *hostUser3ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *hostUser4ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *hostUser5ImageView;
@property (weak, nonatomic) IBOutlet UILabel *hostsNumberLabel;

@property (weak, nonatomic) IBOutlet UIImageView *typePrepartyImageView;
@property (weak, nonatomic) IBOutlet UIImageView *typePartyImageView;
@property (weak, nonatomic) IBOutlet UIImageView *typeAfterpartyImageView;
@property (weak, nonatomic) IBOutlet UILabel *typePrepartyLabel;
@property (weak, nonatomic) IBOutlet UILabel *typePartyLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeAfterpartyLabel;

@property (weak, nonatomic) IBOutlet UIImageView *statusPublicImageView;
@property (weak, nonatomic) IBOutlet UIImageView *statusPrivateImageView;
@property (weak, nonatomic) IBOutlet UIImageView *statusInviteOnlyImageView;
@property (weak, nonatomic) IBOutlet UILabel *statusPublicLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusPrivateLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusInviteOnlyLabel;

@property (weak, nonatomic) IBOutlet UITextView *rollTextView;
@property (weak, nonatomic) IBOutlet UITextField *feeTextField;

@property (assign, nonatomic) int datePickerTag;
@property (assign, nonatomic) int partyType;
@property (assign, nonatomic) int partyStatus;
@property (strong, nonatomic) NSDate *partyDate;
@property (strong, nonatomic) NSDate *partyStartTime;
@property (strong, nonatomic) NSDate *partyEndTime;
@property (strong, nonatomic) NSMutableArray *hostsofParty;
@property (assign, nonatomic) BOOL bIsSetImage;

@property (copy, nonatomic) NSString *longitude;
@property (copy, nonatomic) NSString *latitude;
@property (copy, nonatomic) NSMutableArray *invitedHostList;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;
@property (strong, nonatomic) Party *mParty;
@property (copy, nonatomic) NSString *strCallFromWhichController;

@property (assign, nonatomic) BOOL bIsSentCreatParty;


- (void) showSelectedHosts;

@end
