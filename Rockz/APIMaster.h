//
//  APIMaster.h
//  Rockz
//
//  Created by Admin on 1/9/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^APICompletionHandler)(NSDictionary* responseDict);
typedef void (^APIErrorHandler)(NSError *error);

@interface APIMaster : NSObject
{
    
}
+(APIMaster*)singleton;

#pragma mark - Login API
-(void)loginWithInfo:(NSString*)username Password:(NSString*)password SucceedHandler:(APICompletionHandler)suceedHandler ErrorHandler:(APIErrorHandler)errorHandler;

#pragma mark - facebook API
- (void)loginWithFacebook:(NSString *)facebookID firstname:(NSString *)firstname lastname:(NSString *)lastname email:(NSString *)email deviceToken:(NSString *)token photo:(UIImage *)img SucceedHandler:(APICompletionHandler)succeedHandler ErrorHandler:(APIErrorHandler)errorHandler;

#pragma mark - register API
-(void)signup:(NSString *)firstname lastname:(NSString *)lastname username:(NSString *)username email:(NSString *)email password:(NSString *)password devicetoken:(NSString *)deviceToken  photo:(UIImage *)photo coverphoto:(UIImage *)coverphoto succeedhandler:(APICompletionHandler)succeedHandler errorhandler:(APIErrorHandler)errorHandler;

#pragma mark - change profile API
-(void) changeProfile:(NSString *)userID firstname:(NSString *)firstname lastname:(NSString *)lastname email:(NSString *)email newPassword:(NSString *)newPassword photo:(UIImage *)photo coverphoto:(UIImage *)coverphoto succedHandler:(APICompletionHandler)succeedHandler errorHandler:(APIErrorHandler)errorHandler;

#pragma mark - create party API
- (void) createPartyByUserID:(NSString *)userID partyName:(NSString *)partyName address:(NSString *)address longitude:(NSString *)longitude latitude:(NSString *)latitude date:(NSString *)date starttime:(NSString *)starttime endtime:(NSString *)endtime hosts:(NSString *)hosts type:(NSString *)type status:(NSString *)status roll:(NSString *)roll fee:(NSString *)fee partyImage:(UIImage *)partyImage succeedHandler:(APICompletionHandler)succeedHandler errorHandler:(APIErrorHandler)errorHandler;

- (void) executeHTTPRequest:(NSString *)url parameters:(NSDictionary *) dictionary CompletionHandler:(APICompletionHandler)succeedHandler ErrorHandler:(APIErrorHandler)errorHandler;

@end
