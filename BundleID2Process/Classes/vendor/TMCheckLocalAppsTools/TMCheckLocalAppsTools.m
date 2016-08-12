//
//  TMCheckLocalAppsTools.m
//  DollarHelper
//
//  Created by TuMi on 15/8/6.
//  Copyright (c) 2015年 TuMi. All rights reserved.
//

#import "TMCheckLocalAppsTools.h"

@implementation TMCheckLocalAppsTools

+ (NSArray *)searchApps
{
    Class LSApplicationWorkspace_class = objc_getClass("LSApplicationWorkspace");
    NSObject *workspace = [LSApplicationWorkspace_class performSelector:@selector(defaultWorkspace)];
//    NSLog(@"apps: %@", [workspace performSelector:@selector(allApplications)]);
    
    NSString *apps = [NSString stringWithFormat:@"%@", [workspace performSelector:@selector(allApplications)]];
//    NSLog(@"%@", apps);
    
    // 将应用BundleID分离
    NSArray *tempArray = [apps componentsSeparatedByString:@","];
    NSMutableArray *appArray = [NSMutableArray array];
    for (NSString *tempStr in tempArray) {
        NSArray *subStrArray1 = [tempStr componentsSeparatedByString:@"> "];
        if (subStrArray1.count >= 2) {
            NSArray *subStrArray2 = [subStrArray1[1] componentsSeparatedByString:@"\""];
            if (subStrArray2.count >= 2) {
                [appArray addObject:subStrArray2[0]];
            }
        }
    }
//    NSLog(@"_________________________appArray.count--%@_%@___________________________", @(appArray.count), appArray);
    return appArray;
}

+ (BOOL)checkAppIsInstalledWithBundleID:(NSString *)bundleID
{
    NSArray *apps = [NSArray arrayWithArray:[self searchApps]];
    return [apps containsObject:bundleID];
}

+ (NSArray *)allInstalledAppsWithOfferList:(NSArray *)offerList
{
    NSMutableArray *installedApps = [NSMutableArray array];
    
    for (NSString *bundleID in offerList) {
        if ([self checkAppIsInstalledWithBundleID:bundleID]) {
            [installedApps addObject:bundleID];
        }
    }
    return installedApps;
}

+ (NSArray *)newInstallLocalAppsWithLastLocalAppList:(NSArray *)lastLocalAppList
{
    NSArray *currentLocalApps = [NSArray arrayWithArray:[self searchApps]];
    NSMutableArray *localAppChanges = [NSMutableArray array];
    for (NSString *app in currentLocalApps) {
        if (![lastLocalAppList containsObject:app]) {
            [localAppChanges addObject:app];
        }
    }
    return localAppChanges;
}

+ (NSArray *)newDeleteLocalAppsWithLastLocalAppList:(NSArray *)lastLocalAppList
{
    NSArray *currentLocalApps = [NSArray arrayWithArray:[self searchApps]];
    NSMutableArray *localAppChanges = [NSMutableArray array];
    for (NSString *app in lastLocalAppList) {
        if (![currentLocalApps containsObject:app]) {
            [localAppChanges addObject:app];
        }
    }
    return localAppChanges;
}

+ (NSArray *)newInstallTargetAppsWithLastLocalAppList:(NSArray *)lastLocalAppList lastAppList:(NSArray *)lastAppList
{
    NSArray *localAppChanges = [self newInstallLocalAppsWithLastLocalAppList:lastLocalAppList];
    NSMutableArray *tagetAppChanges = [NSMutableArray array];
    for (NSString *app in localAppChanges) {
        if ([lastAppList containsObject:app]) {
            [tagetAppChanges addObject:app];
        }
    }
    return tagetAppChanges;
}

+ (NSArray *)newDeleteTargetAppsWithLastLocalAppList:(NSArray *)lastLocalAppList lastAppList:(NSArray *)lastAppList
{
    NSArray *localAppChanges = [self newDeleteLocalAppsWithLastLocalAppList:lastLocalAppList];
    NSMutableArray *tagetAppChanges = [NSMutableArray array];
    for (NSString *app in localAppChanges) {
        if ([lastAppList containsObject:app]) {
            [tagetAppChanges addObject:app];
        }
    }
    return tagetAppChanges;
}

@end
