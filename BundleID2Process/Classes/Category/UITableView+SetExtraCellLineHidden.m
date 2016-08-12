//
//  UITableView+SetExtraCellLineHidden.m
//  TestSectionTable
//
//  Created by TuMi on 15-8-16.
//  Copyright (c) 2014年 yunva.com. All rights reserved.
//

#import "UITableView+SetExtraCellLineHidden.h"

@implementation UITableView (SetExtraCellLineHidden)

- (void)SetExtraCellLineHidden
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self setTableFooterView:view];
    self.separatorColor = kColorMainBlue;
}

- (void)setSeparatorInsetZero
{
    if([self respondsToSelector:@selector(setSeparatorInset:)])
    {
        self.separatorInset = UIEdgeInsetsZero;
    }
    if([self respondsToSelector:@selector(setLayoutMargins:)])
    {
        self.layoutMargins = UIEdgeInsetsZero;
    }
}


@end
