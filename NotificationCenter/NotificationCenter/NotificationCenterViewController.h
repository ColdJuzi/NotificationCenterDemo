//
//  NotificationCenterViewController.h
//  NotificationCenter
//
//  Created by LiangHao on 2016/9/23.
//  Copyright © 2016年 PhantomSmart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>
@import UserNotifications;

@interface NotificationCenterViewController : UIViewController

- (void)buildNotificationDes:(NSString *)desStr;
- (void)createNotification:(UIButton *)sender;

@end
