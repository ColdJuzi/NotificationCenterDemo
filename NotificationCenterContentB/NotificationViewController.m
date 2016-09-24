//
//  NotificationViewController.m
//  NotificationCenterContentB
//
//  Created by LiangHao on 2016/9/23.
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
    self.label.text = notification.request.content.title;
    self.subTitleLabel.text = notification.request.content.subtitle;
    self.desLabel.text = notification.request.content.body;
}

@end
