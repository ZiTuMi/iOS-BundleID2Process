//
//  TMCheckLocalAppsTools.h
//  DollarHelper
//
//  Created by TuMi on 15/8/6.
//  Copyright (c) 2015年 TuMi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMCheckLocalAppsTools : NSObject

/**
*  查找iOS设备上本地安装的所有应用
*
*  @return 获取所有应用的BundleID列表
*/
+ (NSArray *)searchApps;

/**
 *  查看BundleID为“bundleID”的应用是否已经在设备上安装
 *
 *  @param bundleID 待查BundleID
 *
 *  @return YES 有 NO 无
 */
+ (BOOL)checkAppIsInstalledWithBundleID:(NSString *)bundleID;

/**
 *  获取offerList数组中已经在设备上安装的App列表
 *
 *  @param offerList 目标数组
 *
 *  @return offerList数组中已经在设备上安装的App列表
 */
+ (NSArray *)allInstalledAppsWithOfferList:(NSArray *)offerList;

/**
 *  获取本地最新安装的全部App列表
 *
 *  @param lastLocalAppList 上一次本地全部App列表
 *
 *  @return 本地最新安装的全部App列表
 */
+ (NSArray *)newInstallLocalAppsWithLastLocalAppList:(NSArray *)lastLocalAppList;

/**
 *  获取本地最新删除的全部App列表
 *
 *  @param lastLocalAppList 上一次本地全部App列表
 *
 *  @return 本地最新删除的全部App列表
 */
+ (NSArray *)newDeleteLocalAppsWithLastLocalAppList:(NSArray *)lastLocalAppList;

/**
 *  获取本地最新安装的目标App列表
 *
 *  @param lastLocalAppList 上一次本地全部App列表
 *  @param lastAppList      当前全部任务列表
 *
 *  @return 全部任务中被新安装的App列表
 */
+ (NSArray *)newInstallTargetAppsWithLastLocalAppList:(NSArray *)lastLocalAppList lastAppList:(NSArray *)lastAppList;

/**
 *  获取本地最新删除的目标App列表
 *
 *  @param lastLocalAppList 上一次本地全部App列表
 *  @param lastAppList      当前全部任务列表
 *
 *  @return 全部任务中被新删除的App列表
 */
+ (NSArray *)newDeleteTargetAppsWithLastLocalAppList:(NSArray *)lastLocalAppList lastAppList:(NSArray *)lastAppList;

@end
