//
//  MyCollectionVC.m
//  HOTELINTRO
//
//  Created by xin on 2017/11/8.
//  Copyright © 2017年 pasaaa. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "MyCollectionVC.h"
#import "NDSearchTool.h"
#import "HotelCell.h"
@interface MyCollectionVC ()<UITableViewDelegate,UITableViewDataSource,HotelDelegate>
@property (nonatomic, strong) NSArray<HotelDataModel *> *dataArray;
@property (nonatomic, strong) NSMutableArray<HotelDataModel *> *collectionDatas;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *noData;
@property (nonatomic, strong) UILabel *noLogin;
@end
static NSString *CollectionCellID = @"collectionCellID";
@implementation MyCollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = local(@"我的收藏");
    self.collectionDatas = [NSMutableArray array];
    [self.view addSubview:self.tableView];
    [self checkLogin];
   
    
    [kNotificationCenter addObserver:self selector:@selector(removeNoLogin) name:kLoginSucess object:nil];
    [kNotificationCenter addObserver:self selector:@selector(showNoLogin) name:kLogoutNoti object:nil];
    [kNotificationCenter addObserver:self selector:@selector(reflesh) name:kNewCollectNoti object:nil];
}
- (void)dealloc{
    [kNotificationCenter removeObserver:self];
}


- (void)loadData{
    
    // 查询多条数据
    __weak MyCollectionVC *weakSelf = self;
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"Hotel"];
//    [self hideNoData];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        NSMutableArray *datas = [NSMutableArray array];
//        [weakSelf.tableView.mj_header endRefreshing];
        if (array.count > 0) {
            for (BmobObject *obj in array) {
                HotelDataModel *model = [[HotelDataModel alloc]init];
                model.imageUrl = [obj objectForKey:@"imageUrl"];
                model.hotelName = [obj objectForKey:@"hotelName"];
                model.hotelsize = [obj objectForKey:@"hotelsize"];
                model.satisrate = [obj objectForKey:@"satisrate"];
                model.intime = [obj objectForKey:@"intime"];
                model.outtime = [obj objectForKey:@"outtime"];
                model.telephone = [obj objectForKey:@"telephone"];
                [datas addObject:model];
                
            }
            
            weakSelf.dataArray = datas;
            [weakSelf reflesh];
//            [weakSelf.tableView reloadData];
        }else{
            
//            if (weakSelf.dataArray.count == 0) {
//                [weakSelf showNoData];
//            }
            
        }
        
    }];
}
- (void)reflesh{
    NSString *collectKey = [NSString stringWithFormat:@"%@%@",kCollectionArrayKey,[kUserDefault objectForKey:kUserNameKey]];
    NSMutableArray *collects = [NSMutableArray arrayWithArray:[kUserDefault objectForKey:collectKey]];
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *hotelName in collects) {
        for (HotelDataModel *model in self.dataArray) {
            
            if ([model.hotelName isEqualToString:hotelName]) {
                [array addObject:model];
            }
        }
        
    }
    self.collectionDatas = array;
    
    if (array.count <=0 ) {
        [self  showNoData];
    }else{
        [self removeNoData];
    }
    [self.tableView reloadData];
}
- (void)checkLogin{
    
    NSString *userName = [kUserDefault stringForKey:kUserNameKey];
    if (NULLString(userName)) {
        
        [self showNoLogin];
    }else{
        [self removeNoLogin];
         [self loadData];
    }
    
    
}


- (void)showNoData{
    [self.view addSubview:self.noData];
    [self.noData mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.view);
    }];
}

- (void)removeNoData{
    [self.noData removeFromSuperview];
    
}
- (void)showNoLogin{
    [self.view addSubview:self.noLogin];
    [self.noLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.equalTo(self.view);
        make.width.equalTo(@(SCREEN_WIDTH - 80));
    }];
    self.collectionDatas = [NSMutableArray array];
    [self removeNoData];
    [self.tableView reloadData];
   
}
- (void)removeNoLogin{
    [self loadData];
    [self.noLogin removeFromSuperview];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.collectionDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HotelCell *cell = [tableView dequeueReusableCellWithIdentifier:CollectionCellID forIndexPath:indexPath];
    HotelDataModel *model = self.collectionDatas[indexPath.row];
    cell.delegate = self;
    cell.isCollectionCell = YES;
    cell.model = model;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 200;
}

- (void)hotelCellCallNumber:(HotelDataModel *)model{
    
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@",model.telephone];
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
    
}

- (void)hotelCellCollectModels:(HotelDataModel *)model{
    NSString *collectKey = [NSString stringWithFormat:@"%@%@",kCollectionArrayKey,[kUserDefault objectForKey:kUserNameKey]];
    NSMutableArray *collects = [NSMutableArray arrayWithArray:[kUserDefault objectForKey:collectKey]];
    [collects removeObject:model.hotelName];
    [kUserDefault setObject:[NSArray arrayWithArray:collects] forKey:collectKey];
    [kUserDefault synchronize];
    [self.collectionDatas removeObject:model];
    if (self.collectionDatas.count == 0) {
        [self showNoData];
    }
    [self.tableView reloadData];
}
- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[HotelCell class] forCellReuseIdentifier:CollectionCellID];
    }
    
    return _tableView;
}

- (UILabel *)noData{
    if (!_noData) {
        _noData = [[UILabel alloc]init];
        _noData.textColor = SCRGBAColor(0, 0, 0, 0.6);
        _noData.font = AdaptedFontSize(16);
        _noData.text = local(@"暂无收藏记录");
        
    }
    return _noData;
}

- (UILabel *)noLogin{
    if (!_noLogin) {
        _noLogin = [[UILabel alloc]init];
        _noLogin.textColor = SCRGBAColor(0, 0, 0, 0.6);
        _noLogin.font = AdaptedFontSize(16);
        _noLogin.text = local(@"请您先登录,再查看收藏记录~");
        _noLogin.numberOfLines = 0;
        _noLogin.textAlignment = NSTextAlignmentCenter;
    }
    return _noLogin;
}

@end
