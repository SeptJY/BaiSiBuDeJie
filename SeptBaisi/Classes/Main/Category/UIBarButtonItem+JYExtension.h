//
//  UIBarButtonItem+JYExtension.h
//  SeptBaisi
//
//  Created by admin on 16/3/27.
//  Copyright © 2016年 Sept. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (JYExtension)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;

@end
