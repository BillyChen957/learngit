//
//  AppDelegate.m
//  HOTELINTRO
//
//  Created by xin on 2017/11/2.
//  Copyright © 2017年 pasaaa. All rights reserved.
//

#import "AppDelegate.h"
#import "Common.h"

//#import "PSDrawerManager.h"
//#import "TabBarVC.h"
//#import "LeftView.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    [self initStyle];
    [COM showMainWindow];
    
    
    
    
//    LeftView *leftView = [[LeftView alloc] initWithFrame:CGRectMake(-self.window.bounds.size.width * (1 - 0.75), 0, self.window.bounds.size.width, self.window.bounds.size.height)];
//
//    TabBarVC *tabBarVC = [[TabBarVC alloc] init];
//
//    [[PSDrawerManager instance] installCenterViewController:tabBarVC leftView:leftView];
//
//    [self.window makeKeyAndVisible];
    
    [Bmob registerWithAppKey:@"00a16854c521d38e625deb38d54ca6fc"];
//    [self.window makeKeyAndVisible];
    // Override point for customization after application launch.
    return YES;
}




/// 初始化样式
- (void)initStyle {
    
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    [UINavigationBar appearance].translucent = NO;
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:19], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIImage *image = [UIImage imageWithColor:appThemeColor];
    [[UINavigationBar appearance] setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:image];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]} forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:appThemeColor} forState:UIControlStateSelected];
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
