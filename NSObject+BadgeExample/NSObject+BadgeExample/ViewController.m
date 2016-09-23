//
//  ViewController.m
//  NSObject+BadgeExample
//
//  Created by 飞飞 on 16/9/23.
//  Copyright © 2016年 FeiFei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
   [super viewDidLoad];

    UIButton *btn = [[UIButton alloc] init];
    btn.backgroundColor = [UIColor orangeColor];
    btn.frame = CGRectMake(100, 100, 100, 44);
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}



- (void)click:(UIButton *)btn {
//    self.tabBarItem.title = @"1334";

//    NSLog(@"%@-----%@",self.tabBarItem,self.tabBarController);
    self.tabBarItem.badgeValue = @"134141";
    
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    // Dispose of any resources that can be recreated.
//    self.tabBarItem.badgeValue = @"123";
//    self.tabBarItem.title = @"123";
//    self.view.backgroundColor = [UIColor greenColor];
    
}

@end
