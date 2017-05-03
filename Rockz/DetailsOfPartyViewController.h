//
//  DetailsOfPartyViewController.h
//  Rockz
//
//  Created by Admin on 10/31/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Party;

@interface DetailsOfPartyViewController : UIViewController <SideMenuEvent>

@property (nonatomic, weak) Party *mParty;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UIView         *userView;
@property (weak, nonatomic) IBOutlet UIImageView    *userPhotoImageView;
@property (weak, nonatomic) IBOutlet UILabel        *userNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView    *partyPhotoImageView;
@property (weak, nonatomic) IBOutlet UIImageView    *attend0PhotoImageView;
@property (weak, nonatomic) IBOutlet UIImageView    *attend1PhotoImageView;
@property (weak, nonatomic) IBOutlet UIImageView    *attend2PhotoImageView;
@property (weak, nonatomic) IBOutlet UIImageView    *attend3PhotoImageView;
@property (weak, nonatomic) IBOutlet UIImageView    *attend4PhotoImageView;
@property (weak, nonatomic) IBOutlet UILabel        *attendNumberLabel;

@property (weak, nonatomic) IBOutlet UILabel        *partyNameLabel;
@property (weak, nonatomic) IBOutlet UILabel        *partyLocationLabel;
@property (weak, nonatomic) IBOutlet UILabel        *partyDateLabel;
@property (weak, nonatomic) IBOutlet UILabel        *partyTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel        *partyTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel        *partyStatusLabel;
@property (weak, nonatomic) IBOutlet UITextView     *partyCommentTextView;
@property (weak, nonatomic) IBOutlet UILabel        *partyPriceLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inviteButtonTopSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *attendButtonTopSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewHeight;
@property (weak, nonatomic) IBOutlet UIButton *attendButton;
@property (weak, nonatomic) IBOutlet UIButton *inviteButton;

- (void)setParty:(Party*)party;

@end
