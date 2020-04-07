//
//  BaseNavigationController.m
//  TongXueBao
//
//  Created by 郑文明 on 16/9/22.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>
@property (strong, nonatomic) UIPanGestureRecognizer *panGesture;
@end

@implementation BaseNavigationController
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    if (self = [super initWithRootViewController:rootViewController]) {
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        NSDictionary *attributeDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:17.0],NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName,nil];
        self.navigationBar.titleTextAttributes = attributeDic;
        self.navigationBar.translucent = NO;
        [UINavigationBar appearance].barTintColor = [UIColor redColor];
//        [UINavigationBar appearance].tintColor = kTintColor;
    }
    return self;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    WMLog(@"------>%@",otherGestureRecognizer.delegate);
        if ([otherGestureRecognizer.delegate isKindOfClass:NSClassFromString(@"UICollectionView")]) {
            UICollectionView *cv = (UICollectionView *)otherGestureRecognizer.delegate;
            UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)cv.collectionViewLayout;
            if (flowLayout.scrollDirection==UICollectionViewScrollDirectionHorizontal) {
                if (otherGestureRecognizer.state == UIGestureRecognizerStateBegan &&cv.contentOffset.x>0) {
                    return NO;
                }else if(otherGestureRecognizer.state == UIGestureRecognizerStateBegan &&cv.contentOffset.x<=0){
                    return YES;
                }
            }else{
                if (otherGestureRecognizer.state == UIGestureRecognizerStateBegan &&cv.contentOffset.x>0) {
                    return YES;
                }else if(otherGestureRecognizer.state == UIGestureRecognizerStateBegan &&cv.contentOffset.x<=0){
                    return NO;
                }
            }
            return YES;
        }else if ([otherGestureRecognizer.delegate isKindOfClass:NSClassFromString(@"UITableViewCellContentView")]){
            return YES;
        }else if ([otherGestureRecognizer.delegate isKindOfClass:NSClassFromString(@"UITableViewWrapperView")]){
            return YES;
        }
    return NO;
}
//  防止导航控制器只有一个rootViewcontroller时触发手势
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
   
    //解决与左滑手势冲突
    CGPoint translation = [self.panGesture translationInView:gestureRecognizer.view];
    if (translation.x <= 0) {
        return NO;
    }
    if (self.viewControllers.count > 1) {
        if (self.topViewController.isHideBackItem) {
            return NO;
        }else {
            if ([self.topViewController respondsToSelector:@selector(fullScreenGestureShouldBegin)]) {
                return [self.topViewController fullScreenGestureShouldBegin];
            }
        }
    }
    return self.childViewControllers.count == 1 ? NO : YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //处理全屏返回
    UIGestureRecognizer *systemGes = self.interactivePopGestureRecognizer;
    id target =  systemGes.delegate;
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:target action:NSSelectorFromString(@"handleNavigationTransition:")];
    [self.interactivePopGestureRecognizer.view addGestureRecognizer:self.panGesture];
    self.panGesture.delegate = self;
    systemGes.enabled = NO;
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{

    if (self.viewControllers.count>0) {
        viewController.hidesBottomBarWhenPushed = YES;//处理隐藏tabbar
            if (viewController.isHideBackItem == YES) {
                viewController.navigationItem.hidesBackButton = YES;
            }else{
                //给push的每个VC加返回按钮
//                NSString *imageName = [viewController backIconName];
//                viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:imageName highIcon:@"" target:self action:@selector(back:)];
            }
    }
    [super pushViewController:viewController animated:animated];
    // 修正push控制器tabbar上移问题
    if (@available(iOS 11.0, *)){
        // 修改tabBra的frame
        CGRect frame = self.tabBarController.tabBar.frame;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
        self.tabBarController.tabBar.frame = frame;
    }
}
-(void)back:(UIBarButtonItem *)sender{
    [self.view endEditing:YES];
    UIViewController * currentVC = self.topViewController;
    if (currentVC.popBlock) {
        currentVC.popBlock(sender);
    }else{
        [self popViewControllerAnimated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
