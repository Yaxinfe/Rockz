//
//  PartyFeedViewController.h
//  Rockz
//
//  Created by Admin on 10/25/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PartyFeedViewController : UIViewController <UITableViewDataSource, UITableViewDelegate , SideMenuEvent>

@property (weak, nonatomic) IBOutlet UITableView *partiesTableView;

@property (nonatomic, strong) NSMutableArray *partiesArray;

@property (weak, nonatomic) IBOutlet UIView *popupTypeView;
@property (weak, nonatomic) IBOutlet UIView *popupStatusView;
@property (weak, nonatomic) IBOutlet UIImageView *typeAllImageView;
@property (weak, nonatomic) IBOutlet UIImageView *typePrepartyImageView;
@property (weak, nonatomic) IBOutlet UIImageView *typePartyImageView;
@property (weak, nonatomic) IBOutlet UIImageView *typeAfterpartyImageView;
@property (weak, nonatomic) IBOutlet UILabel *typeAllLabel;
@property (weak, nonatomic) IBOutlet UILabel *typePrepartyLabel;
@property (weak, nonatomic) IBOutlet UILabel *typePartyLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeAfterpartyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *statusAllImageView;
@property (weak, nonatomic) IBOutlet UIImageView *statusPublicImageView;
@property (weak, nonatomic) IBOutlet UIImageView *statusPrivateImageView;
@property (weak, nonatomic) IBOutlet UIImageView *statusInviteonlyImageView;
@property (weak, nonatomic) IBOutlet UILabel *statusAllLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusPublicLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusPrivateLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusInviteonlyLabel;
@property (weak, nonatomic) IBOutlet UIButton *createPartyBtn;

@end
