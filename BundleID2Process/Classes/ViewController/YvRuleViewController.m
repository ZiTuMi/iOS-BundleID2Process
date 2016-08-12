//
//  YvRuleViewController.m
//  BundleID2Process
//
//  Created by TuMi on 15/8/26.
//  Copyright (c) 2015年 TuMi. All rights reserved.
//

#import "YvRuleViewController.h"

@interface YvRuleViewController ()

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

@implementation YvRuleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"使用规则";
    self.detailLabel.numberOfLines = 0;
    self.detailLabel.text = @"1.开启本应用前请先将AppStore开启\n2.本应用开启期间除了目标任务应用外最好不要开启其他应用\n3.请在下载目标应用之前开启本程序\n4.每次只允许匹配一个应用（一次只能下载一个任务完成后开始下一个任务）\n5.任务下载完成后请主动点击运行任务（需将本程序退到后台）\n6.每完成一个任务点击匹配列表的完成按钮后再开始下一个任务\n7.本应用可以长期后台运行,使用结束请自行杀进程";
    
    [self configNavigationBackItem];
}

@end
