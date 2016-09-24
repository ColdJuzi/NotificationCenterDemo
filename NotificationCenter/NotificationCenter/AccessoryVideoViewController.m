//
//  AccessoryVideoViewController.m
//  NotificationCenter
//
//  Created by LiangHao on 2016/9/23.
//  Copyright © 2016年 PhantomSmart. All rights reserved.
//

#import "AccessoryVideoViewController.h"

@interface AccessoryVideoViewController ()

@end

@implementation AccessoryVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildNotificationDes:@"这是一个新的本地通知，带两个Title，分别为title和subtitle。同时带一个辅助视频。下拉该通知，放大图像并准备播放。创建5秒后触发。建议回到桌面。"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - CreateNotificationAction
- (void)createNotification:(UIButton *)sender {
    UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
    content.title = @"Apple";
    content.subtitle = @"Apple Developer";
    content.body = @"下拉放大图片，并准备播放";
    
    //  需要注意。导入视频的时候，默认不是添加到bundle中，必须手动勾选Add to targets.
    NSString* videoFilePath = [[NSBundle mainBundle] pathForResource:@"notification_video"
                                                              ofType:@"m4v"];
    if (videoFilePath) {
        UNNotificationAttachment* videoAttachment = [UNNotificationAttachment attachmentWithIdentifier:@"videoFilePath"
                                                                                                   URL:[NSURL fileURLWithPath:videoFilePath]
                                                                                               options:nil
                                                                                                 error:nil];
        if (videoAttachment) {
            //  这里设置的是Array，但是只会取lastObject
            content.attachments = @[videoAttachment];
        }
    }
    
    UNTimeIntervalNotificationTrigger* trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5
                                                                                                    repeats:NO];
    NSString* requestIdentifer = @"Request";
    UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:requestIdentifer
                                                                          content:content
                                                                          trigger:trigger];
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request
                                                           withCompletionHandler:^(NSError * _Nullable error) {
                                                               NSLog(@"Error%@", error);
                                                           }];
}
@end
