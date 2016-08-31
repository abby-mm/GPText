//
//  GPAttributeViewController.m
//  GPText
//
//  Created by dandan on 16/8/31.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPAttributeViewController.h"

@interface GPAttributeViewController ()

@end

@implementation GPAttributeViewController
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNav];
}
#pragma mark - 初始化方法
- (void)setupNav
{
    self.navigationItem.title = @"富文本";
}




@end
