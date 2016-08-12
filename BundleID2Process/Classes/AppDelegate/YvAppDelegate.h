//
//  AppDelegate.h
//  BundleID2Process
//
//  Created by TuMi on 15/8/24.
//  Copyright (c) 2015年 TuMi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YvAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
// 是否选中进程名
@property (nonatomic, assign) BOOL isSelectedProcess;
// 是否完成任务
@property (nonatomic, assign) BOOL isCompleteTarget;

@end

