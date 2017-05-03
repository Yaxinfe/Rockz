//
//  SideMenuViewController.h
//  Rockz
//
//  Created by Admin on 10/25/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SideMenuEvent <NSObject>

@optional
- (void) hideSideMenu;

@end

@interface SideMenuViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *userPhotoImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *profileLabel;
@property (weak, nonatomic) IBOutlet UITextField *searchKeyTextField;
@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) id<SideMenuEvent> controller;
@property (strong, nonatomic) id owner;

@end
