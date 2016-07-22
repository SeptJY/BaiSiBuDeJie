//
//  JYAttentionCategoryCell.m
//  SeptBaisi
//
//  Created by admin on 16/4/8.
//  Copyright © 2016年 Sept. All rights reserved.
//

#import "JYAttentionCategoryCell.h"

#import "JYLeftCatrogry.h"

@interface JYAttentionCategoryCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIView *redView;
@end

@implementation JYAttentionCategoryCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"left";
    JYAttentionCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)awakeFromNib {
    // Initialization code
    self.titleLabel.highlightedTextColor = JYColor(219, 21, 26);
    self.backgroundColor = JYColor(244, 244, 244);
    
    self.textLabel.font = [UIFont systemFontOfSize:15];
}

- (void)setCategroy:(JYLeftCatrogry *)categroy
{
    _categroy = categroy;
    
    self.titleLabel.text = categroy.name;
//    NSLog(@"%@", categroy.name);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    self.redView.hidden = !selected;
    
    self.titleLabel.textColor = selected ? JYColor(192, 62, 66) : [UIColor darkGrayColor];
}

@end
