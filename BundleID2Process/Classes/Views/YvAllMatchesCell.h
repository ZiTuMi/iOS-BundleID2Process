//
//  YvAllMatchesCell.h
//  BundleID2Process
//
//  Created by TuMi on 15/8/27.
//  Copyright (c) 2015年 TuMi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YvMatchInfo;

@interface YvAllMatchesCell : UITableViewCell

- (void)configureCellWithMatchInfo:(YvMatchInfo *)info;

@end
