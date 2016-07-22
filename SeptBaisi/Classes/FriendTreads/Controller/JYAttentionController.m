//
//  JYAttentionController.m
//  SeptBaisi
//
//  Created by admin on 16/4/6.
//  Copyright © 2016年 Sept. All rights reserved.
//

#import "JYAttentionController.h"

#import "JYAttentionCategoryCell.h"
#import "JYRightUsersCell.h"
#import "JYRecommendUsers.h"
#import "JYLeftCatrogry.h"
#import <MJExtension.h>
#import <MJRefresh.h>

@interface JYAttentionController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *leftTabView;
@property (weak, nonatomic) IBOutlet UITableView *rightTableView;

// 左边模型数据
@property (strong, nonatomic) NSArray *leftArr;

// 左边模型数据
@property (strong, nonatomic) NSArray *rightArr;

@property (strong, nonatomic) NSMutableDictionary *pargam;

@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;

@end

@implementation JYAttentionController

static NSString * const JYLeftID = @"left";
static NSString * const JYRightID = @"right";

- (AFHTTPSessionManager *)sessionManager
{
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
    }
    return _sessionManager;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"推荐光注";
    
    self.view.backgroundColor = JYGlobalColor;
    
    [self initTableView];
    
    // 添加上拉刷新
    [self setupFooter];
    
    [self loadLeftData];
    
    
    
}

#pragma 加载右边的数据
- (void)loadLeftData
{
    // 显示指示器
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    NSMutableDictionary *pargam = [NSMutableDictionary dictionary];
    pargam[@"a"] = @"category";
    pargam[@"c"] = @"subscribe";
    
    [self.sessionManager GET:@"http://api.budejie.com/api/api_open.php" parameters:pargam progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        
        self.leftArr = [JYLeftCatrogry mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.leftTabView reloadData];
        
        // 默认选中顶部
        [self.leftTabView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
        [self.rightTableView.mj_header beginRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载请求失败"];
    }];
    
}

#pragma 初始化tableView
- (void)initTableView
{
    [self.leftTabView registerNib:[UINib nibWithNibName:NSStringFromClass([JYAttentionCategoryCell class]) bundle:nil] forCellReuseIdentifier:JYLeftID];
    
    [self.rightTableView registerNib:[UINib nibWithNibName:NSStringFromClass([JYRightUsersCell class]) bundle:nil] forCellReuseIdentifier:JYRightID];
    self.rightTableView.rowHeight = 70;
    
    // 解决tableView与导航栏的问题
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.rightTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.leftTabView.contentInset = self.rightTableView.contentInset;
}

#pragma mark ---  添加下拉/上拉刷新
- (void)setupFooter
{
    self.rightTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsersData)];
    
    self.rightTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUserData)];
    
    self.rightTableView.mj_footer.hidden = YES;
}

- (void)loadNewUsersData
{
    JYLeftCatrogry *leftData = self.leftArr[self.leftTabView.indexPathForSelectedRow.row];
    // 初始化当前页数为1
    leftData.currenyPage = 1;
    
    NSMutableDictionary *pargam = [NSMutableDictionary dictionary];
    pargam[@"a"] = @"list";
    pargam[@"c"] = @"subscribe";
    pargam[@"category_id"] = leftData.id;
    pargam[@"page"] = @(leftData.currenyPage);
    self.pargam = pargam;
    
    [self.sessionManager GET:@"http://api.budejie.com/api/api_open.php" parameters:pargam progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *users = [JYRecommendUsers mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        leftData.total = [responseObject[@"totla"] integerValue];
        
        // 清空之前所有旧数据
        [leftData.users removeAllObjects];
        
        // 加载最新的数据
        [leftData.users addObjectsFromArray:users];
        
        if (self.pargam != pargam) return;
        
        [self.rightTableView reloadData];
        
        // 加载完数据后隐藏下拉刷新
        [self.rightTableView.mj_header endRefreshing];
        
        [self alwaysCheckFooterState:leftData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.pargam != pargam) return;
        
        [SVProgressHUD showErrorWithStatus:@"加载请求失败"];
        [self.rightTableView.mj_header endRefreshing];
    }];
}

#pragma mark ---- 时刻检测footer的状态
- (void)alwaysCheckFooterState:(JYLeftCatrogry *)leftCategory
{
    // 判断是否全部加载完所有数据
    if (leftCategory.total == leftCategory.users.count) {   // 全部加载完
        [self.rightTableView.mj_footer endRefreshingWithNoMoreData];
    } else {
        [self.rightTableView.mj_footer endRefreshing];
    }
}

#pragma mark ---- 加载更多数据
- (void)loadMoreUserData
{
    JYLeftCatrogry *seleData = self.leftArr[self.leftTabView.indexPathForSelectedRow.row];
    
    NSMutableDictionary *pargam = [NSMutableDictionary dictionary];
    pargam[@"a"] = @"list";
    pargam[@"c"] = @"subscribe";
    pargam[@"category_id"] = seleData.id;
    pargam[@"page"] = @(++seleData.currenyPage);
    self.pargam = pargam;
    
    [self.sessionManager GET:@"http://api.budejie.com/api/api_open.php" parameters:pargam progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        
        NSArray *users = [JYRecommendUsers mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [seleData.users addObjectsFromArray:users];
        
        // 不是最后一次数据就别刷新
        if (self.pargam != pargam) return;
        
        [self.rightTableView reloadData];
        
        // 数据加载完停止上拉加载的动画
        [self.rightTableView.mj_footer endRefreshing];
        
        [self alwaysCheckFooterState:seleData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载请求失败"];
        [self.rightTableView.mj_footer endRefreshing];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.leftTabView) {
        return self.leftArr.count;
    } else {
        JYLeftCatrogry *user = self.leftArr[self.leftTabView.indexPathForSelectedRow.row];
        
        self.rightTableView.mj_footer.hidden = (user.count == 0);
        
        [self alwaysCheckFooterState:user];
        
        return user.users.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTabView) {
        JYAttentionCategoryCell *cell = [JYAttentionCategoryCell cellWithTableView:tableView];
        cell.categroy = self.leftArr[indexPath.row];
        
        return cell;
        
    } else
    {
        JYRightUsersCell *cell = [JYRightUsersCell cellWithTableView:tableView];
        
        JYLeftCatrogry *user = self.leftArr[self.leftTabView.indexPathForSelectedRow.row];
        
        cell.users = user.users[indexPath.row];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 结束刷新
    [self.rightTableView.mj_header endRefreshing];
    [self.rightTableView.mj_footer endRefreshing];
    
    JYLeftCatrogry *leftData = self.leftArr[indexPath.row];
    
    if (leftData.users.count) {
        [self.rightTableView reloadData];
    } else {
        
        // 避免在网络差的时候数据加载慢而没有及时刷新新数据
        [self.rightTableView reloadData];
        
        // 进入下拉刷新状态
        [self.rightTableView.mj_header beginRefreshing];
    }
}

- (void)dealloc
{
    // 当控制器销毁了 停止所有正在请求的操作
    [self.sessionManager.operationQueue cancelAllOperations];
}

@end
