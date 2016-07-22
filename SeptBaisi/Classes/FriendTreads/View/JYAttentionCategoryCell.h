//
//  JYAttentionCategoryCell.h
//  SeptBaisi
//
//  Created by admin on 16/4/8.
//  Copyright © 2016年 Sept. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JYLeftCatrogry;

@interface JYAttentionCategoryCell : UITableViewCell

@property (nonatomic, strong) JYLeftCatrogry *categroy;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
