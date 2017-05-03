//
//  AttendersViewController.h
//  Rockz
//
//  Created by Admin on 10/31/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Party;

@interface AttendersViewController : UIViewController <UITableViewDataSource, UITableViewDelegate,SideMenuEvent>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) Party *mParty;
@property (strong, nonatomic) NSString *strCallFromWhichController;

- (void)setParty:(Party*)party;

@end
