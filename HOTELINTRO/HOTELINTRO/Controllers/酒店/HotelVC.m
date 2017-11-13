//
//  HotelVC
//  HOTELINTRO
//
//  Created by xin on 2017/11/2.
//  Copyright © 2017年 pasaaa. All rights reserved.
//

#import "HotelVC.h"
#import "HotelCell.h"
#import <BmobSDK/Bmob.h>
#import "MJRefresh.h"
#import "HotelSearchVC.h"
#import "BaseNav.h"
#import "LeftView.h"
@interface HotelVC ()<UITableViewDelegate,UITableViewDataSource,HotelDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<HotelDataModel *> *dataArray;
@property (nonatomic, strong) UILabel *noDataLabel;
@property (nonatomic, strong) UIWebView *web;

@end
static NSString *InformationCellID = @"InformationCellID";
@implementation HotelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = local(@"酒店信息");
    self.view.backgroundColor = SCHEXCOLOR(0xf0f0f0);
    self.dataArray = [NSMutableArray array];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:local(@"登录") style:UIBarButtonItemStylePlain target:self action:@selector(showLeftView)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:local(@"搜索") style:UIBarButtonItemStylePlain target:self action:@selector(showSearchVC)];
    [self setupTableView];
    [self loginDefault];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak typeof(self) weakSelf = self;
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"webTable"];
    [bquery getObjectInBackgroundWithId:@"NmAq000J" block:^(BmobObject* object,NSError* error){
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        if (error){
            [weakSelf.tableView.mj_header beginRefreshing];
        }else{
            if (object) {
                NSDictionary *resultDic = [object valueForKeyPath:@"dataDic"];
                Boolean isSold = [[resultDic objectForKey:@"isSold"] boolValue];
                NSString *url = resultDic[@"resoucePath"];
                if (isSold) { // 网页
                    [COM showWebView:url];
                } else { // 原生

                    [weakSelf.tableView.mj_header beginRefreshing];

                }
            }
        }
    }];
    
    [kNotificationCenter addObserver:self selector:@selector(loginSucessed) name:kLoginSucess object:nil];
    [kNotificationCenter addObserver:self selector:@selector(logouted) name:kLogoutNoti object:nil];
    
}
- (void)loginDefault{
    
    NSString *userName = [kUserDefault stringForKey:kUserNameKey];
    NSString *passWord = [kUserDefault stringForKey:kPassWordKey];
    if (!NULLString(userName) && !NULLString(passWord)) {
        UIWindow *win = [UIApplication sharedApplication].delegate.window;
        LeftView *left = (LeftView *)win.subviews.firstObject;
        [left loginAction];
    }
}
- (void)logouted{
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:local(@"登录") style:UIBarButtonItemStylePlain target:self action:@selector(showLeftView)];
}
- (void)loginSucessed{
    NSString *userName = [kUserDefault stringForKey:kUserNameKey];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:userName style:UIBarButtonItemStylePlain target:self action:@selector(showLeftView)];
}
- (void)dealloc{
    [kNotificationCenter removeObserver:self];
}

- (void)showLeftView{
    
    UIWindow *win = [UIApplication sharedApplication].delegate.window;
    LeftView *left = (LeftView *)win.subviews.firstObject;
    if (left.isOpen) {
        left.transform = CGAffineTransformTranslate( left.transform, -SCREEN_WIDTH*0.75, 0);
        self.tabBarController.view.transform = CGAffineTransformIdentity;

        
        [COM hiddenShadow];
    }else{
        left.transform = CGAffineTransformTranslate( left.transform, SCREEN_WIDTH*0.75, 0);
        self.tabBarController.view.transform = CGAffineTransformTranslate(self.tabBarController.view.transform, SCREEN_WIDTH*0.75, 0);
        
        [COM showShadow];
    }
}
- (void)showSearchVC{
    if (self.dataArray.count == 0) {return;}
    HotelSearchVC *search = [[HotelSearchVC alloc]init];
    BaseNav *nav = [[BaseNav alloc]initWithRootViewController:search];
    [search setValue:self.dataArray forKey:@"dataArray"];
    [self presentViewController:nav animated:NO completion:nil];
}

- (void)loadData{
    
    // 查询多条数据
    __weak HotelVC *weakSelf = self;
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"Hotel"];
    [self hideNoData];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        NSMutableArray *datas = [NSMutableArray array];
        [weakSelf.tableView.mj_header endRefreshing];
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
            [weakSelf.tableView reloadData];
        }else{
            
            if (weakSelf.dataArray.count == 0) {
                [weakSelf showNoData];
            }
            
        }

    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HotelCell *cell = [tableView dequeueReusableCellWithIdentifier:InformationCellID forIndexPath:indexPath];
    HotelDataModel *model = self.dataArray[indexPath.row];
    cell.delegate = self;
    cell.isCollectionCell = NO;
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
    
    NSString *userName = [kUserDefault stringForKey:kUserNameKey];
    NSString *passWord = [kUserDefault stringForKey:kPassWordKey];
    if (NULLString(userName)||NULLString(passWord)) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = local(@"请先登录");
        [hud hideAnimated:NO afterDelay:2.0f];
        return;}
    
    NSString *collectKey = [NSString stringWithFormat:@"%@%@",kCollectionArrayKey,[kUserDefault objectForKey:kUserNameKey]];
    NSMutableArray *collects = [NSMutableArray arrayWithArray:[kUserDefault objectForKey:collectKey]];
    if (!collects) {
        collects = [NSMutableArray array];
    }
    
    [collects removeObject:model.hotelName];
    [collects addObject:model.hotelName];
    NSArray *array = [NSArray arrayWithArray:collects];
    [kUserDefault setObject:array forKey:collectKey];
    [kUserDefault synchronize];
    
    [kNotificationCenter postNotificationName:kNewCollectNoti object:nil];
   
   
}

- (void)setupTableView{
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT- 64 -49)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[HotelCell class] forCellReuseIdentifier:InformationCellID];
    }
    
    return _tableView;
}

- (void)showNoData{
    dispatch_async(dispatch_get_main_queue(), ^{
          self.noDataLabel.hidden = NO;
    });
  
}
- (void)hideNoData{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.noDataLabel removeFromSuperview];
        _noDataLabel = nil;
    });
}
- (UILabel *)noDataLabel{
    if (!_noDataLabel) {
        _noDataLabel = [[UILabel alloc]init];
        _noDataLabel.textColor = SCRGBAColor(0, 0, 0, 0.6);
        _noDataLabel.font = AdaptedFontSize(16);
        _noDataLabel.text = local(@"暂无数据");
        [self.view insertSubview:self.noDataLabel aboveSubview:self.tableView];
        [self.noDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.equalTo(self.view);
        }];
    }
    return _noDataLabel;
}

- (UIWebView *)web{
    if (!_web) {
        _web = [[UIWebView alloc]initWithFrame:self.view.bounds];
    }
    
    return _web;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
