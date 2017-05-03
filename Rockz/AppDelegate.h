//
//  AppDelegate.h
//  Rockz
//
//  Created by Admin on 10/25/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "SideMenuViewController.h"
#import "PartyFeedViewController.h"

#define ApplicationDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define RGB(r,g,b,a)           [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@class User;
@class SideMenuViewController;
@class PartyFeedViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SideMenuViewController  *sideMenuViewController;
@property (strong, nonatomic) PartyFeedViewController *partyFeedViewController;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end



