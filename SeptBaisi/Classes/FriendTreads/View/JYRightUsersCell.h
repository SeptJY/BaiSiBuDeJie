//
//  JYRightUsersCell.h
//  SeptBaisi
//
//  Created by admin on 16/6/26.
//  Copyright © 2016年 Sept. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JYRecommendUsers;

@interface JYRightUsersCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) JYRecommendUsers *users;

@end


