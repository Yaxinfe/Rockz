//
//  GlobalFunction.h
//  Rockz
//
//  Created by Admin on 09/11/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#ifndef Global_Function
#define Global_Function

NSArray * parseLoginData(NSDictionary *dic);
void parsePartyInfo(NSDictionary *dic);
NSDictionary * sendHttpRequestSynchronous(NSString* urlString, NSString * way);
void makeCircleImageView(UIImageView *imgView, float borderWidth);
void showSideMenu(UIViewController* viewCtrl);
void hideSideMenu();
User * getMyInfo();

#endif