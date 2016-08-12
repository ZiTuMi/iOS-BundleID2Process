//
//  YvMoreDetailViewController.m
//  BundleID2Process
//
//  Created by TuMi on 15/8/27.
//  Copyright (c) 2015年 TuMi. All rights reserved.
//

#define CellIdentifier @"YvTableViewCell"

#import "YvMoreDetailViewController.h"
#import "YvTableViewCell.h"
#import "YvAppDelegate.h"
#import "YvMatchInfo.h"
#import "UITableView+SetExtraCellLineHidden.h"
#import "YvUtilities.h"

@interface YvMoreDetailViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *_matchInfos;
    NSUInteger _index;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation YvMoreDetailViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _matchInfos = [NSMutableArray array];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _matchInfos = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configNavigationBackItem];
    
    [self configureRightItem];
    
    [self sortData];
    
    self.title = self.titleString;
    
    [self.tableView SetExtraCellLineHidden];
    [self.tableView setSeparatorInsetZero];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    
    [self.tableView registerNib:[UINib nibWithNibName:CellIdentifier bundle:nil] forCellReuseIdentifier:CellIdentifier];
}

- (void)sortData
{
    for (NSString *process in self.data) {
        YvMatchInfo *info = [[YvMatchInfo alloc] init];
        info.processName = process;
        info.isSelected = NO;
        [_matchInfos addObject:info];
    }
}

- (void)configureRightItem
{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(confirmMatch)];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

#pragma mark - 选定当前匹配
- (void)confirmMatch
{
    YvDebugLog(@"选定当前匹配");
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary: [[NSUserDefaults standardUserDefaults] objectForKey:ALLDATA]];
    if (self.data.count > _index) {
        [dict setObject:[self.data objectAtIndex:_index] forKey:self.titleString];
        [[NSUserDefaults standardUserDefaults] setObject:dict forKey:ALLDATA];
        YvAppDelegate *app = (YvAppDelegate *)[[UIApplication sharedApplication] delegate];
        app.isSelectedProcess = YES;
        [YvUtilities showTextHUDMaintain1Seccond:@"选定匹配完成！"];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _matchInfos.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YvTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
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
    
    BOOL someoneSelected = NO;
    NSArray *tempArray = [NSArray arrayWithArray:_matchInfos];
    for (int i = 0; i < tempArray.count; i++) {
        YvMatchInfo *tempInfo = (YvMatchInfo *)[_matchInfos objectAtIndex:i];
        if (i == indexPath.row) {
            tempInfo.isSelected = !tempInfo.isSelected;
            if (tempInfo.isSelected) {
                someoneSelected = YES;
                _index = indexPath.row;
            }
        }else {
            tempInfo.isSelected = NO;
        }
    }
    
    self.navigationItem.rightBarButtonItem.enabled = someoneSelected;
    
    [tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
