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

    
//    UIView *view = [self.tabBarItem valueForKeyPath:@"_view"];
//    view.backgroundColor = [UIColor orangeColor];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // Dispose of any resources that can be recreated.
    self.tabBarItem.badgeValue = @"123";
    self.tabBarItem.title = @"123";
    self.view.backgroundColor = [UIColor greenColor];
    
}

@end
