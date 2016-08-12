//
//  YvUtilities.h
//  BundleID2Process
//
//  Created by TuMi on 15/8/27.
//  Copyright (c) 2015年 TuMi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface YvUtilities : NSObject

#pragma mark -
#pragma mark 第三方控件操作
//第三方控件操作
+ (void)showInitHUD:(UIView *)view;

+ (void)showHUD:(NSString *)text andView:(UIView *)view;

+ (void)showTextHUD:(NSString *)text andView:(UIView *)view;

//显示纯文本，并且维持delay秒后自动关闭
+ (void)showTextHUD:(NSString *)text andView:(UIView *)view maintainTime:(NSTimeInterval)delay;

//显示文本维持2秒
+(void)showTextHUDMaintain2Seccond:(NSString*)text;

// 显示文本维持1秒 add by TuMi 2015-07-22
+(void)showTextHUDMaintain1Seccond:(NSString*)text;

+ (void)hideHUDForView:(UIView*)view;

@end
