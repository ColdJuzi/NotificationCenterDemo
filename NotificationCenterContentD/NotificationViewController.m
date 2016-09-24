//
//  NotificationViewController.m
//  NotificationCenterContentD
//
//  Created by LiangHao on 2016/9/24.
//  Copyright © 2016年 PhantomSmart. All rights reserved.
//

#import "NotificationViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>

@interface NotificationViewController () <UNNotificationContentExtension>

@property IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any required interface initialization here.
}

- (void)didReceiveNotification:(UNNotification *)notification {
    self.label.text = notification.request.content.body;
    self.subTitleLabel.text = notification.request.content.subtitle;
}

- (void)didReceiveNotificationResponse:(UNNotificationResponse *)response completionHandler:(void (^)(UNNotificationContentExtensionResponseOption option))completion {
    if ([response isKindOfClass:[UNTextInputNotificationResponse class]]) {
        NSString* userSayStr = [(UNTextInputNotificationResponse *)response userText];
        if (userSayStr) {
            self.desLabel.text = userSayStr;
        }
    } else {
        if ([response.actionIdentifier isEqualToString:@"IdentifierJoinAppE"]) {
            self.desLabel.text = @"我是JuZi";
        }
    }
    //  必须设置completion，否则通知不会消失。
    //  直接让该通知消失
    completion(UNNotificationContentExtensionResponseOptionDismiss);
    //  消失并传递按钮信息给AppDelegate，是否进入App看Att的设置。
//    completion(UNNotificationContentExtensionResponseOptionDismissAndForwardAction);
}

@end
