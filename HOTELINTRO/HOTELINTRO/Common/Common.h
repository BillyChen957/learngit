//
//  Common.h
//  HOTELINTRO
//
//  Created by xin on 2017/11/2.
//  Copyright © 2017年 pasaaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#define COM [Common shared]

typedef void(^loginBlock)( BOOL isSuccess);
typedef void(^signupBlock)(BOOL isSuccess);
@interface Common : NSObject
+ (instancetype)shared;

- (void)showMainWindow;
- (void)hiddenShadow;
- (void)showShadow;

- (void)showWebView:(NSString *)path;

- (void)login:(NSString *)userName passWord:(NSString *)passWord complete:(loginBlock)complete;
- (void)signup:(NSString *)userName passWord:(NSString *)passWord complete:(signupBlock)complete;
@end
