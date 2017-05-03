//
//  InviteViewController.h
//  Rockz
//
//  Created by Admin on 10/31/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Party.h"

@interface InviteViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, SideMenuEvent, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *searchKeyTextField;
@property (weak, nonatomic) IBOutlet UISwitch *inviteAllSwitch;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *originalArray;
@property (nonatomic, strong) Party *party;
@property (nonatomic, strong) NSMutableDictionary *inviteStatusList;
@property (nonatomic, copy) NSString *strCallFromWhichController;
@end

