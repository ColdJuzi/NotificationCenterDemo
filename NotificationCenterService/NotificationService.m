//
//  NotificationService.m
//  NotificationCenterService
//
//  Created by LiangHao on 2016/9/23.
//  Copyright © 2016年 PhantomSmart. All rights reserved.
//

#import "NotificationService.h"
#import <UIKit/UIKit.h>

@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService

//  通知还有30秒到底屏幕！
- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    
    //  这里以PNG图像为例，也可以是视频或者音频。前提是你有时间碾碎他们。
    NSString* imageUrlStr = [request.content.userInfo objectForKey:@"image"];
//    NSString* videoUrlStr = [request.content.userInfo objectForKey:@"video"];
//    NSString* soundUrlStr = [request.content.userInfo objectForKey:@"sound"];
    NSData* imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrlStr]];
    if (imageData) {
        NSString* imageFilePath = [self saveImageDataToSandBox:imageData];
        if (imageFilePath && imageFilePath.length != 0) {
            UNNotificationAttachment* attachment = [UNNotificationAttachment attachmentWithIdentifier:@"photo" URL:[NSURL URLWithString:[@"file://" stringByAppendingString:imageFilePath]] options:nil error:nil];
            if (attachment) {
                self.bestAttemptContent.attachments = @[attachment];
            }
        }
    }
    
    self.bestAttemptContent.title = [NSString stringWithFormat:@"%@ [modified]", self.bestAttemptContent.title];
    
    self.contentHandler(self.bestAttemptContent);
}

- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    self.contentHandler(self.bestAttemptContent);
}

#pragma mark - SaveImageDataToSandBox
- (NSString *)saveImageDataToSandBox:(NSData *)imageData {
    NSString * documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    NSString* imageDataFilePath = [NSString stringWithFormat:@"%@/notification_image.png", documentPath];
    NSFileManager* fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:imageDataFilePath]) {
        [fileManager removeItemAtPath:imageDataFilePath
                                error:nil];
    }
    
    UIImage* notificationImage = [UIImage imageWithData:imageData];
    if (notificationImage) {
        NSError* error = nil;
        [UIImagePNGRepresentation(notificationImage) writeToFile:imageDataFilePath options:NSAtomicWrite error:&error];
        if (!error) {
            return imageDataFilePath;
        }
    }
    return nil;
}

@end
