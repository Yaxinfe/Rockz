//
//  CreatePartyViewController.m
//  Rockz
//
//  Created by Admin on 10/25/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "CreatePartyViewController.h"
#import "SideMenuViewController.h"
#import "InviteRequestsViewController.h"
#import "InviteViewController.h"


@interface CreatePartyViewController () <UITextFieldDelegate, UITextViewDelegate, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@end



@implementation CreatePartyViewController
{
    MBProgressHUD *mbProgressHud;
}

UIImageView *partyTypeImageView[3];
UIImageView *partyStatusImageView[3];
UILabel *partyStatusLabel[3];
UILabel *partyTypeLabel[3];
NSString *typeIcon[3];
NSString *statusIcon[3];

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
//    [self.view addGestureRecognizer:tap];
    _bIsSetImage = NO;
    _partyType = -1;
    _partyStatus = -1;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self CurrentLocationIdentifier];
    
    //Notification lintener set
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNextForInvite) name:KNotification_getLocationFromAddress object:nil];
    _bIsSentCreatParty = FALSE;
    
    // init variable
    _hostsofParty = [[NSMutableArray alloc] init];
    
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 1000);
    
    partyTypeImageView[0] = self.typePrepartyImageView;
    partyTypeImageView[1] = self.typePartyImageView;
    partyTypeImageView[2] = self.typeAfterpartyImageView;
    
    partyTypeLabel[0] = self.typePrepartyLabel;
    partyTypeLabel[1] = self.typePartyLabel;
    partyTypeLabel[2] = self.typeAfterpartyLabel;
    
    typeIcon[0] = @"icon_preparty";
    typeIcon[1] = @"icon_playparty";
    typeIcon[2] = @"icon_afterparty";
    
    partyStatusImageView[0] = self.statusPublicImageView;
    partyStatusImageView[1] = self.statusPrivateImageView;
    partyStatusImageView[2] = self.statusInviteOnlyImageView;
    
    partyStatusLabel[0] = self.statusPublicLabel;
    partyStatusLabel[1] = self.statusPrivateLabel;
    partyStatusLabel[2] = self.statusInviteOnlyLabel;
    
    statusIcon[0] = @"icon_public";
    statusIcon[1] = @"icon_private";
    statusIcon[2] = @"icon_invite";
    
    if ([_strCallFromWhichController isEqualToString:@"PartyFeedViewController"]) {
        [self showAddHost];
    }
    if ([_strCallFromWhichController isEqualToString:@"InviteViewController"]) {
        [self showHostsList];
    }
    if ([_strCallFromWhichController isEqualToString:@"DetailsOfPartyForHostViewController"]) {
        if (_mParty.hostList.count == 0) {
            [self showAddHost];
        }else{
            [self showHostsList];
        }
        _partyNameTextField.text = _mParty.name;
        _partyAddressTextField.text = _mParty.address;
        
    }
    
}
- (IBAction)onView:(id)sender {
     [self.view endEditing:YES];
}

