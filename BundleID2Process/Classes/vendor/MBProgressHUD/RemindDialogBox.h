//
//  RemindDialogBox.h
//  yaya
//
//  Created by 朱文腾 on 14-7-24.
//  Copyright (c) 2014年 YunVa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RemindDialogBox : UIView

@property(nonatomic,retain)UILabel *lbl;

+ (void)showWithMsg:(NSString *)msg;
// add by TuMi 2015-07-22
+ (void)showWithMsg:(NSString *)msg andDelay:(CGFloat)delay;
@end
