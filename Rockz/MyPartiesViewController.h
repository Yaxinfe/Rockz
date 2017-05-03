//
//  MyPartiesViewController.h
//  Rockz
//
//  Created by Admin on 10/26/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPartiesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, SideMenuEvent>

@property (weak, nonatomic) IBOutlet UILabel *hostLabel;
@property (weak, nonatomic) IBOutlet UILabel *guestLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end
