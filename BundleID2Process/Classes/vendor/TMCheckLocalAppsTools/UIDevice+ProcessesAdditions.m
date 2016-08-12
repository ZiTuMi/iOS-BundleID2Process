//
//  UIDevice+ProcessesAdditions.m
//  YvOpenURL
//
//  Created by TuMi on 15/8/1.
//  Copyright (c) 2015年 TuMi. All rights reserved.
//

#import "UIDevice+ProcessesAdditions.h"
#import <sys/sysctl.h>

@implementation UIDevice (ProcessesAdditions)

+ (NSArray *)runningProcesses
{
    return [[self currentDevice] runningProcesses];
}

- (NSArray *)runningProcesses
{
    
    int mib[4] = {CTL_KERN, KERN_PROC, KERN_PROC_ALL, 0};
    size_t miblen = 4;
    
    size_t size;
    int st = sysctl(mib, miblen, NULL, &size, NULL, 0);
    
    struct kinfo_proc * process = NULL;
    struct kinfo_proc * newprocess = NULL;
    
    do {
        
        size += size / 10;
        newprocess = realloc(process, size);
        
        if (!newprocess){
            
            if (process){
                free(process);
            }
            
            return nil;
        }
        
        process = newprocess;
        st = sysctl(mib, miblen, process, &size, NULL, 0);
        
    } while (st == -1 && errno == ENOMEM);
    
    if (st == 0){
        
        if (size % sizeof(struct kinfo_proc) == 0){
            int nprocess = size / sizeof(struct kinfo_proc);
            
            if (nprocess){
                
                NSMutableArray * array = [[NSMutableArray alloc] init];
                
                for (int i = nprocess - 1; i >= 0; i--){
/*
                    // 以字典形式存进数组{ProcessID = 3308;ProcessName = Preferences;}
                    NSString * processID = [[NSString alloc] initWithFormat:@"%d", process[i].kp_proc.p_pid];
                    NSString * processName = [[NSString alloc] initWithFormat:@"%s", process[i].kp_proc.p_comm];
                    
                    NSDictionary * dict = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:processID, processName, nil]
                                                                        forKeys:[NSArray arrayWithObjects:@"ProcessID", @"ProcessName", nil]];
                    [array addObject:dict];
 */
                    // 只保存进程名
                    NSString *processName = [[NSString alloc] initWithFormat:@"%s", process[i].kp_proc.p_comm];
                    
                    [array addObject:processName];
                }
                
                free(process);
                return array;
            }
        }
    }
    
    return nil;
}
/*
// Example usage.使用方法
NSArray * processes = [[UIDevice currentDevice] runningProcesses];
for (NSDictionary * dict in processes){
    NSLog(@"%@ - %@", [dict objectForKey:@"ProcessID"], [dict objectForKey:@"ProcessName"]);
}
 */

+ (BOOL)checkMyProcessWithProcessName:(NSString *)processName
{
    NSArray * processes = [self runningProcesses];
    BOOL isExist = NO;
/*
    for (NSDictionary * dict in processes){
        
        //        NSLog(@"ProcessID--%@ - ProcessName--%@", [dict objectForKey:@"ProcessID"], [dict objectForKey:@"ProcessName"]);
        
        if ([[dict objectForKey:@"ProcessName"] isEqualToString:processName]) {
            isExist = YES;
            break;
        }
    }
 */
    for (NSString *process in processes) {
        if ([process isEqualToString:processName]) {
            isExist = YES;
            break;
        }
    }
    return isExist;
}

+ (NSArray *)existProcessesInProcessNames:(NSArray *)processNames
{
    NSMutableArray *existProcesses = [NSMutableArray array];
    
    for (NSString *process in processNames) {
        if ([self checkMyProcessWithProcessName:process]) {
            [existProcesses addObject:process];
        }
    }
    return existProcesses;
}

+ (NSArray *)newIncreaseProcessesWithLastProcesses:(NSArray *)lastProcesses
{
    NSMutableArray *newAddProcesses = [NSMutableArray array];
    
    NSArray * processes = [self runningProcesses];
    
    for (NSString *process in processes) {
        if (![lastProcesses containsObject:process]) {
            [newAddProcesses addObject:process];
        }
    }
    return newAddProcesses;
}

@end
