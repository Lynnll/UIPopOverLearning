//
//  ViewController.m
//  UIPopOverLearning
//
//  Created by lynnjinglei on 15/11/16.
//  Copyright © 2015年 XiaoLei. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"

@interface ViewController ()<UIPopoverPresentationControllerDelegate>
{
    UIButton *popOverButton;
    
    UIBarButtonItem *rightBarButtonItem;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadBarButtonItem];
    
    [self loadButton];
}
- (void)loadBarButtonItem
{
    rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"click" style:UIBarButtonItemStyleBordered target:self action:@selector(rightBarButtonItemClick)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}
- (void)rightBarButtonItemClick
{
    FirstViewController *firstVC = [[FirstViewController alloc]init];
    firstVC.modalPresentationStyle = UIModalPresentationPopover;
    /**
     *  由于导航上的控件没有指定frame，无法设置sourceView和sourceRect，用下面的。
     */
    firstVC.popoverPresentationController.barButtonItem = self.navigationItem.rightBarButtonItem;
    firstVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    firstVC.popoverPresentationController.delegate = self;
    firstVC.preferredContentSize = CGSizeMake(100, 200);
    [self presentViewController:firstVC animated:YES completion:nil];
//    firstVC.popoverPresentationController.passthroughViews = nil;
}
- (void)loadButton
{
    popOverButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    popOverButton.frame = CGRectMake(10, 100, 100, 50);
    popOverButton.backgroundColor = [UIColor lightGrayColor];
    [popOverButton setTitle:@"点击" forState:UIControlStateNormal];
    [popOverButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:popOverButton];
}
- (void)buttonClick
{
    FirstViewController *firstVC = [[FirstViewController alloc] init];
    firstVC.modalPresentationStyle = UIModalPresentationPopover;
    firstVC.popoverPresentationController.sourceView = popOverButton;  //rect参数是以view的左上角为坐标原点（0，0）
    firstVC.popoverPresentationController.sourceRect = popOverButton.bounds; //指定箭头所指区域的矩形框范围（位置和尺寸），以view的左上角为坐标原点
    firstVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp; //箭头方向
    firstVC.popoverPresentationController.delegate = self;
    firstVC.preferredContentSize = CGSizeMake(100, 200);
    [self presentViewController:firstVC animated:YES completion:nil];
    
}
//iPhone下默认是UIModalPresentationFullScreen，需要手动设置为UIModalPresentationNone，iPad不需要
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationNone;
}
- (UIViewController *)presentationController:(UIPresentationController *)controller viewControllerForAdaptivePresentationStyle:(UIModalPresentationStyle)style
{
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller.presentedViewController];
    return navController;
}
- (BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    return YES;   //点击蒙板popover不消失， 默认yes
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
