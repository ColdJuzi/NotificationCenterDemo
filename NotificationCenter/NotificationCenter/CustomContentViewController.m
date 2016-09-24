//
//  CustomContentViewController.m
//  NotificationCenter
//
//  Created by LiangHao on 2016/9/23.
//  Copyright © 2016年 PhantomSmart. All rights reserved.
//

#import "CustomContentViewController.h"

@interface CustomContentViewController ()

@end

@implementation CustomContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildNotificationDes:@"这是一个新的本地通知。自定义通知栏，带两个Title，分别为title和subtitle。同时带一个辅助图像。下拉该通知。创建5秒后触发。建议回到桌面。"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - CreateNotificationAction
- (void)createNotification:(UIButton *)sender {
    UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
    content.title = @"111";
    content.subtitle = @"222";
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
    //  自定义的Content和today一样可以自定义长宽。可以在sb中设定。height。也可以代码设定。
    //  self.preferredContentSize = CGSizeMake(0, width);
    //  将key NSExtensionMainStoryboard改成NSExtensionPrincipalClass, value 由sb类名改指定VC的类名可以不使用sb,使用纯代码布局。不推荐。
    //  你会注意到下拉之后，视图会有一个先拉伸后收缩的动画，是App从一个默认size适应你的布局。不好看，可以通过UNNotificationExtensionInitialContentSizeRatio在设置默认size的长宽比。
    content.categoryIdentifier = @"myNotificationCategoryA";
    
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
