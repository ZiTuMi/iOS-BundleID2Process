//
//  YvTableViewCell.m
//  BundleID2Process
//
//  Created by TuMi on 15/8/24.
//  Copyright (c) 2015年 TuMi. All rights reserved.
//

#import "YvTableViewCell.h"
#import "YvMatchInfo.h"

@interface YvTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *budleLabel;

@end

@implementation YvTableViewCell

- (void)awakeFromNib
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)configCellWithBunleID:(NSString *)bundleID
{
    self.budleLabel.text = bundleID;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)configureCellWithMatchInfo:(YvMatchInfo *)info
{
    if (info) {
        self.budleLabel.text = info.processName;
        if (info.isSelected) {
            self.accessoryType = UITableViewCellAccessoryCheckmark;
        }else {
            self.accessoryType = UITableViewCellAccessoryNone;
        }
    }
}

@end
