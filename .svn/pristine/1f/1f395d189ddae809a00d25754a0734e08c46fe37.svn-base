//
//  ViewController.m
//  Rockz
//
//  Created by Admin on 10/25/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "SignInViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "SignUpViewController.h"
#import "PartyFeedViewController.h"


@interface SignInViewController () <UITextFieldDelegate, MBProgressHUDDelegate>

@end


@implementation SignInViewController
{
    MBProgressHUD* progressHud;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _usernameTexField.text = @"guest";
    _passwordTextField.text = @"guest";
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField {
    [textField resignFirstResponder];
    return NO; // We do not want UITextField to insert line-breaks.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark
#pragma mark IBAction Methods

- (IBAction)doSignIn:(id)sender {
    
    if(![self validationCheck]){
        return;
    }
    
    progressHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    progressHud.mode = MBProgressHUDAnimationFade;

    [API loginWithInfo:_usernameTexField.text
              Password:_passwordTextField.text
        SucceedHandler:^(NSDictionary *resultDic)
        {
            progressHud.hidden = YES;
            NSString *resultStr = resultDic[@"result"];
            
            if ([resultStr isEqualToString:@"fail"]) {
                [self showAlert:@"failed to login"];
                return ;
            }
            parseLoginData(resultDic);
            PartyFeedViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PartyFeedViewController"];
            [self.navigationController pushViewController:viewController animated:YES];
        
        }
          ErrorHandler:^(NSError *error)
          {
              progressHud.hidden = YES;
              [self showAlert:@"Can't connect to internal server."];
          }];
}

- (IBAction)doSignInFacebook:(id)sender {
    
    progressHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    progressHud.mode = MBProgressHUDAnimationFade;
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"public_profile",@"email"]
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             progressHud.hidden = YES;
             NSLog(@"Process error");
             [self showAlert:@"Failed" message:@"Failed to signin with facebook"];
         }
         else if (result.isCancelled) {
             progressHud.hidden = YES;
             NSLog(@"Cancelled");
         }
         else {
             NSLog(@"Logged in facebook");
             [self getFacebookInfo];
             return;
         }
     }];
}

- (IBAction)pushSignupViewCtrl:(id)sender {
    
    SignUpViewController *signupViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUpViewController"];
    [self.navigationController pushViewController:signupViewController animated:YES];
}

- (BOOL) validationCheck {
    
    NSString *username = _usernameTexField.text;
    NSString *password = _passwordTextField.text;
    UIAlertView *alert;
    
    if ([username isEqualToString:@""]) {
        alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please input username." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    
    if ([password isEqualToString:@""]) {
        alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please input password." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    
    return YES;
}

-(void) getFacebookInfo{
    
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    [parameters setValue:@"id,name,email,first_name,last_name" forKey:@"fields"];
    if ([[FBSDKAccessToken currentAccessToken] hasGranted:@"public_profile"]) {
        FBSDKGraphRequest *requestMe = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters];
        FBSDKGraphRequestConnection *connection = [[FBSDKGraphRequestConnection alloc] init];
        [connection addRequest:requestMe
             completionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                 if (error) {
                     progressHud.hidden = YES;
                     [self showAlert:@"Notice" message:@"Failed to get your facebook information. please retry it. "];
                 }else{
                     //TODO: process me information
                     NSDictionary *dic = (NSDictionary *)result;
                     User *userinfo = [[User alloc]init];
                     userinfo.facebookID = [dic objectForKey:@"id"];
                     userinfo.firstName  = [dic objectForKey:@"first_name"];
                     userinfo.lastName = [dic objectForKey:@"last_name"];
                     userinfo.emailAddress = [(NSString *)[dic objectForKey:@"email"] stringByReplacingOccurrencesOfString:@"@" withString:@"..."];
                     [self loginWithFacebookID:userinfo];
                     return;
                 }
             }];
        [connection start];
    }
    
}

- (void) loginWithFacebookID:(User *) userInfo{
   
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?width=50&height=50", userInfo.facebookID]]]];
    if (image == nil) {
        [self showAlert:@"Can't get the photo from facebook."];
        return;
    }
    
    [API loginWithFacebook:userInfo.facebookID
                 firstname:userInfo.firstName
                  lastname:userInfo.lastName
                     email:userInfo.emailAddress
               deviceToken:gDeviceToken
                     photo:image
            SucceedHandler:^(NSDictionary *resultDic){
                
                progressHud.hidden = YES;
                NSString *resultStr = resultDic[@"result"];
                if ([resultStr isEqualToString:@"success"]) {
                    parseLoginData(resultDic);
                    PartyFeedViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PartyFeedViewController"];
                    [self.navigationController pushViewController:viewController animated:YES];
                }
                else if ([resultStr isEqualToString:@"emptyparty"]) {
                    parseLoginData(resultDic);
                    PartyFeedViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PartyFeedViewController"];
                    [self.navigationController pushViewController:viewController animated:YES];
                }
                else if ([resultStr isEqualToString:@"fail"]) {
                    [self showAlert:@"failed to login in"];
                }
                
            }
              ErrorHandler:^(NSError *error){
                  progressHud.hidden = YES;
                  [self showAlert:@"Can't connect to internal server."];
              }];
}

#pragma mark
#pragma mark Alert Methods

- (void) showAlert:(NSString *) message{
    UIAlertController* alertController =
    [UIAlertController alertControllerWithTitle:@"Warning"
                                        message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:
     [UIAlertAction actionWithTitle:@"ok"
                              style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction * action) {
                                
                            }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void) showAlert:(NSString *)title message:(NSString *)message{
    @try {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"okay" otherButtonTitles: nil];
        [alertView show];
    }
    @catch (NSException *exception) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:@"Failed to sign in." delegate:self cancelButtonTitle:@"okay" otherButtonTitles: nil];
        [alertView show];
    }
    @finally {
        
    }
    
}

@end
