//
//  JYRecommendUsers.h
//  SeptBaisi
//
//  Created by admin on 16/6/26.
//  Copyright © 2016年 Sept. All rights reserved.
//

// 推荐用户的信息 模型

#import <Foundation/Foundation.h>

@interface JYRecommendUsers : NSObject

/**  粉丝人数 */
@property (nonatomic, assign) NSInteger fans_count;

/**  用户头像 */
@property (nonatomic, copy) NSString *header;

/** 用户昵称 */
@property (nonatomic, copy) NSString *screen_name;

@end
