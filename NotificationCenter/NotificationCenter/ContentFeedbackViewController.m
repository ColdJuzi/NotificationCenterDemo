//
//  ContentFeedbackViewController.m
//  NotificationCenter
//
//  Created by LiangHao on 2016/9/24.
//  Copyright © 2016年 PhantomSmart. All rights reserved.
//

#import "ContentFeedbackViewController.h"

@interface ContentFeedbackViewController ()

@end

@implementation ContentFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildNotificationDes:@"这是一个新的本地通知。自定义通知栏，并隐藏下方系统自带的消息框。带两个Title，分别为title和subtitle。这里展示一下如何不进入App，获取用户选项后给在通知栏给用户实时反馈。下拉该通知。创建5秒后触发。建议回到桌面。"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - CreateNotificationAction
- (void)createNotification:(UIButton *)sender {
    UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
    content.title = @"Apple";
    content.subtitle = @"Who are you？";
    content.body = @"Hello World";
    
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
    
    NSMutableArray* actionMutableArray = [[NSMutableArray alloc] initWithCapacity:1];
    UNNotificationAction* actionC = [UNNotificationAction actionWithIdentifier:@"IdentifierJoinAppE"
                                                                         title:@"我是JuZi"
                                                                       options: UNNotificationActionOptionDestructive];
    UNTextInputNotificationAction* actionD = [UNTextInputNotificationAction actionWithIdentifier:@"IdentifierJoinAppF"
                                                                                           title:@"自己输入"
                                                                                         options:UNNotificationActionOptionDestructive textInputButtonTitle:@"Send"
                                                                            textInputPlaceholder:@"What your name."];
    [actionMutableArray addObjectsFromArray:@[actionC, actionD]];
    
    if ([actionMutableArray count] > 1) {
        UNNotificationCategory* categoryNotification = [UNNotificationCategory categoryWithIdentifier:@"myNotificationCategoryD"
                                                                                              actions:actionMutableArray
                                                                                    intentIdentifiers:@[]
                                                                                              options:UNNotificationCategoryOptionCustomDismissAction];
        [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:[NSSet setWithObject:categoryNotification]];
    }

    
    //  使用自定义的NotificationContent的时候，需要对应extension中info.plist (key-UNNotificationExtensionCategory)
    //  注意：UNNotificationExtensionCategory默认是string类型。可以手动更改成array类型，array中的item(string)是categoryName。参照NotificationCenterContentB中的info.plist
    //  隐藏默认消息框。添加UNNotificationExtensionDefaultContentHidden属性，Bool(YES).
    //  执行UNNotificationContentExtension的delegate方法didReceiveNotificationResponse:completionHandler:
    content.categoryIdentifier = @"myNotificationCategoryD";
    
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
