//
//  Common.m
//  HOTELINTRO
//
//  Created by xin on 2017/11/2.
//  Copyright © 2017年 pasaaa. All rights reserved.
//

#import "Common.h"
#import "CasinosVC.h"
#import "HotelVC.h"
#import "MyCollectionVC.h"
#import "BaseNav.h"
#import "LeftView.h"
@interface Common()<UITabBarControllerDelegate>
@property (nonatomic, strong) LeftView *leftView;
@property (nonatomic, strong) UIPanGestureRecognizer *pan;
@property (nonatomic, strong) UITabBarController *tabBarVC;
@end

@implementation Common
static Common *instance = nil;
+ (instancetype)shared{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[Common alloc]init];
    });
    
    return instance;
}

#pragma mark - showMain

- (void)showMainWindow{
    
    
    UIWindow *window =  [UIApplication sharedApplication].delegate.window;
   
    UIImage *inNorImage = [[UIImage imageNamed:@"hotelNor"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *inPreImage = [[UIImage imageNamed:@"hotelPre"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    HotelVC *invc = [[HotelVC alloc]init];
    invc.tabBarItem = [[UITabBarItem alloc]initWithTitle:local(@"酒店信息") image:inNorImage selectedImage:inPreImage];
    BaseNav *nav = [[BaseNav alloc]initWithRootViewController:invc];
    
    UIImage *playNorImage = [[UIImage imageNamed:@"casinoNor"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *playPreImage = [[UIImage imageNamed:@"casinoPre"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    CasinosVC *hovc = [[CasinosVC alloc]init];
    hovc.tabBarItem = [[UITabBarItem alloc]initWithTitle:local(@"赌场介绍") image:playNorImage selectedImage:playPreImage];
    BaseNav *nav1 = [[BaseNav alloc]initWithRootViewController:hovc];
    
    UIImage *collectNorImage = [[UIImage imageNamed:@"collectionNor"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *collectPreImaage = [[UIImage imageNamed:@"collectionPre"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    MyCollectionVC *collectVC = [[MyCollectionVC alloc]init];
    collectVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:local(@"我的收藏") image:collectNorImage selectedImage:collectPreImaage];
    BaseNav *nav2 = [[BaseNav alloc]initWithRootViewController:collectVC];
    
    
    self.tabBarVC.viewControllers = @[nav,nav1,nav2];
    window.rootViewController = self.tabBarVC;
    window.backgroundColor = [UIColor whiteColor];
    [self.tabBarVC.view addGestureRecognizer:self.pan];
    [window addSubview:self.leftView];
    [window makeKeyAndVisible];
    
}
- (UIPanGestureRecognizer *)pan {
    if (!_pan) {
        _pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanAction:)];
    }
    return _pan;
}


- (void)beginDragResponse {
    if (!self.tabBarVC.view) { return; }
    [self.tabBarVC.view addGestureRecognizer:self.pan];
}

- (void)cancelDragResponse {
    if (!self.tabBarVC.view) { return; }
    [self.tabBarVC.view removeGestureRecognizer:self.pan];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        
        UINavigationController *navigationController = (UINavigationController *)viewController;
        UIViewController *_viewController = navigationController.viewControllers.firstObject;
        
        // 如果选中消息页，响应拖拽手势，可以显示侧边栏
        // 否则取消手势响应，不能显示侧边栏
        if ([_viewController isKindOfClass:[HotelVC class]]) {
            [self beginDragResponse];
        } else {
            [self cancelDragResponse];
        }
    }
}
- (void)hiddenShadow {
    if (!self.tabBarVC.view) { return; }
    self.tabBarVC.view.layer.shadowColor = [UIColor whiteColor].CGColor;
    self.tabBarVC.view.layer.shadowOffset = CGSizeMake(0, 0);
    self.tabBarVC.view.layer.shadowOpacity = 0;
    self.tabBarVC.view.layer.shadowRadius = 0;
    self.leftView.isOpen = NO;
}

- (void)showShadow {
    if (!self.tabBarVC.view) { return; }
    self.tabBarVC.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.tabBarVC.view.layer.shadowOffset = CGSizeMake(6, 6);
    self.tabBarVC.view.layer.shadowOpacity = 0.7;
    self.tabBarVC.view.layer.shadowRadius = 6.f;
    self.leftView.isOpen = YES;
}

- (UITabBarController *)tabBarVC{
    if (!_tabBarVC) {
        _tabBarVC = [[UITabBarController alloc]init];
        _tabBarVC.delegate = self;    }
    return _tabBarVC;
}
- (LeftView *)leftView{
    if (!_leftView) {
        _leftView = [[LeftView alloc]initWithFrame:CGRectMake(-SCREEN_WIDTH*0.75, 0, SCREEN_WIDTH*0.75, SCREEN_HEIGHT)];
        _leftView.backgroundColor = [UIColor whiteColor];
    }
    
    return _leftView;
}
- (void)handlePanAction:(UIPanGestureRecognizer *)sender {
   
    // 1. 获取手指拖拽的时候，平移的值
    CGPoint translation = [sender translationInView:sender.view];
    
    // 2. 让当前视图进行平移
    sender.view.transform = CGAffineTransformTranslate(sender.view.transform, translation.x, 0);
    [kAppDelegate window].subviews.firstObject.tx = sender.view.tx ;
    // 3. 让平移的值不要累加
    [sender setTranslation:CGPointZero inView:sender.view];
    // 4. 获取最右边的范围
    CGAffineTransform rightScopeTransform = CGAffineTransformTranslate([kAppDelegate window].transform, SCREEN_WIDTH * 0.75, 0);
    
    if (sender.view.tx > rightScopeTransform.tx) {
        // 当移动到右边极限时
        // 限制最右边的范围
        sender.view.transform = rightScopeTransform;
        [kAppDelegate window].subviews.firstObject.tx = sender.view.tx ;
        
    } else if (sender.view.tx < 0.0) {
        // 限制最左边的范围
        sender.view.transform = CGAffineTransformTranslate([kAppDelegate window].transform, 0, 0);
        [kAppDelegate window].subviews.firstObject.tx = sender.view.tx ;

    }
    
    // 拖拽结束时
    if (sender.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.2f animations:^{
            if (sender.view.left > SCREEN_WIDTH * 0.5) {
                sender.view.transform = rightScopeTransform;
                [kAppDelegate window].subviews.firstObject.tx = sender.view.tx ;
                self.leftView.isOpen = YES;
                [self showShadow];
            } else {
                sender.view.transform = CGAffineTransformIdentity;
                [kAppDelegate window].subviews.firstObject.tx = sender.view.tx ;
                self.leftView.isOpen = NO;
                [self hiddenShadow];
            }
        }];
    }
}

#pragma mark - showWeb
// 网页
- (void)showWebView:(NSString *)path{
    UIWindow *window =  [UIApplication sharedApplication].delegate.window;
    UIViewController *vc = [[UIViewController alloc]init];
    UIWebView *web = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [vc.view addSubview:web];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:path]];
    [web loadRequest:request];
    window.rootViewController = vc;
    [window makeKeyAndVisible];
}

#pragma mark - login/signup
- (void)login:(NSString *)userName passWord:(NSString *)passWord complete:(loginBlock)complete{
    
    [BmobUser loginWithUsernameInBackground:userName password:passWord block:^(BmobUser *user, NSError *error) {
        if (user) {
            [kUserDefault setObject:userName forKey:kUserNameKey];
            [kUserDefault setObject:passWord forKey:kPassWordKey];
            [kUserDefault synchronize];
            
            complete(YES);
        }else{
            complete(NO);
        }
    }];
    
}
- (void)signup:(NSString *)userName passWord:(NSString *)passWord complete:(signupBlock)complete{
    BmobUser *bUser = [[BmobUser alloc] init];
    [bUser setUsername:userName];
    [bUser setPassword:passWord];
    [bUser signUpInBackgroundWithBlock:^ (BOOL isSuccessful, NSError *error){
        if (isSuccessful){
            complete(YES);
        } else {
            complete(NO);
        }
    }];
    
    
}
@end
