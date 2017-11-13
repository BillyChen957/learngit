//
//  LeftView.m
//  HOTELINTRO
//
//  Created by xin on 2017/11/8.
//  Copyright © 2017年 pasaaa. All rights reserved.
//

#import "LeftView.h"
@interface LeftView ()

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UITextField *accountTF;
@property (nonatomic, strong) UITextField *passwordTF;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *logoutBtn;
@property (nonatomic, strong) UIButton *signupBtn;
@end
@implementation LeftView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.imageV];
        [self addSubview:self.accountTF];
        [self addSubview:self.passwordTF];
        [self addSubview:self.loginBtn];
        [self addSubview:self.logoutBtn];
        [self addSubview:self.signupBtn];
        
        //
        NSString *userName = [kUserDefault stringForKey:kUserNameKey];
        NSString *passWord = [kUserDefault stringForKey:kPassWordKey];
        if (!NULLString(userName) && !NULLString(passWord)) {
            self.accountTF.text = userName;
            self.passwordTF.text = passWord;
        }
        _isOpen = NO;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@80);
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(-120);
    }];
    
    [self.accountTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.height.equalTo(@30);
        make.width.equalTo(@(SCREEN_WIDTH*0.75 - 40));
        make.top.equalTo(self.imageV.mas_bottom).offset(10);
    }];
    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.height.width.equalTo(self.accountTF);
        make.top.equalTo(self.accountTF.mas_bottom).offset(10);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTF.mas_bottom).offset(15);
        make.width.equalTo(self.passwordTF);
        make.height.equalTo(@30);
        make.centerX.equalTo(self);
    }];
    [self.signupBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginBtn.mas_bottom).offset(10);
        make.width.equalTo(self.passwordTF);
        make.height.equalTo(@30);
        make.centerX.equalTo(self);
    }];
    [self.logoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageV.mas_bottom).offset(10);
        make.width.equalTo(self.passwordTF);
        make.height.equalTo(@30);
        make.centerX.equalTo(self);
    }];
}
- (UIButton *)logoutBtn{
    if (!_logoutBtn) {
        
        _logoutBtn = [[UIButton alloc]init];
        [_logoutBtn setTitle:local(@"退出") forState:UIControlStateNormal];
        [_logoutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _logoutBtn.titleLabel.font = AdaptedFontSize(14);
        _logoutBtn.layer.cornerRadius = 4;
        _logoutBtn.layer.masksToBounds = YES;
        _logoutBtn.hidden = YES;
        [_logoutBtn setBackgroundImage:[UIImage imageWithColor:appThemeColor] forState:UIControlStateNormal];
        [_logoutBtn addTarget:self action:@selector(logoutAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _logoutBtn;
}
- (UIButton *)signupBtn{
    if (!_signupBtn) {
        _signupBtn = [[UIButton alloc]init];
        [_signupBtn setTitle:local(@"注册") forState:UIControlStateNormal];
        [_signupBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _signupBtn.titleLabel.font = AdaptedFontSize(14);
        _signupBtn.layer.cornerRadius = 4;
        _signupBtn.layer.masksToBounds = YES;
        [_signupBtn setBackgroundImage:[UIImage imageWithColor:appThemeColor] forState:UIControlStateNormal];
        [_signupBtn addTarget:self action:@selector(signupAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _signupBtn;
}
- (UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc]init];
        
        [_loginBtn setTitle:local(@"登录") forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = AdaptedFontSize(14);
        _loginBtn.layer.cornerRadius = 4;
        _loginBtn.layer.masksToBounds = YES;
        [_loginBtn setBackgroundImage:[UIImage imageWithColor:appThemeColor] forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _loginBtn;
}
- (UITextField *)accountTF{
    if (!_accountTF) {
        _accountTF = [[UITextField alloc]init];
        _accountTF.leftViewMode = UITextFieldViewModeAlways;
        UIImageView *imagev = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"acc"]];
        imagev.contentMode = UIViewContentModeLeft;
        _accountTF.leftView = imagev;
        _accountTF.layer.cornerRadius = 4;
        _accountTF.layer.masksToBounds = YES;
        _accountTF.layer.borderColor = SCHEXCOLOR(0xe5e5e5).CGColor;
        _accountTF.layer.borderWidth = 1;
    }
    return _accountTF;
}
- (UITextField *)passwordTF{
    if (!_passwordTF) {
        _passwordTF = [[UITextField alloc]init];
        _passwordTF.leftViewMode = UITextFieldViewModeAlways;
        UIImageView *imagev = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pwd"]];
        imagev.contentMode = UIViewContentModeLeft;
        _passwordTF.leftView = imagev;
        _passwordTF.layer.cornerRadius = 4;
        _passwordTF.layer.masksToBounds = YES;
        _passwordTF.layer.borderColor = SCHEXCOLOR(0xe5e5e5).CGColor;
        _passwordTF.layer.borderWidth = 1;
        _passwordTF.secureTextEntry = YES;
    }
    
    return _passwordTF;
}
- (UIImageView *)imageV{
    if (!_imageV) {
        _imageV = [[UIImageView alloc]init];
        _imageV.layer.cornerRadius = 40;
        _imageV.layer.masksToBounds = YES;
        _imageV.contentMode = UIViewContentModeScaleAspectFill;
        _imageV.image = [UIImage imageNamed:@"header"];
    }
    return _imageV;
}
- (void)logoutAction{
    
    [kUserDefault removeObjectForKey:@"userName"];
    [kUserDefault removeObjectForKey:@"passWord"];
    [kUserDefault synchronize];
    [self showLogin];
    [kNotificationCenter postNotificationName:kLogoutNoti object:nil];
}

- (void)showLogin{
    self.passwordTF.hidden = NO;
    self.accountTF.hidden = NO;
    self.loginBtn.hidden = NO;
    self.signupBtn.hidden = NO;
    self.logoutBtn.hidden = YES;
}
- (void)hideLogin{
    self.passwordTF.hidden = YES;
    self.accountTF.hidden = YES;
    self.signupBtn.hidden = YES;
    self.loginBtn.hidden = YES;
    self.logoutBtn.hidden = NO;
}

- (void)loginAction{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.removeFromSuperViewOnHide = YES;
    [COM login:self.accountTF.text passWord:self.passwordTF.text complete:^(BOOL isSuccess) {
        if (isSuccess) {
            hud.label.text = local(@"登录成功");
            [self hideLogin];
            [kNotificationCenter postNotificationName:kLoginSucess object:nil];
        }else{
            hud.label.text = local(@"登录失败");
            [self showLogin];
        }
        
        [hud hideAnimated:YES afterDelay:3];
    }];
    
}
- (void)signupAction{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.removeFromSuperViewOnHide = YES;
    [COM signup:self.accountTF.text passWord:self.passwordTF.text complete:^(BOOL isSuccess) {
        if (isSuccess) {
            hud.label.text = local(@"注册成功");
            self.signupBtn.hidden = YES;
        }else{
            hud.label.text = local(@"注册失败");
             self.signupBtn.hidden = NO;
        }
        
        [hud hideAnimated:YES afterDelay:3];
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.accountTF resignFirstResponder];
    [self.passwordTF resignFirstResponder];
    
    
}
@end
