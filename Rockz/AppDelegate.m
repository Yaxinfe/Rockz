//
//  AppDelegate.m
//  Rockz
//
//  Created by Admin on 10/25/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "AppDelegate.h"

#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "Globalvariables.h"
#import "Notification.h"



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    _sideMenuViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"SideMenuViewController"];
    _partyFeedViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"PartyFeedViewController"];
    //push notification
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert
                                                                                             | UIUserNotificationTypeBadge
                                                                                             | UIUserNotificationTypeSound) categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    } else {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert |UIRemoteNotificationTypeSound;
        [application registerForRemoteNotificationTypes:myTypes];
    }
    
    if (launchOptions != nil) {
        NSDictionary *dictionary = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (dictionary != nil) {
            NSLog(@"%@--push", (NSString *)dictionary[@"alert"]);
        }
    }
    [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [FBSDKAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}	

- (void) application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    /* Each byte in the data will be translated to its hex value like 0x01 or
     0xAB excluding the 0x part, so for 1 byte, we will need 2 characters to
     represent that byte, hence the * 2 */
    NSMutableString *tokenAsString = [[NSMutableString alloc]
                                      initWithCapacity:deviceToken.length * 2];
    char *bytes = malloc(deviceToken.length);
    //[deviceToken getBytes:bytes];
    [deviceToken getBytes:bytes length:deviceToken.length];
    
    for (NSUInteger byteCounter = 0;
         byteCounter < deviceToken.length;
         byteCounter++){
        char byte = bytes[byteCounter];
        [tokenAsString appendFormat:@"%02hhX", byte];
    }
    
    free(bytes);
    
    gDeviceToken = tokenAsString;
    NSLog(@"Token = %@", tokenAsString);
}

- (void) application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"Remote notification register failed");

//////////////
    gDeviceToken =@"6934B0EEB816EE6301FE7E91FB867F8212FAB17FB94B65852F561A6292225612";
//////////////
    
    if ([gArrNotification isEqual:[NSNull null]]) {
        gArrNotification = [[NSMutableArray alloc] init];
    }
    
}

- (void) application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    if (gArrNotification == nil) {
        gArrNotification = [[NSMutableArray alloc] init];
    }
    
    Notification *notification = [[Notification alloc] init];
    User *user = [[User alloc] init];
    user.userID = (NSString *)userInfo[@"from"];
    user.photoURL = (NSString *)userInfo[@"photo"];
    notification.user = user;
    notification.partyID = (NSString *)userInfo[@"pid"];
    notification.type = [(NSString *)userInfo[@"ntype"] intValue];
    notification.message = (NSString *)userInfo[@"alert"];
    
    [gArrNotification addObject:notification];
    NSLog(@"ddd");
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "a.Rockz" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Rockz" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Rockz.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
//
//void showViewCtrl(UIViewController* viewCtrl) {
//    CATransition* transition = [CATransition animation];
//    
//    transition.duration = 0.3;
//    transition.type = kCATransitionFade;
//    
//    [g_AppDelegate.navCtrl.view.layer addAnimation:transition forKey:kCATransition];
//    NSArray *viewControllers = [g_AppDelegate.navCtrl viewControllers];
//
//    for (int i = 0; i < [viewControllers count]; i++) {
//        if ([viewControllers objectAtIndex:i] == viewCtrl) {
//            [g_AppDelegate.navCtrl popToViewController:viewCtrl animated:NO];
//            return;
//        }
//    }
//    
//    [g_AppDelegate.navCtrl pushViewController:viewCtrl animated:NO];
//}
//
//void hideViewCtrl() {
//    CATransition* transition = [CATransition animation];
//    
//    transition.duration = 0.3;
//    transition.type = kCATransitionFade;
//    
//    [g_AppDelegate.navCtrl.view.layer addAnimation:transition forKey:kCATransition];
//    [g_AppDelegate.navCtrl popViewControllerAnimated:NO];
//}
//
//
//
//void showSideMenu(UIViewController* viewCtrl) {
//    UIView* parentView = viewCtrl.view;
//    UIView* menuView = [[g_AppDelegate sideMenuViewCtrl] view];
//    UIView* leftView = [[g_AppDelegate sideMenuViewCtrl] leftView];
//    CGRect frame = menuView.frame;
//    
//    frame.origin.x = frame.size.width;
//    menuView.frame = frame;
//    
//    [parentView addSubview:menuView];
//    frame.origin.x = 0;
//    leftView.alpha = 0;
//    [UIView animateWithDuration:0.5f
//                          delay:0.0f
//                        options:0
//                     animations:^{
//                         leftView.alpha = 0.8;
//                         menuView.frame = frame;
//                     }
//                     completion:^(BOOL finished) {
//                     }];
//}
//
//void hideSideMenu() {
//    UIView* menuView = [[g_AppDelegate sideMenuViewCtrl] view];
//    UIView* leftView = [[g_AppDelegate sideMenuViewCtrl] leftView];
//    CGRect frame = menuView.frame;
//    frame.origin.x = frame.size.width;
//    [UIView animateWithDuration:0.5f
//                          delay:0.0f
//                        options:0
//                     animations:^{
//                         leftView.alpha = 0;
//                         menuView.frame = frame;
//                     }
//                     completion:^(BOOL finished) {
//                         [menuView removeFromSuperview];
//                     }];
//}
//
//
//void showSorryCtrl(UIViewController* viewCtrl) {
//    UIView* parentView = viewCtrl.view;
//    UIView* sorryView = [[g_AppDelegate sorryViewCtrl] view];
////    UIView* leftView = [[g_AppDelegate sideMenuViewCtrl] leftView];
//    CGRect frame = sorryView.frame;
//    
//    frame.origin.y = frame.size.height;
//    sorryView.frame = frame;
//    
//    [parentView addSubview:sorryView];
//    frame.origin.y = 0;
////    leftView.alpha = 0;
//    [UIView animateWithDuration:0.5f
//                          delay:0.0f
//                        options:0
//                     animations:^{
////                         leftView.alpha = 0.8;
//                         sorryView.frame = frame;
//                     }
//                     completion:^(BOOL finished) {
//                     }];
//}
//
//void hideSorryCtrl() {
//    UIView* sorryView = [[g_AppDelegate sorryViewCtrl] view];
////    UIView* leftView = [[g_AppDelegate sideMenuViewCtrl] leftView];
//    CGRect frame = sorryView.frame;
//    frame.origin.y = frame.size.height;
//    [UIView animateWithDuration:0.3f
//                          delay:0.0f
//                        options:0
//                     animations:^{
////                         leftView.alpha = 0;
//                         sorryView.frame = frame;
//                     }
//                     completion:^(BOOL finished) {
//                         [sorryView removeFromSuperview];
//                     }];
//}
//
//void makeCircleImageView(UIImageView *imgView, float borderWidth) {
//    imgView.layer.cornerRadius = imgView.frame.size.width / 2;
//    imgView.clipsToBounds = YES;
//    imgView.layer.borderWidth = borderWidth;
//    imgView.layer.borderColor = RGB(171, 171, 171, 1).CGColor;
//}
//
//void login() {
//    g_currentUser = [[User alloc] init];
//    g_currentUser.firstName = @"Femi";
//    g_currentUser.lastName = @"Omotoso";
//    g_currentUser.photoURL = @"img_user_photo0.png";
//    g_currentUser.coverURL = @"bk_profile_cover.png";
//}
//
