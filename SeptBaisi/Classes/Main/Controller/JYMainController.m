//
//  JYMainController.m
//  SeptBaisi
//
//  Created by admin on 16/3/27.
//  Copyright © 2016年 Sept. All rights reserved.
//

#import "JYMainController.h"

#import "JYEsenceController.h"
#import "JYMeController.h"
#import "JYFriendController.h"
#import "JYNewController.h"
#import "JYTabBar.h"
#import "JYNavigationController.h"

@interface JYMainController ()

@end

@implementation JYMainController

+ (void)initialize
{
    UITabBarItem *appearance = [UITabBarItem appearance];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [appearance setTitleTextAttributes:attrs forState:UIControlStateSelected];
    
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // 替换tabbar
    [self setValue:[[JYTabBar alloc] init] forKeyPath:@"tabBar"];
    
    // 初始化所有的子控制器
    [self setupChildViewControllers];
}

/**
 * 初始化所有的子控制器
 */
- (void)setupChildViewControllers
{
    JYEsenceController *essence = [[JYEsenceController alloc] init];
    [self setupOneChildViewController:essence title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    JYNewController *new = [[JYNewController alloc] init];
    [self setupOneChildViewController:new title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    JYFriendController *friends = [[JYFriendController alloc] init];
    [self setupOneChildViewController:friends title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    JYMeController *me = [[JYMeController alloc] init];
    [self setupOneChildViewController:me title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
}

- (void)setupOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    [self addChildViewController:[[JYNavigationController alloc] initWithRootViewController:vc]];
}

@end
