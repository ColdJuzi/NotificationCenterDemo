//
//  ViewController.m
//  NotificationCenter
//
//  Created by LiangHao on 2016/9/23.
//  Copyright © 2016年 PhantomSmart. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>

#import "SimpleLocalViewController.h"
#import "TwoTitleLocalViewController.h"
#import "LaunchScreenViewController.h"
#import "SoundAndBadgeViewController.h"
#import "AccessoryImageViewController.h"
#import "AccessoryVideoViewController.h"
#import "ActionNoOperationViewController.h"
#import "ActionOperationViewController.h"
#import "ActionOperationInputViewController.h"
#import "CustomContentViewController.h"
#import "RemoveDefaultContentViewController.h"
#import "ContentFeedbackViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView* notificationCenterTableV;

@property (nonatomic, strong) NSArray* notificationCenterListA;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Notification Center";
    
    _notificationCenterListA = @[@"简单的本地通知",
                                 @"带两个Title的本地通知",
                                 @"改变启动图的本地通知",
                                 @"带声音的本地通知",
                                 @"带图像的本地通知",
                                 @"带视频的本地通知",
                                 @"不进入应用的按钮",
                                 @"进入应用的按钮",
                                 @"带文本输入框的按钮",
                                 @"自定义的通知栏",
                                 @"隐藏系统默认消息框",
                                 @"不进App通知栏反馈",];
    
    [self buildView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSIndexPath* selectedIndexPath = [self.notificationCenterTableV indexPathForSelectedRow];
    if (selectedIndexPath) {
        [self.notificationCenterTableV deselectRowAtIndexPath:selectedIndexPath
                                                     animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - BuildView
- (void)buildView {
    _notificationCenterTableV = [[UITableView alloc] initWithFrame:CGRectZero
                                                             style:UITableViewStylePlain];
    self.notificationCenterTableV.delegate = self;
    self.notificationCenterTableV.dataSource = self;
    [self.view addSubview:self.notificationCenterTableV];
    [self.notificationCenterTableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.notificationCenterListA count];
}

static NSString* cellIdnetifier = @"CellIdentifier";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdnetifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellIdnetifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSString* titleStr = [self.notificationCenterListA objectAtIndex:indexPath.row];
    cell.textLabel.text = titleStr;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController* viewController = nil;
    switch (indexPath.row) {
        case 0:
            viewController = [[SimpleLocalViewController alloc] init];
            break;
        case 1:
            viewController = [[TwoTitleLocalViewController alloc] init];
            break;
        case 2:
            viewController = [[LaunchScreenViewController alloc] init];
            break;
        case 3:
            viewController = [[SoundAndBadgeViewController alloc] init];
            break;
        case 4:
            viewController = [[AccessoryImageViewController alloc] init];
            break;
        case 5:
            viewController = [[AccessoryVideoViewController alloc] init];
            break;
        case 6:
            viewController = [[ActionNoOperationViewController alloc] init];
            break;
        case 7:
            viewController = [[ActionOperationViewController alloc] init];
            break;
        case 8:
            viewController = [[ActionOperationInputViewController alloc] init];
            break;
        case 9:
            viewController = [[CustomContentViewController alloc] init];
            break;
        case 10:
            viewController = [[RemoveDefaultContentViewController alloc] init];
            break;
        case 11:
            viewController = [[ContentFeedbackViewController alloc] init];
            break;

        default:
            break;
    }
    if (viewController) {
        [self.navigationController pushViewController:viewController
                                             animated:YES];
    } else {
        [tableView deselectRowAtIndexPath:indexPath
                                 animated:YES];
    }
}

@end
