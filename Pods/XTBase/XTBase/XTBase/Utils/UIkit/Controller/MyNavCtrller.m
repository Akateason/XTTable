//
//  MyNavCtrller.m
//  SuBaoJiang
//
//  Created by apple on 15/6/3.
//  Copyright (c) 2015年 teason. All rights reserved.
//
#import "MyNavCtrller.h"


@interface MyNavCtrller ()

@end


@implementation MyNavCtrller

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
