//
//  BaseViewController.m
//  WMPhotoBrowser
//
//  Created by zhengwenming on 2018/1/5.
//  Copyright © 2018年 zhengwenming. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if (@available(ios 11.0,*)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        UITableView.appearance.estimatedRowHeight = 0;
        UITableView.appearance.estimatedSectionFooterHeight = 0;
        UITableView.appearance.estimatedSectionHeaderHeight = 0;
    }else{
        if([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)])
        {
            self.automaticallyAdjustsScrollViewInsets=NO;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
