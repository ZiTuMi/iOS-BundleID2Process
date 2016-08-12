//
//  YvAllMatchesCell.m
//  BundleID2Process
//
//  Created by TuMi on 15/8/27.
//  Copyright (c) 2015年 TuMi. All rights reserved.
//

#import "YvAllMatchesCell.h"
#import "YvMatchInfo.h"

@interface YvAllMatchesCell ()
@property (weak, nonatomic) IBOutlet UILabel *bundleLabel;
@property (weak, nonatomic) IBOutlet UILabel *processLabel;

@end

@implementation YvAllMatchesCell

- (void)awakeFromNib
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)configureCellWithMatchInfo:(YvMatchInfo *)info
{
    if (info) {
        self.bundleLabel.text = info.bundleID;
        self.processLabel.text = info.processName;
    }
}
@end
