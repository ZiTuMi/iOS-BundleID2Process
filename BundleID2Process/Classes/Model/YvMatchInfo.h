//
//  YvMatchInfo.h
//  BundleID2Process
//
//  Created by TuMi on 15/8/27.
//  Copyright (c) 2015年 TuMi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YvMatchInfo : NSObject

@property (nonatomic, copy) NSString *bundleID;
@property (nonatomic, copy) NSString *processName;
@property (nonatomic, assign) BOOL isSelected;

@end
