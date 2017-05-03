//
//  Notification.h
//  Rockz
//
//  Created by Admin on 11/1/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "User.h"

typedef enum {
    NT_POSTED = 0,
    NT_REQUEST,
    NT_FOLLOWING,
} NOTIFCATION_TYPE;

@interface Notification : NSObject

@property (nonatomic, strong) User* user;
@property (nonatomic, strong) NSString *partyID;
@property (nonatomic) NOTIFCATION_TYPE type;
@property (nonatomic, strong) NSString *message;

@end
