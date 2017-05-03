//
//  SignUpViewController.m
//  Rockz
//
//  Created by Admin on 10/25/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "SignUpViewController.h"
#import "TipsViewController.h"
#import "SignInViewController.h"
#import <RSKImageCropper.h>


@interface SignUpViewController () <UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate, NSURLConnectionDelegate, RSKImageCropViewControllerDelegate, RSKImageCropViewControllerDataSource>

@property (strong, nonatomic) UIImagePickerController *pickerViewController;
@property (strong, nonatomic) RSKImageCropViewController *imageCropVC;

@end


@implementation SignUpViewController
{
    MBProgressHUD* progressHud;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _bIsCover = YES;
    _bIsSetCoverImage = NO;
    _bIsSetPhoto = NO;
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

#pragma mark- <IBAction> Methods

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addCover:(id)sender {
    _bIsCover = true;
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.delegate = self;
    [self presentViewController:pickerController animated:YES completion:nil];
    
}

- (IBAction)addPhoto:(id)sender {
    _bIsCover = false;
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.delegate = self;
    [self presentViewController:pickerController animated:YES completion:nil];
}

- (IBAction)doSignup:(id)sender {
    if (![self validationCheck]) {
        return;
    }
    NSString *strEmail = [_emailTextField.text stringByReplacingOccurrencesOfString:@"@" withString:@"..."];
    
    progressHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    progressHud.mode = MBProgressHUDAnimationFade;
    
    [API signup:_firstnameTextField.text
       lastname:_lastnameTextField.text
       username:_usernameTextField.text
          email:strEmail
       password:_passwordTextField.text
    devicetoken:gDeviceToken
          photo:_photoImageView.image
     coverphoto:_coverImageView.image
 succeedhandler:^(NSDictionary *resultDic)
     {
         progressHud.hidden = YES;
         [self signup:resultDic];
     }
   errorhandler:^(NSError *error)
     {
         progressHud.hidden = YES;
         [self showAlert:@"Can't connect to internal server"];
     }];

}

- (BOOL) validationCheck {
    
    NSString *firstname = self.firstnameTextField.text;
    NSString *lastname = self.lastnameTextField.text;
    NSString *email = self.emailTextField.text;
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    NSString *confirm = self.confirmTextField.text;
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
    
    if (![email isValidEmail]){
        alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Email validation is wrong." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return NO;
    }
    
    if ([username isEqualToString:@""]) {
        alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please input Username." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    
    if ([password isEqualToString:@""]) {
        alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please input Password." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    
    if (![password isEqualToString:confirm]) {
        alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Passwords do not match." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    
    if(_bIsSetPhoto == NO){
        alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please take photo." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    return YES;
}

- (void) signup:(NSDictionary *)resultDic {
    
    NSString *resultStr = resultDic[@"result"];
    
    if ([resultStr isEqualToString:@"success"]) {
        parseLoginData(resultDic);
        TipsViewController *tipsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TipsViewController"];
        [self.navigationController pushViewController:tipsViewController animated:YES];
    }
    
    if ([resultStr isEqualToString:@"fail"]) {
        NSString *reasonStr = resultDic[@"reason"];
        
        if ([reasonStr isEqualToString:@"sameusernameexist"]) {
            [self showAlert:@"Please take other username. The same username is exist."];
        }
        if ([resultStr isEqualToString:@"imageuploaderror"]) {
            [self showAlert:@"failed to upload image."];
        }
        if ([resultStr isEqualToString:@"servererror"]) {
            [self showAlert:@"occur internal server error"];
        }
    }

}

#pragma mark - RSKImageCropControllerDelegate

// Crop image has been canceled.
- (void)imageCropViewControllerDidCancelCrop:(RSKImageCropViewController *)controller
{
    [_pickerViewController dismissViewControllerAnimated:YES completion:nil];
}

// The original image has been cropped.
- (void)imageCropViewController:(RSKImageCropViewController *)controller
                   didCropImage:(UIImage *)croppedImage
                  usingCropRect:(CGRect)cropRect
{
    if(_bIsCover){
        _bIsSetCoverImage = YES;
        _coverImageView.image = croppedImage;
        _coverImageView.layer.borderColor = [UIColor colorWithRed:74/255. green:74/255. blue:74/255. alpha:1.0].CGColor;
        _coverImageView.layer.borderWidth=2;
    }
    else{
        _bIsSetPhoto = YES;
        _photoImageView.image = croppedImage;
        _photoImageView.layer.cornerRadius = _photoImageView.frame.size.height/2;
        _photoImageView.layer.masksToBounds = YES;
        _photoImageView.layer.borderColor = [UIColor colorWithRed:171/255. green:171/255. blue:171/255. alpha:1.0].CGColor;
        _photoImageView.layer.borderWidth=2;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

- (void) imagePickerController:(UIImagePickerController *)picker
         didFinishPickingImage:(UIImage *)image
                   editingInfo:(NSDictionary *)editingInfo
{
    _pickerViewController = picker;
    
    _imageCropVC = [[RSKImageCropViewController alloc] initWithImage:image];
    _imageCropVC.delegate = self;
    _imageCropVC.dataSource = self;
    
    [picker presentViewController:_imageCropVC animated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Returns a custom rect for the mask.

- (CGRect)imageCropViewControllerCustomMaskRect:(RSKImageCropViewController *)controller
{
    CGSize maskSize;
    if ([controller isPortraitInterfaceOrientation]) {
        maskSize = CGSizeMake(250, 250);
    } else {
        maskSize = CGSizeMake(220, 220);
    }
    
    CGFloat viewWidth = CGRectGetWidth(controller.view.frame);
    CGFloat viewHeight = CGRectGetHeight(controller.view.frame);
    
    CGRect maskRect = CGRectMake((viewWidth - maskSize.width) * 0.5f,
                                 (viewHeight - maskSize.height) * 0.5f,
                                 maskSize.width,
                                 maskSize.height);
    
    return maskRect;
}

// Returns a custom path for the mask.
- (UIBezierPath *)imageCropViewControllerCustomMaskPath:(RSKImageCropViewController *)controller
{
    CGRect rect = controller.maskRect;
    CGPoint point1 = CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGPoint point2 = CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGPoint point3 = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    
    UIBezierPath *triangle = [UIBezierPath bezierPath];
    [triangle moveToPoint:point1];
    [triangle addLineToPoint:point2];
    [triangle addLineToPoint:point3];
    [triangle closePath];
    
    return triangle;
}

// Returns a custom rect in which the image can be moved.
- (CGRect)imageCropViewControllerCustomMovementRect:(RSKImageCropViewController *)controller
{
    // If the image is not rotated, then the movement rect coincides with the mask rect.
    return controller.maskRect;
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
