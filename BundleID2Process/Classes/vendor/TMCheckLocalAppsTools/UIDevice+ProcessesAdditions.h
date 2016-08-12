//
//  UIDevice+ProcessesAdditions.h
//  YvOpenURL
//
//  Created by TuMi on 15/8/1.
//  Copyright (c) 2015年 TuMi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (ProcessesAdditions)

/**
 * 获取iOS设备当前所有进程（返回进程名称列表）
 */
+ (NSArray *)runningProcesses;
/**
 * 查看当前进程中是否存在名为“processName”的进程（YES 有 NO 无）
 */
+ (BOOL)checkMyProcessWithProcessName:(NSString *)processName;
/**
 * 返回进程名数组中当前还在运行的进程名称列表
 */
+ (NSArray *)existProcessesInProcessNames:(NSArray *)processNames;
/**
 *  获取新增的进程名列表
 *
 *  @param lastProcesses 最近一次的进程名列表
 *
 *  @return 新增进程名列表
 */
+ (NSArray *)newIncreaseProcessesWithLastProcesses:(NSArray *)lastProcesses;
@end
