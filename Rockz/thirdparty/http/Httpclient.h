//
//  Httpclient.h
//  Rockz
//
//  Created by Admin on 09/11/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HttpclientEvent <NSObject>

@optional
-(void) requestSuccess:(NSDictionary *) dictionary;
-(void) requestSuccessWithEmptyData;
-(void) requestError:(NSError *) error;

@end


@interface Httpclient : NSObject

@property (nonatomic, copy) NSString *requestURL;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *transformWay;
@property (nonatomic, copy) NSString *parameter;
@property (nonatomic, weak) id<HttpclientEvent> controller;

-(void) setServerAddress:(NSString *)strAddress;
-(void) setPostway;
-(void) setGetway;
-(void) setParameter:(NSString *)param;
-(void) start;
@end
