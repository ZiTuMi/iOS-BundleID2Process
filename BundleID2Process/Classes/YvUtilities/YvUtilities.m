//
//  YvUtilities.m
//  BundleID2Process
//
//  Created by TuMi on 15/8/27.
//  Copyright (c) 2015年 TuMi. All rights reserved.
//

#import "YvUtilities.h"
#import "RemindDialogBox.h"

@implementation YvUtilities

#pragma mark -
#pragma mark 第三方控件操作
+ (void)showInitHUD:(UIView *)view
{
    [self showHUD:@"努力加载中" andView:view];
}

+ (void)showHUD:(NSString *)text andView:(UIView *)view
{
    if (!view)
    {
        return;
    }
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:hud];
    hud.labelText = text;
    //    hud.dimBackground = YES;
    hud.square = YES;
    [hud show:YES];
}

//纯文本
+ (void)showTextHUD:(NSString *)text andView:(UIView *)view
{
    if (!view)
    {
        return;
    }
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:hud];
    hud.labelText = text;
    //    hud.dimBackground = YES;
    hud.mode = MBProgressHUDModeText;
    [hud show:YES];
}

//显示纯文本，并且维持delay秒后自动关闭
+ (void)showTextHUD:(NSString *)text andView:(UIView *)view maintainTime:(NSTimeInterval)delay
{
    if (!view)
    {
        return;
    }
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:hud];
    hud.labelText = text;
    //    hud.dimBackground = YES;
    hud.mode = MBProgressHUDModeText;
    [hud show:YES];
    [hud hide:YES afterDelay:delay];
}

+(MBProgressHUD *)showProgressHUD:(NSString*)text andView:(UIView*)view
{
    if (!view) {
        return nil;
    }
    
    MBProgressHUD * hud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:hud];
    hud.labelText = text;
    
    //设置模式为进度框形的
    hud.mode = MBProgressHUDModeDeterminate;//  MBProgressHUDModeDeterminate
    hud.progress = 0.05f;
    [hud show:YES];
    
    return hud;
}

//显示文本维持2秒
+(void)showTextHUDMaintain2Seccond:(NSString*)text
{
    //    YvAppDelegate * appDelegate = (YvAppDelegate *)[UIApplication sharedApplication].delegate;
    //    [self showTextHUD:text andView:appDelegate.window maintainTime:2.0f];
    [RemindDialogBox showWithMsg:text];
}

// 显示文本维持1秒 add by TuMi 2015-07-22
+(void)showTextHUDMaintain1Seccond:(NSString*)text
{
    [RemindDialogBox showWithMsg:text andDelay:1.0f];
}

+ (void)hideHUDForView:(UIView*)view
{
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
}

@end
