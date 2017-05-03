//
//  AttendersViewController.m
//  Rockz
//
//  Created by Admin on 10/31/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "AttendersViewController.h"

#import "AttenderCell.h"

#import "UIImageView+WebCache.h"


@implementation AttendersViewController

@synthesize mParty;

@synthesize dataArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.backgroundColor = [UIColor clearColor];
//    self.attendersTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)viewDidAppear:(BOOL)animated {
    if (mParty) {
        [self loadAttendersData:mParty];
        [self.tableView reloadData];
    }
}

- (void)setParty:(Party*)party {
    mParty = party;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"AttenderCell";
    
    AttenderCell *cell = (AttenderCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // Configure the cell...
    if (cell == nil) {
        cell = (AttenderCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    User *user = (User*)[dataArray objectAtIndex:indexPath.row];
    [cell setContents:user index:indexPath.row];
    return cell;
}

- (void)loadAttendersData:(Party*)party {
    if (dataArray == nil) {
        dataArray = [[NSMutableArray alloc] init];
    }
    
    [dataArray removeAllObjects];
    for (int i = 0; i < party.attendList.count; i++) {
        User  *user = party.attendList[i];
        user.photoURL = [NSString stringWithFormat:@"%@/%@_photo.png",ROCKZ_PHOTO_URL,user.userID];
        [dataArray addObject:user];
    }
}

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)showMenu:(id)sender {
    showSideMenu(self);
}

#pragma mark - side menu event
- (void)hideSideMenu{
    [ApplicationDelegate.sideMenuViewController.view removeFromSuperview];
}

@end
