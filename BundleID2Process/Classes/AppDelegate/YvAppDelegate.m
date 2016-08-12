//
//  AppDelegate.m
//  BundleID2Process
//
//  Created by TuMi on 15/8/24.
//  Copyright (c) 2015年 TuMi. All rights reserved.
//

#import "YvAppDelegate.h"
#import "MMPDeepSleepPreventer.h"
#import "YvViewController.h"
#import "TMCheckLocalAppsTools.h"
#import "UIDevice+ProcessesAdditions.h"

@interface YvAppDelegate ()<UIAlertViewDelegate>
{
    YvViewController *_viewController;
    UIAlertView *_alertView;
    // 新的App列表
    NSMutableArray *_newApps;
    // 新的进程名
    NSMutableArray *_newProcess;
    // 最近一次的本地程序列表
    NSMutableArray *_lastLocalApps;
    // 最近一次的进程列表
    NSMutableArray *_lastProcesses;
    
}
@end

@implementation YvAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // 后台运行
    MMPDeepSleepPreventer *deepSleep = [[MMPDeepSleepPreventer alloc] init];
    [deepSleep startPreventSleep];
    
    // 初次启动，保存字符串@“NO”，证明程序在前台
    [self cacheApplicationState:@"NO"];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    _viewController = [[YvViewController alloc] init];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:_viewController];
    [self.window makeKeyAndVisible];
    
    // 在包装成UINavigationController后self.window.rootViewController得到的是UINavigationController不是YvViewController
//    _viewController = (YvViewController *)self.window.rootViewController;
    _viewController = (YvViewController *)[[(UINavigationController *)self.window.rootViewController childViewControllers] firstObject];
    [_viewController addObserver:self forKeyPath:@"xInt" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    // ios8  注册本地通知
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationSettings *noteSetting =[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:noteSetting];
    }

    _lastLocalApps = [NSMutableArray arrayWithArray:[TMCheckLocalAppsTools searchApps]];
    _lastProcesses = [NSMutableArray arrayWithArray:[UIDevice runningProcesses]];
    
    return YES;
}

#pragma mark - 静默后台SEL
//保存程序当前的状态，，为 yes 时说明程序在后台，为 no 时说明程序在前台
- (void)cacheApplicationState:(NSString *)string
{
    NSUserDefaults *users = [NSUserDefaults standardUserDefaults];
    if ([users stringForKey:@"isBack"]) {
        [users removeObjectForKey:@"isBack"];
        [users setValue:string forKey:@"isBack"];
        [users synchronize];
    }else {
        [users setValue:string forKey:@"isBack"];
        [users synchronize];
    }
}

//取出程序当前的状态，为 yes 时说明程序在后台，为 no 时说明程序在前台
- (BOOL)receiptApplicationState
{
    NSUserDefaults *users = [NSUserDefaults standardUserDefaults];
    NSString *string = [users stringForKey:@"isBack"];
    if ([string isEqualToString:@"YES"]) {
        return YES;
    }else
        return NO;
}

#pragma mark - Key-Value Observing SEL实现定时操作
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"xInt"]) {
        /*
         NSNumber *num = [_viewController valueForKeyPath:@"xInt"];
         //模拟到达目的地。。。当num为5时,提示用户
         
         if ([num longLongValue] == 5) {
         [self tanchuAlert];
         }
         */
        
        // 做相关的监控操作
        YvDebugLog(@"_________________________heartBeat__________________________");
        
        NSArray *tempArr1 = [TMCheckLocalAppsTools newInstallLocalAppsWithLastLocalAppList:_lastLocalApps];
        NSArray *tempArr2 = [UIDevice newIncreaseProcessesWithLastProcesses:_lastProcesses];
        YvDebugLog(@"-----tempArr1-%@-----", tempArr1);
        YvDebugLog(@"-----tempArr2-%@-----", tempArr2);
        if (tempArr1.count == 1) {
            if ([[tempArr1 lastObject] rangeOfString:@"Placeholder"].location != NSNotFound) {
                return;
            }
            
            if (self.isCompleteTarget) {
                self.isCompleteTarget = NO;
                [_lastLocalApps addObject:[tempArr1 lastObject]];
                [_lastProcesses addObjectsFromArray:tempArr2];
            }else {
                NSMutableDictionary *matches = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:DATA]];
                [matches setObject:tempArr2 forKey:[tempArr1 lastObject]];
                [[NSUserDefaults standardUserDefaults] setObject:matches forKey:DATA];
                [[NSNotificationCenter defaultCenter] postNotificationName:REFRESHMYUI object:nil];
            }
        }
    }
}

- (void)tanchuAlert
{
    if ([self receiptApplicationState]) {
        //当程序在后台时，发送本地通知
        [self addLocalPush];
    }else {
        //当程序在前台时，弹出提示框
        _alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"玩赚小帮手正处在前台!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [_alertView show];
    }
}

- (void)addLocalPush
{
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    if (notification != nil) {
        notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:1];//1秒后通知
        notification.repeatInterval = 0;//循环次数，kCFCalendarUnitWeekday一周一次
        notification.timeZone = [NSTimeZone defaultTimeZone];
        notification.applicationIconBadgeNumber += 1; //应用的红色数字
        notification.soundName = UILocalNotificationDefaultSoundName;//声音
        //去掉下面2行就不会弹出提示框
        notification.alertBody = @"您已经到达目的地！";//提示信息 弹出提示框
        notification.alertAction = @"这里可以自定义";  //提示框按钮
        notification.hasAction = NO; //是否显示额外的按钮，为no时alertAction消失
        
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    //为yes时 程序处在后台
    [self cacheApplicationState:@"YES"];
    
    if (_alertView) {
        [_alertView dismissWithClickedButtonIndex:0 animated:YES];
        _alertView = nil;
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    //为no时 程序处在前台
    [self cacheApplicationState:@"NO"];
    [UIApplication sharedApplication].applicationIconBadgeNumber -= 1;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    
}

@end
