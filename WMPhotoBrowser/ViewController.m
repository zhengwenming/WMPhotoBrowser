//
//  ViewController.m
//  WMPhotoBrowser
//
//  Created by zhengwenming on 2017/12/29.
//  Copyright © 2017年 zhengwenming. All rights reserved.
//

#import "ViewController.h"
#import "WMPhotoBrowser.h"
#import "UIView+WMFrame.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"图片浏览器";
    //1、测试URL图片
        UIButton *testBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        testBtn1.frame = CGRectMake(0, 0, 150, 40);
        [testBtn1 setBackgroundColor:[UIColor greenColor]];
        testBtn1.center = self.view.center;
        [testBtn1 setTitle:@"浏览URL图片" forState:UIControlStateNormal];
        [testBtn1 addTarget:self action:@selector(test1:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:testBtn1];
    
    //2、测试本地图片
        UIButton *testBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        testBtn2.frame = CGRectMake(testBtn1.origin.x, testBtn1.centerY+50, testBtn1.width, testBtn1.height);
        [testBtn2 setBackgroundColor:[UIColor greenColor]];
        [testBtn2 setTitle:@"浏览本地图片" forState:UIControlStateNormal];
        [testBtn2 addTarget:self action:@selector(test2:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:testBtn2];
    
    //3、测试混合图片
        UIButton *testBtn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        testBtn3.frame = CGRectMake(testBtn1.origin.x, testBtn2.centerY+50, testBtn1.width, testBtn1.height);
        [testBtn3 setBackgroundColor:[UIColor greenColor]];
        [testBtn3 setTitle:@"浏览混合图片" forState:UIControlStateNormal];
        [testBtn3 addTarget:self action:@selector(test3:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:testBtn3];
    
}
-(void)test1:(UIButton *)sender{
    WMPhotoBrowser *browser = [WMPhotoBrowser new];
    browser.dataSource = @[@"http://weixintest.ihk.cn/ihkwx_upload/commentPic/20160426/14616659617000.jpg",@"http://weixintest.ihk.cn/ihkwx_upload/commentPic/20160307/14573358906810.JPEG",@"http://weixintest.ihk.cn/ihkwx_upload/userPhoto/18565061404-1448440129479.jpg",@"http://weixintest.ihk.cn/ihkwx_upload/commentPic/20160519/14636417292422.jpg"].mutableCopy;
    browser.deleteNeeded = YES;
    [self.navigationController pushViewController:browser animated:YES];
}

-(void)test2:(UIButton *)sender{
    
    WMPhotoBrowser *browser = [WMPhotoBrowser new];
    browser.dataSource = @[[UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"],[UIImage imageNamed:@"3"],[UIImage imageNamed:@"4"],[UIImage imageNamed:@"5"]].mutableCopy;
    browser.downLoadNeeded = YES;
    browser.currentPhotoIndex= 2;
    [self presentViewController:browser animated:YES completion:^{
        
    }];
}

-(void)test3:(UIButton *)sender{
    WMPhotoBrowser *browser = [WMPhotoBrowser new];
    browser.dataSource = @[@"http://weixintest.ihk.cn/ihkwx_upload/commentPic/20160519/14636417276611.jpg",[UIImage imageNamed:@"2"],[UIImage imageNamed:@"3"],[UIImage imageNamed:@"4"],@"http://weixintest.ihk.cn/ihkwx_upload/userPhoto/15914867203-1461920972642.jpg",@"http://weixintest.ihk.cn/ihkwx_upload/userPhoto/13719162910-1463115526444.jpg",[UIImage imageNamed:@"5"]].mutableCopy;
    browser.downLoadNeeded = YES;
    [self.navigationController pushViewController:browser animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
