//
//  GlobalFunction.m
//  Rockz
//
//  Created by Admin on 09/11/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "GlobalFunction.h"
#import "Globalvariables.h"
#import "Party.h"
#import "User.h"

NSArray * parseLoginData(NSDictionary *dic)
{
    NSString *strResult = (NSString *)dic[@"result"];
    
    NSDictionary *userInfo = (NSDictionary *) dic[@"me"];
    gUserID = userInfo[@"id"];
    gUserEmail = userInfo[@"email"];
    gUserFirstname = userInfo[@"firstname"];
    gUserLastname = userInfo[@"lastname"];
    gUserName = userInfo[@"username"];
    gUserfacebookID = userInfo[@"facebookid"];
    gUserPassword = userInfo[@"password"];
    
    gUserphoto = userInfo[@"photo"];
    gUsercoverImage = userInfo[@"coverphoto"];
    
    if ([strResult isEqualToString:@"success"])
    {
        gArrPartyFeed = [[NSMutableArray alloc] init];
        NSArray * partyArr = (NSArray *)dic[@"party"];
        if (partyArr == nil)
        {
            return nil;
        }
        for (NSDictionary * partyDic in partyArr) {
            NSMutableDictionary *partyInfo = (NSMutableDictionary *)partyDic[@"main"];
            Party *party = [[Party alloc] init];
            party.partyID = partyInfo[@"partyid"];
            party.name = partyInfo[@"name"];
            party.address = partyInfo[@"address"];
            party.rollDescription = partyInfo[@"comment"];
            party.pictureURL = partyInfo[@"picture"];
            party.date = partyInfo[@"date"];
            party.startTime = partyInfo[@"starttime"];
            party.endTime = partyInfo[@"endtime"];
            party.longitude = [(NSString *)partyInfo[@"longitude"] doubleValue];
            party.latitude = [(NSString *)partyInfo[@"latitude"] doubleValue];
            party.price = partyInfo[@"price"];
            party.status = [(NSString *)partyInfo[@"status"] intValue];
            party.type = [(NSString *)partyInfo[@"type"] intValue];
            party.numHost = partyInfo[@"hostsnumber"];
            party.numGuest = partyInfo[@"guestsnumber"];
            party.creator = [[User alloc] init];
            party.creator.userID = partyInfo[@"id"];
            party.creator.firstName = partyInfo[@"firstname"];
            party.creator.lastName =  partyInfo[@"lastname"];
            party.creator.username = partyInfo[@"username"];
            party.creator.photoURL = partyInfo[@"photo"];
            party.creator.emailAddress = partyInfo[@"email"];
            party.creator.coverURL = partyInfo[@"coverphoto"];
            
            party.attendList = [[NSMutableArray alloc] init];
            for (NSDictionary *attender in partyDic[@"attend"]) {
                User *user = [[User alloc] init];
                user.userID = (NSString *)attender[@"id"];
                user.firstName = (NSString *)attender[@"firstname"];
                user.lastName = (NSString *) attender[@"lastname"];
                user.attend_status = [(NSString *)attender[@"allow"] intValue];
                [party.attendList addObject:user];
            }
            
            party.hostList = [[NSMutableArray alloc] init];
            for (NSDictionary *hostsDic in partyDic[@"hosts"]) {
                User *user = [[User alloc] init];
                user.userID = (NSString *)hostsDic[@"id"];
                user.firstName = (NSString *)hostsDic[@"firstname"];
                user.lastName = (NSString *) hostsDic[@"lastname"];
                user.attend_status = [(NSString *)hostsDic[@"allow"] intValue];
                [party.hostList addObject:user];
                
            }
            [gArrPartyFeed addObject:party];
        }
    }
    if ([strResult isEqualToString:@"emptyparty"]) {
        
    }
    return nil;
}

NSDictionary * sendHttpRequestSynchronous(NSString* urlString, NSString * way){
    
    //Response data object
    NSData *returnData = [[NSData alloc]init];
    NSString *escapedURL = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //Build the Request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:escapedURL]];
    [request setHTTPMethod:way];
    
    //Send the Request
    NSError *err;
    returnData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: &err];
    if (err != nil) {
        NSLog(@"http error -- %@", err);
        return nil;
    }
    if (returnData == nil) {
        return nil;
    }
    //Get the Result of Request
    NSString *response = [[NSString alloc] initWithBytes:[returnData bytes] length:[returnData length] encoding:NSUTF8StringEncoding];
    
    bool debug = YES;
    
    if (debug && response) {
        NSLog(@"Response >>>> %@",response);
    }
    NSError *error;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingAllowFragments  error:&error];
    if (jsonObject != nil && error == nil){
        
    }
    else if ([returnData length] == 0 && error == nil){
        NSLog(@"Nothing was downloaded.");
        return nil;
    }
    else if (error != nil){
        NSLog(@"Error happened = %@", error);
        return nil;
    }
    
    return (NSDictionary *)jsonObject;
}

void makeCircleImageView(UIImageView *imgView, float borderWidth) {
    imgView.layer.cornerRadius = imgView.frame.size.width / 2;
    imgView.clipsToBounds = YES;
    imgView.layer.borderWidth = borderWidth;
    imgView.layer.borderColor = RGB(171, 171, 171, 1).CGColor;
}

void showSideMenu(UIViewController* viewCtrl) {
    UIView* parentView = viewCtrl.view;
    UIView* menuView = [ApplicationDelegate.sideMenuViewController view];
    UIView* leftView = [ApplicationDelegate.sideMenuViewController leftView];
    CGRect frame = menuView.frame;

    frame.origin.x = frame.size.width;
    menuView.frame = frame;

    [parentView addSubview:menuView];
    frame.origin.x = 0;
    leftView.alpha = 0;
    [UIView animateWithDuration:0.35f
                          delay:0.0f
                        options:0
                     animations:^{
                         leftView.alpha = 0.8;
                         menuView.frame = frame;
                     }
                     completion:^(BOOL finished) {
                     }];
}

void hideSideMenu() {
    UIView* menuView = [ApplicationDelegate.sideMenuViewController view];
    UIView* leftView = [ApplicationDelegate.sideMenuViewController leftView];
    CGRect frame = menuView.frame;
    frame.origin.x = frame.size.width;
    [UIView animateWithDuration:0.35f
                          delay:0.0f
                        options:0
                     animations:^{
                         leftView.alpha = 0;
                         menuView.frame = frame;
                     }
                     completion:^(BOOL finished) {
                         [menuView removeFromSuperview];
                     }];
}

User * getMyInfo(){
    User *user = [[User alloc] init];
    user.userID = gUserID;
    user.firstName = gUserFirstname;
    user.lastName = gUserLastname;
    user.photoURL = gUserphoto;
    user.coverURL = gUsercoverImage;
    return user;
}

