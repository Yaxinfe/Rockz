//
//  NotificationsViewController.m
//  Rockz
//
//  Created by Admin on 10/26/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "NotificationsViewController.h"

#import "NotificationCell.h"
#import "Notification.h"
#import "GlobalFunction.h"
#import "Globalvariables.h"
#import "Party.h"

@interface NotificationsViewController ()

@end

@implementation NotificationsViewController

@synthesize dataArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.backgroundColor = [UIColor clearColor];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self loadNotificationData];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadNotificationData {
//    if (dataArray == nil) {
//        dataArray = [[NSMutableArray alloc] init];
//    }
//    
//    [dataArray removeAllObjects];
//    if (gArrNotification == nil) {
//        return;
//    }
//    
//    for (int i = 0; i < gArrNotification.count; i++) {
//        Notification *notification = gArrNotification[i];
//        User  *user = [[User alloc] init];
//        user = notification.user;
//        Party *party = [[Party alloc] init];
//        
//        if (i % 2 == 0) {
//            user.firstName = @"Femi";
//            user.lastName = @"Omotoso";
//            party.name = @"Femi B-day";
//        } else {
//            user.firstName = @"Matheus";
//            user.lastName = @"Mari";
//            party.name = @"Paryt X";
//        }
//        user.photoURL = [NSString stringWithFormat:@"img_user_photo%d.png", i + 1];
//        user.coverURL = @"bk_profile_cover.png";
//        
//        Notification *notification = [[Notification alloc] init];
//        notification.user = user;
//        notification.type = i % 3;
//        
//        switch (notification.type) {
//            case NT_POSTED:
//                
//                break;
//            case NT_REQUEST:
//                
//                break;
//            case NT_FOLLOWING:
//                
//                break;
//            default:
//                break;
//        }
//        
//       // [dataArray addObject:notification];
//    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [gArrNotification count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"NotificationCell";
    
    NotificationCell *cell = (NotificationCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = (NotificationCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Notification *notification = (Notification*)[gArrNotification objectAtIndex:indexPath.row];
    [cell setContents:notification index:indexPath.row];
    return cell;
}

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)showMenu:(id)sender {
    showSideMenu(self);
}
- (IBAction)doAction:(id)sender {
}

#pragma mark - side menu event
- (void)hideSideMenu{
    [ApplicationDelegate.sideMenuViewController.view removeFromSuperview];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
