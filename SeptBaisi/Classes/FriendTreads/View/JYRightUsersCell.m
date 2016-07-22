//
//  JYRightUsersCell.m
//  SeptBaisi
//
//  Created by admin on 16/6/26.
//  Copyright © 2016年 Sept. All rights reserved.
//

// 推荐用户的自定义cell

#import "JYRightUsersCell.h"
#import "JYRecommendUsers.h"

@interface JYRightUsersCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenName;

@property (weak, nonatomic) IBOutlet UILabel *fansCount;

@end

@implementation JYRightUsersCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"right";
    JYRightUsersCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setUsers:(JYRecommendUsers *)users
{
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:users.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.screenName.text = users.screen_name;
    
    NSString *fansCount = nil;
    if (users.fans_count >= 10000) {
        fansCount = [NSString stringWithFormat:@"%.1f万关注", users.fans_count / 10000.0];
    } else {
        fansCount = [NSString stringWithFormat:@"%ld人关注", (long)users.fans_count];
    }
    
    self.fansCount.text = fansCount;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
