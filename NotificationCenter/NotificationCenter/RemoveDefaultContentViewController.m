//
//  RemoveDefaultContentViewController.m
//  NotificationCenter
//
//  Created by LiangHao on 2016/9/24.
//  Copyright © 2016年 PhantomSmart. All rights reserved.
//

#import "RemoveDefaultContentViewController.h"

@interface RemoveDefaultContentViewController ()

@end

@implementation RemoveDefaultContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildNotificationDes:@"这是一个新的本地通知。自定义通知栏，并隐藏下方系统自带的消息框。带两个Title，分别为title和subtitle。下拉该通知。创建5秒后触发。建议回到桌面。"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - CreateNotificationAction
- (void)createNotification:(UIButton *)sender {
    UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
    content.title = @"Apple";
    content.subtitle = @"Apple Developer";
    content.body = @"下拉放大";
    
    NSString* imageFilePath = [[NSBundle mainBundle] pathForResource:@"accessory_icon"
                                                              ofType:@"png"];
    if (imageFilePath) {
        NSError* error = nil;
        
        UNNotificationAttachment *imageAttachment = [UNNotificationAttachment attachmentWithIdentifier:@"imageAttachment"
                                                                                                   URL:[NSURL fileURLWithPath:imageFilePath]
                                                                                               options:nil
                                                                                                 error:&error];
        if (imageAttachment) {
            //  这里设置的是Array，但是只会取lastObject
            content.attachments = @[imageAttachment];
            
        }
    }
    
    //  使用自定义的NotificationContent的时候，需要对应extension中info.plist (key-UNNotificationExtensionCategory)
    //  注意：UNNotificationExtensionCategory默认是string类型。可以手动更改成array类型，array中的item(string)是categoryName。参照NotificationCenterContentB中的info.plist
    //  隐藏默认消息框。添加UNNotificationExtensionDefaultContentHidden属性，Bool(YES).
    content.categoryIdentifier = @"myNotificationCategoryB";
    
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
