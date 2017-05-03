//
//  User.h
//  Rockz
//
//  Created by Admin on 10/30/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    ALLOW_ATTENDING = 0,
    ALLOW_INVITED,
    ALLOW_REQUEST,
    ALLOW_NOT
} Allow_STATUS;

@interface User : NSObject

@property (nonatomic, copy) NSString *userID;
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *emailAddress;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;

@property (nonatomic, copy) NSString *photoURL;
@property (nonatomic, copy) NSString *coverURL;
@property (nonatomic, copy) NSString *facebookID;
@property (nonatomic, assign) int attend_status;

@end
