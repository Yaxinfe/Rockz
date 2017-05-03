//
//  EditProfileViewController.h
//  Rockz
//
//  Created by Admin on 10/26/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditProfileViewController : UIViewController <UITextFieldDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *newpswdTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmpswdTextField;

@property (assign, nonatomic) BOOL bIsCover;
@property (assign, nonatomic) BOOL bIsSetPhoto;
@property (assign, nonatomic) BOOL bIsSetCoverImage;

@end
