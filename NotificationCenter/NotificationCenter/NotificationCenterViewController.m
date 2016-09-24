//
//  NotificationCenterViewController.m
//  NotificationCenter
//
//  Created by LiangHao on 2016/9/23.
//  Copyright © 2016年 PhantomSmart. All rights reserved.
//

#import "NotificationCenterViewController.h"

@interface NotificationCenterViewController ()

@property (nonatomic, strong) UILabel* noteInfoLabel;

@end

@implementation NotificationCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton* createNotificationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:createNotificationButton];
    [createNotificationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-10.0f);
        make.left.equalTo(self.view).offset(20.0f);
        make.centerX.equalTo(self.view);
        make.height.offset(44.0f);
    }];
    [createNotificationButton.layer setCornerRadius:22.0f];
    [createNotificationButton setBackgroundColor:[UIColor redColor]];
    [createNotificationButton setTitleColor:[UIColor whiteColor]
                                   forState:UIControlStateNormal];
    [createNotificationButton setTitleColor:[UIColor lightGrayColor]
                                   forState:UIControlStateHighlighted];
    [createNotificationButton setTitle:@"创建Notification"
                              forState:UIControlStateNormal];
    [createNotificationButton addTarget:self
                                 action:@selector(createNotification:)
                       forControlEvents:UIControlEventTouchUpInside];
    
    _noteInfoLabel = [[UILabel alloc] init];
    [self.view addSubview:self.noteInfoLabel];
    [self.noteInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.left.equalTo(self.view).offset(10.0f);
        make.top.equalTo(self.view).offset(44 + 20 + 10.0f);
        make.height.offset(200.0f);
    }];
    [self.noteInfoLabel.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.noteInfoLabel.layer setBorderWidth:1.0f];
    [self.noteInfoLabel setNumberOfLines:0];
    [self.noteInfoLabel setTextColor:[UIColor grayColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - NotificationDes
- (void)buildNotificationDes:(NSString *)desStr {
    NSAssert(YES, @"The method need rewrite, and create diff notification des.");
    [self.noteInfoLabel setText:desStr];
}

#pragma mark - CreateNotificationAction
- (void)createNotification:(UIButton *)sender {
    NSAssert(NO, @"The method need rewrite, and create diff notification with user.");
}

@end
