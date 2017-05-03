//
//  YourProfileViewController.h
//  Rockz
//
//  Created by Admin on 10/26/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YourProfileViewController : UIViewController <SideMenuEvent>

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subLabel;
@property (weak, nonatomic) IBOutlet UILabel *partiesNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *followerNumberLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *hostScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *guestScrollView;
@property (weak, nonatomic) IBOutlet UIView *hostSubView;
@property (weak, nonatomic) IBOutlet UIView *guestSubView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hostSubViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *guestSubViewWidth;

@end
