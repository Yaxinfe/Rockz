//
//  FollowingViewController.h
//  Rockz
//
//  Created by Admin on 10/26/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Httpclient.h"

@interface FollowingViewController : UIViewController <SideMenuEvent, HttpclientEvent>

@property (weak, nonatomic) IBOutlet UITextField *searchKeyTextField;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) Httpclient *httpclient;
@end
