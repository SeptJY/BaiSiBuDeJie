//
//  JYLeftCatrogry.h
//  SeptBaisi
//
//  Created by admin on 16/4/8.
//  Copyright © 2016年 Sept. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYLeftCatrogry : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSString *id;

@property (nonatomic, assign) int count;


/** 存储第一次请求的数据，避免重复请求网络数据 */
@property (strong, nonatomic) NSMutableArray *users;

/** 当前页数 */
@property (nonatomic, assign) NSInteger currenyPage;

/** 总页数 */
@property (nonatomic, assign) NSInteger total;

@end
