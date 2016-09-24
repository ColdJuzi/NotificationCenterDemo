//
//  AppDelegate.m
//  NotificationCenter
//
//  Created by LiangHao on 2016/9/23.
//  Copyright © 2016年 PhantomSmart. All rights reserved.
//

#import "AppDelegate.h"
#import "JPUSHService.h"
#import <MBProgressHUD.h>

@import UserNotifications;

NSString *JPushAppKey = @"XXXX";
NSString *JPushChannel = @"Publish channel";
BOOL fProduction = !DEBUG;
BOOL kFUserJPush = NO;

@interface AppDelegate ()
#ifdef kFUserJPush
<JPUSHRegisterDelegate>
#else
<UNUserNotificationCenterDelegate>
#endif

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    CGFloat currentDeviceVersionFloat = [[[UIDevice currentDevice] systemVersion] floatValue];

    
//#ifdef kFUserJPush
//     // JPUSH 2.1.9 新增UserNotifications专用方法。
//    [JPUSHService setLogOFF];
//    if (currentDeviceVersionFloat >= 10.0) {
//        JPUSHRegisterEntity* entity = [[JPUSHRegisterEntity alloc] init];
//        entity.types = UNAuthorizationOptionAlert | UNAuthorizationOptionBadge |UNAuthorizationOptionSound;
//        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
//    } else
//    if (currentDeviceVersionFloat >= 8.0) {
//        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
//                                                          UIUserNotificationTypeSound |
//                                                          UIUserNotificationTypeAlert)
//                                              categories:nil];
//    } else {
//        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
//                                                          UIRemoteNotificationTypeSound |
//                                                          UIRemoteNotificationTypeAlert)
//                                              categories:nil];
//    }
//    [JPUSHService setupWithOption:launchOptions
//                           appKey:JPushAppKey
//                          channel:JPushChannel
//                 apsForProduction:fProduction];
//#else
    
    //  注册APNS。该方法在10中被保留
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    if (currentDeviceVersionFloat >= 10.0) {
        [[UNUserNotificationCenter currentNotificationCenter] setDelegate:self];
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                NSLog(@"Notification center Open success");
            } else {
                NSLog(@"Notification center Open failed");
            }
        }];
    } else if (currentDeviceVersionFloat >= 8.0) {
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert |
                                                                                                    UIUserNotificationTypeSound |
                                                                                                    UIUserNotificationTypeBadge)
                                                                                        categories:nil]];
        
    } else {
        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                         UIRemoteNotificationTypeAlert |
                                                         UIRemoteNotificationTypeSound)];
    }
#pragma clang diagnostic pop
//#endif
    
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#ifdef kFUserJPush
#pragma mark - JPUSHRegisterDelegate
//  只有调用registerForRemoteNotificationConfig:delegate:方法才会激活该delegate。
//  一旦激活该delegate就不再触发application:didReceiveRemoteNotification:fetchCompletionHandler:
//  iOS10特性。App在前台获取通知
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger options))completionHandler {
    completionHandler(UNNotificationPresentationOptionAlert);
}

//  iOS10特性。点击通知进入App
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler {
    
}
#else
#pragma mark - UNUserNotificationCenterDelegate
//  iOS10特性。App在前台获取通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    /*
     UNNotificationContent* content = response.notification.request.content;
     NSDictionary* userInfo = response.notification.request.content.userInfo;
     UNNotificationAttachment* attachments = response.notification.request.content.attachments;
     */
    
    completionHandler(UNNotificationPresentationOptionAlert);
}

//  iOS10特性。点击通知进入App
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler {
    
    //  UNNotificationResponse 是普通按钮的Response
    NSString* actionIdentifierStr = response.actionIdentifier;
    if (actionIdentifierStr) {
        UIView* windowView = [[[UIApplication sharedApplication] keyWindow] rootViewController].view;
        MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:windowView
                                                  animated:YES];
        hud.labelText = actionIdentifierStr;
        hud.mode = MBProgressHUDModeText;
        [hud hide:YES afterDelay:2];
        
        if ([actionIdentifierStr isEqualToString:@"IdentifierJoinAppA"]) {
            //  do anything
        } else if ([actionIdentifierStr isEqualToString:@"IdentifierJoinAppB"]) {
            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
        }
    }
    
    //  UNTextInputNotificationResponse 是带文本输入框按钮的Response
    if ([response isKindOfClass:[UNTextInputNotificationResponse class]]) {
        NSString* userSayStr = [(UNTextInputNotificationResponse *)response userText];
        if (userSayStr) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                UIView* windowView = [[[UIApplication sharedApplication] keyWindow] rootViewController].view;
                MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:windowView
                                                          animated:YES];
                hud.labelText = userSayStr;
                hud.mode = MBProgressHUDModeText;
                [hud hide:YES afterDelay:2];
            });
        }
    }
    
    /*
    UNNotificationContent* content = response.notification.request.content;
    NSDictionary* userInfo = response.notification.request.content.userInfo;
    UNNotificationAttachment* attachments = response.notification.request.content.attachments;
    */
    
    completionHandler();
}
#endif

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    
}

@end
