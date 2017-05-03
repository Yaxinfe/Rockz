//
//  SideMenuViewController.m
//  Rockz
//
//  Created by Admin on 10/25/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "SideMenuViewController.h"
#import "YourProfileViewController.h"
#import "SearchResultsViewController.h"
#import "SettingsViewController.h"
#import "MyPartiesViewController.h"
#import "NotificationsViewController.h"
#import "FollowersViewController.h"
#import "FollowingViewController.h"
#import "SignInViewController.h"
#import "Globalvariables.h"
#import "GlobalFunction.h"
#import "Constants.h"
#import "UIImageView+WebCache.h"

#import "User.h"

@interface SideMenuViewController ()

@end

@implementation SideMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    if (gUserID) {
        self.userPhotoImageView.layer.cornerRadius = self.userPhotoImageView.frame.size.width / 2;
        self.userPhotoImageView.clipsToBounds = YES;
        self.userPhotoImageView.layer.borderWidth = 1.0f;
        self.userPhotoImageView.layer.borderColor = RGB(171, 171, 171, 1).CGColor;
        [self.userPhotoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@_photo.png", ROCKZ_PHOTO_URL, gUserID]]];
        self.usernameLabel.text = [NSString stringWithFormat:@"%@ %@", gUserFirstname, gUserLastname];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
}

- (IBAction)doSignOut:(id)sender {
//    [self hideMenu:nil];
//    CATransition* transition = [CATransition animation];
//    transition.duration = 0.3;
//    transition.type = kCATransitionFade;
    [((UIViewController *)self.owner).navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)hideMenu:(id)sender {
    hideSideMenu();
//    if ([self.controller respondsToSelector:@selector(hideSideMenu)]){
//        [self.controller performSelector:@selector(hideSideMenu)];
//    }
}

- (IBAction)showYourProfileViewCtrl:(id)sender {
    //[self.controller performSelector:@selector(hideSideMenu)];
    
    YourProfileViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"YourProfileViewController"];
    [((UIViewController *)self.owner).navigationController pushViewController:viewController animated:NO];
    hideSideMenu();
}

- (IBAction)showSettingsViewCtrl:(id)sender {
    [self.controller performSelector:@selector(hideSideMenu)];
    SettingsViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingsViewController"];
    [((UIViewController *)self.owner).navigationController pushViewController:viewController animated:YES];
}

- (IBAction)showPartiesViewCtrl:(id)sender {
    [self.controller performSelector:@selector(hideSideMenu)];
    MyPartiesViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MyPartiesViewController"];
    [((UIViewController *)self.owner).navigationController pushViewController:viewController animated:YES];

}

- (IBAction)showFollowingViewCtrl:(id)sender {
    [self.controller performSelector:@selector(hideSideMenu)];
    FollowingViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FollowingViewController"];
    [((UIViewController *)self.owner).navigationController pushViewController:viewController animated:YES];
}

- (IBAction)showFollowersViewCtrl:(id)sender {
    [self.controller performSelector:@selector(hideSideMenu)];
    FollowersViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FollowersViewController"];
    [((UIViewController *)self.owner).navigationController pushViewController:viewController animated:YES];
}

- (IBAction)showNotificationViewCtrl:(id)sender {
    [self.controller performSelector:@selector(hideSideMenu)];
    NotificationsViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationsViewController"];
    [((UIViewController *)self.owner).navigationController pushViewController:viewController animated:YES];
}

- (IBAction)search:(id)sender {
    if ([_searchKeyTextField.text isEqualToString:@""]) {
        [self showAlert:@"Notice" message:@"please input search keyword"];
        return;
    }
    
    NSString *urlString = [NSString stringWithFormat:@"%@/%@?userid=%@&text=%@", ROCKZ_SERVICE_URL, API_SEARCH_USER, gUserID, _searchKeyTextField.text];
    NSDictionary *resultDic = sendHttpRequestSynchronous(urlString, @"GET");
    if (resultDic == nil) {
        [self showAlert:@"warning" message:@"failed to connect internal server"];
        return;
    }
    NSString *str = resultDic[@"result"];
    if ([str isEqualToString:@"fail"]) {
        [self showAlert:@"Warning" message:@"No anybody."];
        return;
    }
    if (gArrSearchUsers == nil) {
        gArrSearchUsers = [[NSMutableArray alloc] init];
    }
    [gArrSearchUsers removeAllObjects];
    
    NSArray *resultArr = (NSArray *)resultDic[@"users"];
    for (NSDictionary *dic in resultArr) {
        User *user = [[User alloc] init];
        user.userID = dic[@"id"];
        user.firstName = dic[@"firstname"];
        user.lastName = dic[@"lastname"];
        user.photoURL = dic[@"photo"];
        [gArrSearchUsers addObject:user];
    }
    
    [self.controller performSelector:@selector(hideSideMenu)];
    SearchResultsViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchResultsViewController"];
    viewController.searchKey = self.searchKeyTextField.text;
    [((UIViewController *)self.owner).navigationController pushViewController:viewController animated:YES];
}

- (void) showAlert:(NSString *)title message:(NSString *)message{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
    [alertView show];
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
