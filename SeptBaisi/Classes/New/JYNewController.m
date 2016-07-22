//
//  JYNewController.m
//  SeptBaisi
//
//  Created by admin on 16/3/27.
//  Copyright © 2016年 Sept. All rights reserved.
//

#import "JYNewController.h"

@interface JYNewController ()

@end

@implementation JYNewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(newClick)];
}

- (void)newClick
{
    
}


@end
