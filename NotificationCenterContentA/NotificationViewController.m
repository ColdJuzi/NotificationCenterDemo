//
//  NotificationViewController.m
//  NotificationCenterContentA
//
//  Created by LiangHao on 2016/9/23.
//  Copyright © 2016年 PhantomSmart. All rights reserved.
//

#import "NotificationViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>

@interface NotificationViewController () <UNNotificationContentExtension>

@property IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *titleLabelA;
@property (weak, nonatomic) IBOutlet UILabel *titleLabelB;

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //  不能插入新的event。纯代码addTarget的event无法使用。
    // Do any required interface initialization here.
}

- (void)didReceiveNotification:(UNNotification *)notification {
    self.label.text = notification.request.content.body;
    self.titleLabelA.text = [NSString stringWithFormat:@"%@ + %@", notification.request.content.title, notification.request.content.subtitle];
    self.titleLabelB.text = [NSString stringWithFormat:@" = %ld", [notification.request.content.title integerValue] + [notification.request.content.subtitle integerValue]];
}

@end
