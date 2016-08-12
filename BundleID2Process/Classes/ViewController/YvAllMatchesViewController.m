//
//  YvAllMatchesViewController.m
//  BundleID2Process
//
//  Created by TuMi on 15/8/27.
//  Copyright (c) 2015年 TuMi. All rights reserved.
//

#define CellIdentifier @"YvAllMatchesCell"

#import "YvAllMatchesViewController.h"
#import "YvAllMatchesCell.h"
#import "UITableView+SetExtraCellLineHidden.h"
#import "YvMatchInfo.h"

@interface YvAllMatchesViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSDictionary *_dataDict;
    NSArray *_bundleIDArray;
    NSMutableArray *_matchInfos;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation YvAllMatchesViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataDict = [NSDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:ALLDATA]];
        _bundleIDArray = [_dataDict allKeys];
        _matchInfos = [NSMutableArray array];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _dataDict = [NSDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:ALLDATA]];
        _bundleIDArray = [_dataDict allKeys];
        _matchInfos = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configNavigationBackItem];
    
    self.title = @"全部匹配";
    
    [self sortData];
    
    [self.tableView SetExtraCellLineHidden];
    [self.tableView setSeparatorInsetZero];
    
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    
    [self.tableView registerNib:[UINib nibWithNibName:CellIdentifier bundle:nil] forCellReuseIdentifier:CellIdentifier];
    
    [self configureRightItem];
}

- (void)sortData
{
    for (NSString *bundleID in _bundleIDArray) {
        YvMatchInfo *info = [[YvMatchInfo alloc] init];
        info.bundleID = bundleID;
        info.processName = [_dataDict objectForKey:bundleID];
        info.isSelected = NO;
        [_matchInfos addObject:info];
    }
}

- (void)configureRightItem
{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"清除" style:UIBarButtonItemStylePlain target:self action:@selector(clearAllMatches)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark - 清楚当前缓存的未匹配信息
- (void)clearAllMatches
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:ALLDATA];
    [_matchInfos removeAllObjects];
    _dataDict = [NSDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:ALLDATA]];
    _bundleIDArray = [_dataDict allKeys];
    [self sortData];
    [_tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _matchInfos.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YvAllMatchesCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil] firstObject];
    }
    
    YvMatchInfo *info = nil;
    if (indexPath.row < _matchInfos.count) {
        info = (YvMatchInfo *)[_matchInfos objectAtIndex:indexPath.row];
    }
    if (info) {
        [cell configureCellWithMatchInfo:info];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];// 消除选中
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
