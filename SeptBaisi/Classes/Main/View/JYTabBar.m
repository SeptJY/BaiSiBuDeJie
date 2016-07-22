//
//  JYTabBar.m
//  SeptBaisi
//
//  Created by admin on 16/3/27.
//  Copyright © 2016年 Sept. All rights reserved.
//

#import "JYTabBar.h"

@interface JYTabBar()

@property (strong, nonatomic) UIButton *publishBtn;

@end

@implementation JYTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (UIButton *)publishBtn
{
    if (!_publishBtn) {
        
        _publishBtn = [[UIButton alloc] init];
        
        [_publishBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        
        [self addSubview:_publishBtn];
    }
    return _publishBtn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置发布按钮的frmae
    self.publishBtn.bounds = CGRectMake(0, 0, self.publishBtn.currentBackgroundImage.size.width, self.publishBtn.currentBackgroundImage.size.height);
    
    self.publishBtn.center = CGPointMake(self.width * 0.5, self.height * 0.5);
    
    // 设置其他UITabBarButton的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = self.width / 5;
    CGFloat buttonH = self.height;
    NSInteger index = 0;
    
    for (UIView *button in self.subviews) {
        
//        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        // 或者
        if (![button isKindOfClass:[UIControl class]] || button == self.publishBtn) continue;
        
        CGFloat buttonX = buttonW * ((index > 1) ? (index + 1) : index);
        
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 增加索引
        index++;
    }
}

@end
