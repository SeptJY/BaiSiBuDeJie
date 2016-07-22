//
//  JYFriendController.m
//  SeptBaisi
//
//  Created by admin on 16/3/27.
//  Copyright © 2016年 Sept. All rights reserved.
//

#import "JYFriendController.h"
#import "JYAttentionController.h"

@interface JYFriendController ()

@end

@implementation JYFriendController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置导航栏标题
    self.navigationController.title = @"我的关注";
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendBtnOnClick)];
}

- (void)friendBtnOnClick
{
    JYAttentionController *attentionCtl = [[JYAttentionController alloc] init];
    
    [self.navigationController pushViewController:attentionCtl animated:YES
     ];
}

@end
