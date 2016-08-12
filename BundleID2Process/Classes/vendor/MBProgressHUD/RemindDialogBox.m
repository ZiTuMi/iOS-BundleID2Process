//
//  RemindDialogBox.m
//  yaya
//
//  Created by 朱文腾 on 14-7-24.
//  Copyright (c) 2014年 YunVa. All rights reserved.
//

#import "RemindDialogBox.h"

@interface RemindDialogBox ()
{
    
}

@end

@implementation RemindDialogBox
{
//    UILabel *lbl;
}




- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)init
{
    self = [super init];
    if (self) {
        
        CGSize mainsize = [UIScreen mainScreen].bounds.size;
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        //self.frame = CGRectMake(40, mainsize.height-70, mainsize.width-80, 30);
        self.frame = CGRectMake(40, (mainsize.height-40)/2.0, mainsize.width-80, 40);
        self.layer.masksToBounds=YES;
        self.layer.cornerRadius = 5;
    
        self.layer.shadowColor = [[UIColor blackColor] CGColor];
        self.layer.shadowOffset = CGSizeMake(0,0);
        self.layer.shadowOpacity = 1;
        self.layer.shadowRadius = 9;
        
        
        //self.lbl = [[UILabel alloc]initWithFrame:CGRectMake(0,0,mainsize.width-80,30)];
        self.lbl = [[UILabel alloc] initWithFrame:self.bounds];
        self.lbl.textColor = [UIColor whiteColor];
        self.lbl.backgroundColor = [UIColor clearColor];
        self.lbl.font = [UIFont systemFontOfSize:14];
        self.lbl.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.lbl];
        
    }
    
    return self;
}


+ (void)showWithMsg:(NSString *)msg
{
    static RemindDialogBox * instanceremind;
    if (!instanceremind)
    {
        instanceremind = [[RemindDialogBox alloc]init];
    }
    [instanceremind removeFromSuperview];
    
    instanceremind.lbl.text = msg;
    
    CGSize mainsize = [UIScreen mainScreen].bounds.size;
    [instanceremind.lbl sizeToFit];
    
//    instanceremind.width = instanceremind.lbl.width+20;
//    instanceremind.left = (mainsize.width-instanceremind.width)/2.0;
    instanceremind.frame = CGRectMake((mainsize.width-instanceremind.frame.size.width)/2.0, instanceremind.frame.origin.y, instanceremind.lbl.frame.size.width + 20, instanceremind.frame.size.height);
    
//    instanceremind.lbl.top = (instanceremind.height-instanceremind.lbl.height)/2.0;
//    instanceremind.lbl.left = (instanceremind.width-instanceremind.lbl.width)/2.0;
    instanceremind.lbl.frame = CGRectMake((instanceremind.frame.size.width-instanceremind.lbl.frame.size.width)/2.0, (instanceremind.frame.size.height-instanceremind.lbl.frame.size.height)/2.0, instanceremind.lbl.frame.size.width, instanceremind.lbl.frame.size.height);
    
    
    instanceremind.alpha = 0;
    [[[UIApplication sharedApplication] keyWindow]addSubview:instanceremind];
    
    [UIView animateWithDuration:0.5 animations:^{
        instanceremind.alpha= 1;
        
    } completion:^(BOOL finished) {
        if (finished) {
            
        }
    }];
    
    [UIView animateWithDuration:0.5 delay:2.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        instanceremind.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [instanceremind removeFromSuperview];
        }
    }];
}

// add by TuMi 2015-07-22
+ (void)showWithMsg:(NSString *)msg andDelay:(CGFloat)delay
{
    static RemindDialogBox * instanceremind;
    if (!instanceremind)
    {
        instanceremind = [[RemindDialogBox alloc]init];
    }
    [instanceremind removeFromSuperview];
    
    instanceremind.lbl.text = msg;
    
    CGSize mainsize = [UIScreen mainScreen].bounds.size;
    [instanceremind.lbl sizeToFit];
    
//    instanceremind.width = instanceremind.lbl.width+20;
//    instanceremind.left = (mainsize.width-instanceremind.width)/2.0;
    instanceremind.frame = CGRectMake((mainsize.width-instanceremind.frame.size.width)/2.0, instanceremind.frame.origin.y, instanceremind.lbl.frame.size.width + 20, instanceremind.frame.size.height);
    
//    instanceremind.lbl.top = (instanceremind.height-instanceremind.lbl.height)/2.0;
//    instanceremind.lbl.left = (instanceremind.width-instanceremind.lbl.width)/2.0;
    instanceremind.lbl.frame = CGRectMake((instanceremind.frame.size.width-instanceremind.lbl.frame.size.width)/2.0, (instanceremind.frame.size.height-instanceremind.lbl.frame.size.height)/2.0, instanceremind.lbl.frame.size.width, instanceremind.lbl.frame.size.height);
    
    
    instanceremind.alpha = 0;
    [[[UIApplication sharedApplication] keyWindow]addSubview:instanceremind];
    
    [UIView animateWithDuration:0.5 animations:^{
        instanceremind.alpha= 1;
        
    } completion:^(BOOL finished) {
        if (finished) {
            
        }
    }];
    
    [UIView animateWithDuration:0.5 delay:delay options:UIViewAnimationOptionLayoutSubviews animations:^{
        instanceremind.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [instanceremind removeFromSuperview];
        }
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
