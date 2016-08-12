//
//  YvTableViewCell.h
//  BundleID2Process
//
//  Created by TuMi on 15/8/24.
//  Copyright (c) 2015年 TuMi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YvMatchInfo;

@interface YvTableViewCell : UITableViewCell

- (void)configCellWithBunleID:(NSString *)bundleID;

- (void)configureCellWithMatchInfo:(YvMatchInfo *)info;

@end
