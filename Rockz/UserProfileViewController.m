//
//  UserProfileViewController.m
//  Rockz
//
//  Created by Admin on 10/26/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//
#import <Foundation/NSObjCRuntime.h>
#import "UserProfileViewController.h"
#import "User.h"
#import "PartyFeedViewController.h"
#import "UIImageView+WebCache.h"
#import "Constants.h"
#import "GlobalFunction.h"
#import "Globalvariables.h"
#import "Httpclient.h"
#import "Party.h"

@interface UserProfileViewController ()

@property (nonatomic, strong) User *mUser;
@property (nonatomic, strong) NSMutableArray *guestParty;
@property (nonatomic, strong) NSMutableArray *hostParty;
@property (nonatomic, strong) NSDictionary *partyInfo;

@end

@implementation UserProfileViewController

@synthesize mUser;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _guestParty = [[NSMutableArray alloc] init];
    _hostParty = [[NSMutableArray alloc] init];
    _partyInfo = [[NSDictionary alloc] init];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    CGRect frame = _hostSubView.frame;
    CGFloat x = 0;
    CGFloat height = frame.size.height;
    CGFloat width = height * 4 / 3;
    
    for (int i = 0; i < _hostParty.count; i++) {
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0, width, height)];
        [imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", ROCKZ_PARTYIMAGE_URL,((Party *)_hostParty[i]).pictureURL]]];
        [self.hostSubView addSubview:imageview];
        _hostSubViewWidth.constant = imageview.frame.origin.x + width;
        x += width * 1.1;
    }
    
    
    frame = _guestSubView.frame;
    x = 0;
    height = frame.size.height;
    width = height * 4 / 3;
    
    
    for (int i = 0; i < _guestParty.count; i++) {
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0, width, height)];
        [imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", ROCKZ_PARTYIMAGE_URL,((Party *)_guestParty[i]).pictureURL]]];
        [self.guestSubView addSubview:imageview];
        _guestSubViewWidth.constant = imageview.frame.origin.x + width;
        x += width * 1.1;
    }
    
    _partiesNumberLabel.text   = (NSString *)_partyInfo[@"parties"];
    _followingNumberLabel.text = (NSString *)_partyInfo[@"following"];
    _followersNumberLabel.text = (NSString *)_partyInfo[@"followers"];
    
    if (mUser) {
        //        self.photoImageView.layer.cornerRadius = self.photoImageView.frame.size.width / 2;
        //        self.photoImageView.clipsToBounds = YES;
        //        self.photoImageView.layer.borderWidth = 1.5f;
        //        self.photoImageView.layer.borderColor = RGB(171, 171, 171, 1).CGColor;
        makeCircleImageView(self.photoImageView, 1.5);
        [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",ROCKZ_PHOTO_URL,mUser.photoURL]]];
        [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",ROCKZ_COVERIMAGE_URL,mUser.coverURL]]];
        self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", mUser.firstName, mUser.lastName];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUser:(User*)user {
    mUser = user;
}

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)unfollow:(id)sender {
}

- (IBAction)showMenu:(id)sender {
    showSideMenu(self);
}

- (void) loadData{
    NSString *urlString = [NSString stringWithFormat:@"%@/%@/%@",ROCKZ_SERVICE_URL,API_GETPARTYINFO,mUser.userID];
    NSDictionary *result= sendHttpRequestSynchronous(urlString, @"POST");
    NSDictionary *resultDic;
    if ([((NSString *)result[@"result"]) isEqualToString:@"success"]) {
        resultDic = (NSDictionary *)((NSArray *)result[@"userdata"])[0];
    }
    else{
        return;
    }
    for (NSDictionary *dic in (NSArray *)resultDic[@"guestparty"]) {
        Party *party = [[Party alloc] init];
        party.partyID = (NSString *)dic[@"id"];
        party.pictureURL = (NSString *)dic[@"picture"];
        [_guestParty addObject:party];
    }
    for (NSDictionary *dic in (NSArray *)resultDic[@"hostparty"]) {
        Party *party = [[Party alloc] init];
        party.partyID = (NSString *)dic[@"id"];
        party.pictureURL = (NSString *)dic[@"picture"];
        [_hostParty addObject:party];
    }
    _partyInfo = (NSDictionary *)((NSArray *)resultDic[@"main"])[0];
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