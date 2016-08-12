//
//  ViewController.m
//  BundleID2Process
//
//  Created by TuMi on 15/8/24.
//  Copyright (c) 2015年 TuMi. All rights reserved.
//

#define CellIdentifier @"YvTableViewCell"
#define BottomBarHeight 49

#import "YvViewController.h"
#import "YvRuleViewController.h"
#import "YvTableViewCell.h"
#import "YvMoreDetailViewController.h"
#import "YvAllMatchesViewController.h"
#import "YvAppDelegate.h"
#import "YvUtilities.h"
#import "UITableView+SetExtraCellLineHidden.h"

@interface YvViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tableView;
    NSDictionary *_dataDict;
    NSArray *_bundleIDs;
}
@end

@implementation YvViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addBackgroudTimer];
        _dataDict = [NSMutableDictionary dictionary];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshMyPage) name:REFRESHMYUI object:nil];
    }
    return self;
}

#pragma mark - 刷新界面
- (void)refreshMyPage
{
    [_tableView reloadData];
}
/*
#pragma mark - 隐藏状态栏
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
*/
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"匹配列表";
    
    self.navigationController.navigationBar.barTintColor = kColorMainBlue;
    
    [self configureLeftItem];
    
    [self configureRightItem];
    
    [self setupTableView];
    
    [self configureBottomBar];
}

- (void)configureRightItem
{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"规则" style:UIBarButtonItemStylePlain target:self action:@selector(moreDetails)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)configureLeftItem
{
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"清除" style:UIBarButtonItemStylePlain target:self action:@selector(clearAllMatches)];
    self.navigationItem.leftBarButtonItem = leftItem;
}
#pragma mark - 进入匹配详情页面
- (void)moreDetails
{
    YvRuleViewController *vc = [[YvRuleViewController alloc] initWithNibName:@"YvRuleViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 清楚当前缓存的未匹配信息
- (void)clearAllMatches
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:DATA];
    [_tableView reloadData];
}

- (void)setupTableView
{
    _tableView = [[UITableView alloc] init];
    _tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - BottomBarHeight);
    [_tableView setSeparatorInsetZero];
    [_tableView SetExtraCellLineHidden];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [_tableView registerNib:[UINib nibWithNibName:CellIdentifier bundle:nil] forCellReuseIdentifier:CellIdentifier];
    [self.view addSubview:_tableView];
}

#pragma mark - 添加后台运行定时器
- (void)addBackgroudTimer
{
    self.xInt = 0;
    NSTimer *timer = [NSTimer timerWithTimeInterval:SLEEPINTERVAL target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

#pragma mark - 定时操作
- (void)timeAction
{
    self.xInt += 1;
}

#pragma mark - 配置底部的工具条
- (void)configureBottomBar
{
    UIView *bottomView = [[UIView alloc] init];
    bottomView.frame = CGRectMake(0, CGRectGetMaxY(_tableView.frame), self.view.frame.size.width, BottomBarHeight);
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:bottomView];
    
    // 分割线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bottomView.frame.size.width, 1)];
    line.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0f];
    [bottomView addSubview:line];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(40, 10, bottomView.frame.size.width/2.0 - 60, 30);
    leftButton.layer.cornerRadius = 6.0f;
    leftButton.layer.masksToBounds = YES;
    leftButton.backgroundColor = kColorMainBlue;
    [leftButton setTitle:@"任务完成" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [leftButton addTarget:self action:@selector(completeTarget) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:leftButton];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(bottomView.frame.size.width/2.0 + 20, 10, bottomView.frame.size.width/2.0 - 60, 30);
    rightButton.layer.cornerRadius = 6.0f;
    rightButton.layer.masksToBounds = YES;
    rightButton.backgroundColor = kColorMainBlue;
    [rightButton setTitle:@"查看全部" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [rightButton addTarget:self action:@selector(getAllMatches) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:rightButton];
}

#pragma mark - 点击完成任务
- (void)completeTarget
{
    YvDebugLog(@"点击完成任务");
    YvAppDelegate *app = (YvAppDelegate *)[[UIApplication sharedApplication] delegate];
    if (app.isSelectedProcess) {
        app.isSelectedProcess = NO;
        app.isCompleteTarget = YES;
        [YvUtilities showTextHUDMaintain1Seccond:@"本次任务完成！"];
    }else {
        [YvUtilities showTextHUDMaintain1Seccond:@"还没选择进程名！"];
    }
}

#pragma mark - 查看全部匹配
- (void)getAllMatches
{
    YvDebugLog(@"查看全部匹配");
    YvAllMatchesViewController *allMatchesVC = [[YvAllMatchesViewController alloc] initWithNibName:@"YvAllMatchesViewController" bundle:nil];
    [self.navigationController pushViewController:allMatchesVC animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    _dataDict = [NSDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:DATA]];
    _bundleIDs = [NSArray arrayWithArray: [_dataDict allKeys]];
    return _bundleIDs.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YvTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:nil options:nil] firstObject];
    }
    if (_bundleIDs.count > indexPath.row) {
        [cell configCellWithBunleID:_bundleIDs[indexPath.row]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];// 消除选中
    
    if (indexPath.row < _bundleIDs.count) {
        YvMoreDetailViewController *moreDetailVC = [[YvMoreDetailViewController alloc] initWithNibName:@"YvMoreDetailViewController" bundle:nil];
        moreDetailVC.titleString = _bundleIDs[indexPath.row];
        moreDetailVC.data = [NSMutableArray arrayWithArray:[_dataDict objectForKey:_bundleIDs[indexPath.row]]];
        [self.navigationController pushViewController:moreDetailVC animated:YES];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:REFRESHMYUI object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
