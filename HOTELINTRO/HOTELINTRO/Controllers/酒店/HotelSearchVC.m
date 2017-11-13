//
//  HotelSearchVC.m
//  HOTELINTRO
//
//  Created by xin on 2017/11/7.
//  Copyright © 2017年 pasaaa. All rights reserved.
//

#import "HotelSearchVC.h"
#import "NDSearchTool.h"
#import "HotelCell.h"
@interface HotelSearchVC ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,HotelDelegate>
@property (nonatomic, strong) UITextField *searchField;
@property (nonatomic, strong) UIView *searchView;
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) NSArray<HotelDataModel *> *dataArray;
@property (nonatomic, strong) NSArray<HotelDataModel *> *searchResults;
@property (nonatomic, strong) UITableView *tableView;
@end

static NSString *SearchCellID = @"SearchCellID";
@implementation HotelSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.searchResults = @[];
    [self setupUI];
    self.navigationItem.titleView = self.searchView;
    self.view.backgroundColor = [UIColor greenColor];
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:local(@"取消") style:UIBarButtonItemStylePlain target:self action:@selector(dismissSearchVC)];
   
}

- (void)dismissSearchVC{
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HotelCell *cell = [tableView dequeueReusableCellWithIdentifier:SearchCellID forIndexPath:indexPath];
    HotelDataModel *model = self.searchResults[indexPath.row];
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
        hud.label.text = @"请先登录";
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

- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[HotelCell class] forCellReuseIdentifier:SearchCellID];
    }
    
    return _tableView;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    // 搜索
    self.searchResults = [[NDSearchTool tool] searchWithFieldArray:@[@"hotelName"] inputString:textField.text inArray:self.dataArray];
    [self.tableView reloadData];
    return YES;
}

- (void)setupUI{
    [self.searchView addSubview:self.imageV];
    [self.searchView addSubview:self.searchField];
    [self.view addSubview:self.tableView];
}
- (UIView *)searchView{
    if (!_searchView) {
        
        _searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 30)];
        _searchView.backgroundColor = [UIColor whiteColor];
        _searchView.layer.cornerRadius = 4;
        _searchView.layer.masksToBounds = YES;
    }
    return _searchView;
}

- (UIImageView *)imageV{
    if (!_imageV) {
        _imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        _imageV.image = [UIImage imageNamed:@"search"];
    }
    return _imageV;
}


- (UITextField *)searchField{
    if (!_searchField) {
        
        _searchField = [[UITextField alloc]initWithFrame:CGRectMake(30, 0, SCREEN_WIDTH - 130, 30)];
        _searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _searchField.placeholder = local(@"请输入酒店名称");
        _searchField.returnKeyType = UIReturnKeySearch;
        _searchField.layer.cornerRadius = 4;
        _searchField.layer.masksToBounds = YES;
        _searchField.font = [UIFont systemFontOfSize:12];
        _searchField.delegate = self;
        _searchField.tintColor = [UIColor lightGrayColor];
    }
    return _searchField;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.searchField resignFirstResponder];
}

@end
