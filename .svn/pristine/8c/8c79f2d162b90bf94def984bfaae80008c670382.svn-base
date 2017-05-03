//
//  Party.h
//  Rockz
//
//  Created by Admin on 10/30/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "User.h"

typedef enum {
    PT_PREPARTY = 0,
    PT_PARTY,
    PT_AFTERPARTY,
    
} PARTY_TYPE;

typedef enum {
    PS_PUBLIC = 0,
    PS_PRIVATE,
    PS_INVITEONLY,
    
} PARTY_STATUS;

@interface Party : NSObject

@property (nonatomic, copy) NSString *partyID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) PARTY_TYPE type;
@property (nonatomic, assign) PARTY_STATUS status;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic, copy) NSString *rollDescription;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *pictureURL;
@property (nonatomic, strong) User *creator;
@property (nonatomic, assign) double longitude;
@property (nonatomic, assign) double latitude;
@property (nonatomic, strong) NSMutableArray *attendList;
@property (nonatomic, strong) NSMutableArray *hostList;
@property (nonatomic, copy) NSString *numHost;
@property (nonatomic, copy) NSString *numGuest;

@end
