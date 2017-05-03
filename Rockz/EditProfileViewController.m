//
//  EditProfileViewController.m
//  Rockz
//
//  Created by Admin on 10/26/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "EditProfileViewController.h"
#import "UIImageView+WebCache.h"
#import "User.h"
#import "Constants.h"
#import "Globalvariables.h"
#import "UploadFunction.h"
#import "GlobalFunction.h"

@interface EditProfileViewController (){
    MBProgressHUD *mbProgressHub;
}

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _bIsCover = NO;
    _bIsSetCoverImage = NO;
    _bIsSetPhoto = NO;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    _firstNameTextField.text = gUserFirstname;
    _lastNameTextField.text = gUserLastname;
    _emailTextField.text = gUserEmail;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (gUserID) {
        [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@_photo.png", ROCKZ_PHOTO_URL, gUserID]]];
        [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@_cover.png", ROCKZ_COVERIMAGE_URL, gUserID]]];
        self.photoImageView.layer.cornerRadius = self.photoImageView.frame.size.width / 2;
        self.photoImageView.clipsToBounds = YES;
        self.photoImageView.layer.borderWidth = 1.5f;
        self.photoImageView.layer.borderColor = RGB(171, 171, 171, 1).CGColor;
    }
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

- (IBAction)changePhoto:(id)sender {
    _bIsCover = false;
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.delegate = self;
    [self presentViewController:pickerController animated:YES completion:nil];
}

- (IBAction)changeCover:(id)sender {
    _bIsCover = true;
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.delegate = self;
    [self presentViewController:pickerController animated:YES completion:nil];
}

- (BOOL) validationCheck {
    
    NSString *firstname = self.firstNameTextField.text;
    NSString *lastname = self.lastNameTextField.text;
    NSString *email = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    NSString *newPassword = self.newpswdTextField.text;
    NSString *confirm = self.confirmpswdTextField.text;
    UIAlertView *alert;
    
    if ([firstname isEqualToString:@""]) {
        alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please input First Name." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    if ([lastname isEqualToString:@""]) {
        alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please input Last Name." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    if ([email isEqualToString:@""]) {
        alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please input E-mail Address." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    if ([email rangeOfString:@"@"].location == NSNotFound) {
        [self showAlert:@"warning" message:@"email is wrong."];
        return NO;
    }
    
    if (![password isEqualToString:gUserPassword]) {
        alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Password is wrong." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    if ([newPassword isEqualToString:@""]) {
        alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please input Password." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    if (![newPassword isEqualToString:confirm]) {
        alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Passwords do not match." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    return YES;
}

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)saveProfile:(id)sender {

    if (![self validationCheck]) {
        return;
    }
    
    mbProgressHub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbProgressHub.mode = MBProgressHUDAnimationFade;
    
    NSString *strEmail = [_emailTextField.text stringByReplacingOccurrencesOfString:@"@" withString:@"..."];
    
    [API changeProfile:gUserID firstname:_firstNameTextField.text lastname:_lastNameTextField.text email:strEmail newPassword:_newpswdTextField.text photo:_photoImageView.image coverphoto:_coverImageView.image succedHandler:^(NSDictionary *resultDic){
        mbProgressHub.hidden = YES;
        [self showAlert:@"" message:@"Changed your profile."];
        [self.navigationController popViewControllerAnimated:YES];
    }errorHandler:^(NSError *error){
        mbProgressHub.hidden = YES;
        [self showAlert:@"error" message:@"Can't connect server"];
    }];

}

- (void) showAlert:(NSString *)title message:(NSString *)message{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
    [alertView show];
}

#pragma mark - UIImagePickerControllerDelegate

- (void) imagePickerController:(UIImagePickerController *)picker
         didFinishPickingImage:(UIImage *)image
                   editingInfo:(NSDictionary *)editingInfo
{
    if(_bIsCover){
        _bIsSetCoverImage = YES;
        _coverImageView.image = image;
        _coverImageView.layer.borderColor = [UIColor colorWithRed:74/255. green:74/255. blue:74/255. alpha:1.0].CGColor;
        _coverImageView.layer.borderWidth=2;
    }
    else{
        _bIsSetPhoto = YES;
        _photoImageView.image = image;
        _photoImageView.layer.cornerRadius = _photoImageView.frame.size.height/2;
        _photoImageView.layer.masksToBounds = YES;
        _photoImageView.layer.borderColor = [UIColor colorWithRed:171/255. green:171/255. blue:171/255. alpha:1.0].CGColor;
        _photoImageView.layer.borderWidth=2;
    }
    
    [self dismissModalViewControllerAnimated:YES];
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
