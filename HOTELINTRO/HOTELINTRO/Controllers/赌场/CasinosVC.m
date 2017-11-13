//
//  CasinosVC
//  HOTELINTRO
//
//  Created by xin on 2017/11/2.
//  Copyright © 2017年 pasaaa. All rights reserved.
//

#import "CasinosVC.h"
#import "CasinosCell.h"
#import <BmobSDK/Bmob.h>
#import "MJRefresh.h"
#import "CasinoDetailVC.h"
@interface CasinosVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<CasinosModel *> *dataArray;
@property (nonatomic, strong) UILabel *noDataLabel;
@end
static NSString *CasinosCellID = @"CasinosCellID";
@implementation CasinosVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = local(@"赌场介绍");
    self.view.backgroundColor = SCHEXCOLOR(0xffffff);
    self.dataArray = [NSMutableArray array];
    [self setupTableView];
   
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [self.tableView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    self.tabBarController.tabBar.hidden = NO;
//}

- (void)loadData{
    
    // 查询多条数据
    __weak CasinosVC *weakSelf = self;
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"Casinos"];
    [self hideNoData];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        NSMutableArray *datas = [NSMutableArray array];
        [weakSelf.tableView.mj_header endRefreshing];
        if (array.count > 0) {
            for (BmobObject *obj in array) {
                CasinosModel *model = [[CasinosModel alloc]init];
                model.imageurl = [obj objectForKey:@"imageurl"];
                model.name = [obj objectForKey:@"name"];
                model.address = [obj objectForKey:@"address"];
                model.phoneNum = [obj objectForKey:@"phoneNum"];
                model.deskStr = [obj objectForKey:@"deskStr"];
                model.macStr = [obj objectForKey:@"macStr"];
                model.betlowStr = [obj objectForKey:@"betlowStr"];
                model.memberStr = [obj objectForKey:@"memberStr"];
                model.descStr = [obj objectForKey:@"descStr"];
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
    
    CasinosCell *cell = [tableView dequeueReusableCellWithIdentifier:CasinosCellID forIndexPath:indexPath];
    CasinosModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return AdaptedHeight(280);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CasinosModel *model = self.dataArray[indexPath.row];
    CasinoDetailVC *detail = [[CasinoDetailVC alloc]init];
    [detail setValue:model forKey:@"model"];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    
}

- (void)setupTableView{
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT- 64 -49)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[CasinosCell class] forCellReuseIdentifier:CasinosCellID];
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