- (void)showAddHost{
    _addHostLabel.hidden = NO;
    _hostView.hidden = YES;
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField {
    [textField resignFirstResponder];
    return NO; // We do not want UITextField to insert line-breaks.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)showHostsList{
    _addHostLabel.hidden = YES;
    _hostView.hidden = NO;
    _hostUser1ImageView.hidden = YES;
    _hostUser2ImageView.hidden = YES;
    _hostUser3ImageView.hidden = YES;
    _hostUser4ImageView.hidden = YES;
    _hostUser5ImageView.hidden = YES;
    [self showSelectedHosts];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)showMenu:(id)sender {
    showSideMenu(self);
}

- (IBAction)touchOK:(id)sender {
    _pickerContainerView.hidden = YES;
    NSDate *date = [_datePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    switch (_datePickerTag) {
        case 0:
            [dateFormatter setDateFormat:@"yyyy"];
            _partyDateYearTextField.text = [dateFormatter stringFromDate:date];
            [dateFormatter setDateFormat:@"MM"];
            _partyDateMmTextField.text = [dateFormatter stringFromDate:date];
            [dateFormatter setDateFormat:@"dd"];
            _partyDateDdTextField.text = [dateFormatter stringFromDate:date];
            _partyDate = date;
            break;
        case 1:
            [dateFormatter setDateFormat:@"HH"];
            _partyStartTimeHhTextField.text = [dateFormatter stringFromDate:date];
            [dateFormatter setDateFormat:@"mm"];
            _partyStartTimeMmTextField.text = [dateFormatter stringFromDate:date];
            [dateFormatter setDateFormat:@"a"];
            _partyStartTimeApTextField.text = [dateFormatter stringFromDate:date];
            _partyStartTime = date;
            break;
        case 2:
            [dateFormatter setDateFormat:@"HH"];
            _partyEndTimeHhTextField.text = [dateFormatter stringFromDate:date];
            [dateFormatter setDateFormat:@"mm"];
            _partyEndTimeMmTextField.text = [dateFormatter stringFromDate:date];
            [dateFormatter setDateFormat:@"a"];
            _partyEndTimeApTextField.text = [dateFormatter stringFromDate:date];
            _partyEndTime = date;
            break;
        default:
            break;
    }
}

- (IBAction)touchCancel:(id)sender {
    _pickerContainerView.hidden = YES;
}

- (IBAction)uploadPartyPhoto:(id)sender {
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.delegate = self;
    [self presentViewController:pickerController animated:NO completion:nil];
}

- (IBAction)setPartyDateTime:(id)sender {
    UIButton *btn = (UIButton*)sender;
    int tag = (int)btn.tag;
    _datePickerTag = tag;
    
    switch (tag) {
        case 0: // party date
            [_datePicker setDatePickerMode:UIDatePickerModeDate];
            break;
        case 1: // party start time
            [_datePicker setDatePickerMode:UIDatePickerModeTime];
            break;
            
        case 2: // party end time
            [_datePicker setDatePickerMode:UIDatePickerModeTime];
            break;
            
        default:
            break;
    }
    
    _pickerContainerView.hidden = NO;
}

- (IBAction)selectHosts:(id)sender {
    InviteViewController *inviteViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"InviteViewController"];
    inviteViewController.strCallFromWhichController = @"addhost";
    [self.navigationController pushViewController:inviteViewController animated:YES];
    
}

- (void) showSelectedHosts{
    if(_invitedHostList != nil){
        NSString *hostNumText = [NSString stringWithFormat:@"%lu hosts >", (unsigned long)_invitedHostList.count];
        _hostsNumberLabel.text = hostNumText;
        _hostsNumberLabel.hidden = NO;
        
        for (int i = 0; i < _invitedHostList.count; i++) {
            User *user = (User *)_invitedHostList[i];
            switch (i) {
                case 0:
                    _hostUser1ImageView.hidden = NO;
                    _hostUser1ImageView.layer.borderColor = RGB(171, 171, 171, 1).CGColor;
                    [_hostUser1ImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", ROCKZ_PHOTO_URL, user.photoURL]]];
                    break;
                case 1:
                    _hostUser2ImageView.hidden = NO;
                    _hostUser2ImageView.layer.borderColor = RGB(171, 171, 171, 1).CGColor;
                    [_hostUser2ImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", ROCKZ_PHOTO_URL, user.photoURL]]];
                    break;
                case 2:
                    _hostUser3ImageView.hidden = NO;
                    _hostUser3ImageView.layer.borderColor = RGB(171, 171, 171, 1).CGColor;
                    [_hostUser3ImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", ROCKZ_PHOTO_URL, user.photoURL]]];
                    break;
                case 3:
                    _hostUser4ImageView.hidden = NO;
                    _hostUser4ImageView.layer.borderColor = RGB(171, 171, 171, 1).CGColor;
                    [_hostUser4ImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", ROCKZ_PHOTO_URL, user.photoURL]]];
                    break;
                case 4:
                    _hostUser5ImageView.hidden = NO;
                    _hostUser5ImageView.layer.borderColor = RGB(171, 171, 171, 1).CGColor;
                    [_hostUser5ImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", ROCKZ_PHOTO_URL, user.photoURL]]];
                    break;
            }
            if (i >= 5) {
                break;
            }
        }
    }

}

- (IBAction)selectPartyType:(id)sender {
    UIButton *btn = (UIButton*)sender;
    int tag = (int)btn.tag;
    static int currentTypeID = -1;
    
    if (_partyType == -1) {
        currentTypeID = -1;
    }
    _partyType = tag;
    if (currentTypeID == tag) {
        return;
    }
    
    for (int i = 0; i < 3; i++) {
        if (i == tag) {
            partyTypeImageView[i].image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_on.png", typeIcon[i]]];
            [partyTypeLabel[i] setTextColor:RGB(171, 171, 171, 1)];
        } else {
            partyTypeImageView[i].image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_off.png", typeIcon[i]]];
            [partyTypeLabel[i] setTextColor:RGB(69, 69, 69, 1)];
        }
    }
    
    currentTypeID = tag;
}

- (IBAction)selectPartyStatus:(id)sender {
    UIButton *btn = (UIButton*)sender;
    int tag = (int)btn.tag;
    static int currentStatusID = -1;
    if (_partyStatus == -1 ) {
        currentStatusID = -1;
    }
    _partyStatus = tag;
    if (currentStatusID == tag) {
        return;
    }
    
    for (int i = 0; i < 3; i++) {
        if (i == tag) {
            partyStatusImageView[i].image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_on.png", statusIcon[i]]];
            [partyStatusLabel[i] setTextColor:RGB(171, 171, 171, 1)];
        } else {
            partyStatusImageView[i].image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_off.png", statusIcon[i]]];
            [partyStatusLabel[i] setTextColor:RGB(69, 69, 69, 1)];
        }
    }
    
    currentStatusID = tag;
}

- (IBAction)createParty:(id)sender {
    if (![self validationCheck]) {
        return;
    }

    mbProgressHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbProgressHud.mode = MBProgressHUDAnimationFade;
    
    
    //[[UIApplication sharedApplication] beginIgnoringInteractionEvents];
  
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:_partyAddressTextField.text completionHandler:^(NSArray* placemarks, NSError* error){
        for (CLPlacemark* aPlacemark in placemarks)
        {
            // Process the placemark.
            _latitude = [NSString stringWithFormat:@"%.4f",aPlacemark.location.coordinate.latitude];
            _longitude = [NSString stringWithFormat:@"%.4f",aPlacemark.location.coordinate.longitude];
            NSLog(@"Party Location- longitude-%@, langitude=%@******************************************", _longitude, _latitude);
            
            [[NSNotificationCenter defaultCenter] postNotificationName:KNotification_getLocationFromAddress object:nil];
            break;
        }
        
    }];
}

- (void)onNextForInvite
{
    
    if (_bIsSentCreatParty == TRUE) {
        return;
    }
    _bIsSentCreatParty = TRUE;
    
    NSString *hostIDs = @"";
    for (int i = 0; i < _invitedHostList.count; i++) {
        User *user = (User *)_invitedHostList[i];
        if ( i == 0) {
            hostIDs = user.userID;
        }else{
            hostIDs = [NSString stringWithFormat:@"%@,%@", hostIDs, user.userID];
        }
    }
    
    NSString *partyName = self.partyNameTextField.text;
    NSString *address = self.partyAddressTextField.text;
    NSString *dateYear = self.partyDateYearTextField.text;
    NSString *dateMonth = self.partyDateMmTextField.text;
    NSString *dateDay = self.partyDateDdTextField.text;
    NSString *roll = self.rollTextView.text;
    NSString *fee = self.feeTextField.text;
    NSString *date = [NSString stringWithFormat:@"%@-%@-%@",dateYear, dateMonth, dateDay];
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"hh:mm:ss"];
    NSString *starttime= [timeFormatter stringFromDate:_partyStartTime];
    NSString *endtime = [timeFormatter stringFromDate:_partyEndTime];
    NSString *type = [NSString stringWithFormat:@"%d", _partyType];
    NSString *status = [NSString stringWithFormat:@"%d", _partyStatus];
    
    [API createPartyByUserID:gUserID partyName:partyName address:address longitude:_longitude latitude:_latitude date:date starttime:starttime endtime:endtime hosts:hostIDs type:type status:status roll:roll fee:fee partyImage:_partyPhotoImageView.image succeedHandler:^(NSDictionary *resultDic){
        mbProgressHud.hidden = YES;
        NSString *resultStr = resultDic[@"result"];
        if ([resultStr isEqualToString:@"fail"]) {
            [self showAlert:@"error" message:@"failed to create party."];
            _bIsSentCreatParty = false;
            return;
        }
        else if([resultStr isEqualToString:@"success"])
        {
            NSDictionary *partyDic = [resultDic objectForKey:@"party"];
            NSString *resultPartyID = partyDic[@"id"];
            
            InviteViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"InviteViewController"];
            viewController.strCallFromWhichController = @"CreatePartyViewController";
            Party *party = [[Party alloc] init];
            party.partyID = resultPartyID;
            viewController.party = party;
            [self.navigationController pushViewController:viewController animated:YES];
        }
        
    } errorHandler:^(NSError *error){
        mbProgressHud.hidden = YES;
        [self showAlert:@"error" message:@"can't connect to server."];
    }];
    
}

- (BOOL) validationCheck{
    NSString *partyName = self.partyNameTextField.text;
    NSString *address = self.partyAddressTextField.text;
    NSString *dateYear = self.partyDateYearTextField.text;
    NSString *dateMonth = self.partyDateMmTextField.text;
    NSString *dateDay = self.partyDateDdTextField.text;
    NSString *startTimeHour = self.partyStartTimeHhTextField.text;
    NSString *startTimeMinute = self.partyStartTimeMmTextField.text;
    NSString *startTimeAP = self.partyStartTimeApTextField.text;
    NSString *endTimeHour = self.partyEndTimeHhTextField.text;
    NSString *endTimeMinute = self.partyEndTimeMmTextField.text;
    NSString *endTimeAP = self.partyEndTimeApTextField.text;
    NSString *roll = self.rollTextView.text;
    NSString *fee = self.feeTextField.text;
    
    if ([partyName isEqualToString:@""]) {
        [self showAlert:@"warning" message:@"please input party name."];
        return FALSE;
    }
    if ([address isEqualToString:@""]) {
        [self showAlert:@"warning" message:@"please input address."];
        return FALSE;
    }
    if ([roll isEqualToString:@""]) {
        [self showAlert:@"warning" message:@"please input party roll."];
        return FALSE;
    }
    if ([dateYear isEqualToString:@""]) {
        [self showAlert:@"warning" message: @"please choose party date"];
        return FALSE;
    }
    if ([dateMonth isEqualToString:@""]) {
        [self showAlert:@"warning" message: @"please choose party date"];
        return FALSE;
    }
    if ([dateDay isEqualToString:@""]) {
        [self showAlert:@"warning" message: @"please choose party date"];
        return FALSE;
    }
    if ([startTimeHour isEqualToString:@""]) {
        [self showAlert:@"warning" message: @"please choose start time"];
        return FALSE;
    }
    if ([startTimeMinute isEqualToString:@""]) {
        [self showAlert:@"warning" message: @"please choose start time"];
        return FALSE;
    }
    if ([startTimeAP isEqualToString:@""]) {
        [self showAlert:@"warning" message: @"please choose start time"];
        return FALSE;
    }
    if ([endTimeHour isEqualToString:@""]) {
        [self showAlert:@"warning" message: @"please choose end time"];
        return FALSE;
    }
    if ([endTimeMinute isEqualToString:@""]) {
        [self showAlert:@"warning" message: @"please choose end time"];
        return FALSE;
    }
    if ([endTimeAP isEqualToString:@""]) {
        [self showAlert:@"warning" message: @"please choose end time"];
        return FALSE;
    }
    if (_partyType == -1) {
        [self showAlert:@"warning" message: @"please choose party type"];
        return FALSE;
    }
    if (_partyStatus == -1) {
        [self showAlert:@"warning" message: @"please choose party status"];
        return FALSE;
    }
    if ([fee isEqualToString:@""]) {
        [self showAlert:@"warning" message:@"please input party fee."];
        return FALSE;
    }
    NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    if ([fee rangeOfCharacterFromSet:notDigits].location != NSNotFound)
    {
        // newString  not consists only of the digits 0 through 9
        [self showAlert:@"notice" message:@"pleae input number into fee"];
        return FALSE;
    }
    
    // check whether party date is less than today
    NSDate *today = [NSDate date]; // it will give you current date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"]; // your date
    NSComparisonResult result;
    //has three possible values: NSOrderedSame,NSOrderedDescending, NSOrderedAscending
    
    result = [today compare:_partyDate]; // comparing two dates
    if(result==NSOrderedAscending){
        
    }
    else if(result==NSOrderedDescending){
        [self showAlert:@"warning" message:@"Party date is less than today. try other date."];
        return FALSE;
    }
    else
        NSLog(@"Both dates are same");
    return TRUE;
}

- (void) showAlert:(NSString *) title message:(NSString *)message{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
    [alertView show];
}

#pragma mark - picker view 
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    self.partyPhotoImageView.image = image;
    _bIsSetImage = TRUE;
    [picker dismissModalViewControllerAnimated:YES];
}

#pragma mark - side menu event
- (void)hideSideMenu{
    [ApplicationDelegate.sideMenuViewController.view removeFromSuperview];
}

- (void) getCityNameFromCurrentLocation{
}

#pragma mark CLLocationManager Delegate

- (void) CurrentLocationIdentifier
{
    //---- For getting current gps location
    _locationManager = [CLLocationManager new];
    _locationManager.delegate = self;
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [_locationManager startUpdatingLocation];
    //------
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    _currentLocation = [locations objectAtIndex:0];
    [_locationManager stopUpdatingLocation];
    NSLog(@"Detected Location : %f, %f", _currentLocation.coordinate.latitude, _currentLocation.coordinate.longitude);
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:_currentLocation
                   completionHandler:^(NSArray *placemarks, NSError *error) {
                       if (error){
                           NSLog(@"Geocode failed with error: %@", error);
                           return;
                       }
                       CLPlacemark *placemark = [placemarks objectAtIndex:0];
                       NSLog(@"placemark.ISOcountryCode %@",placemark.ISOcountryCode);
                       /*---- For more results
                        placemark.region);
                        placemark.country);
                        placemark.locality);
                        placemark.name);
                        placemark.ocean);
                        placemark.postalCode);
                        placemark.subLocality);
                        placemark.location);
                        ------*/
    }];
}
@end
