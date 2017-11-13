//
//  Macros.h
//  HOTELINTRO
//
//  Created by xin on 2017/11/3.
//  Copyright © 2017年 pasaaa. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

#import "NotificationMacro.h"
#import "UserDefaultMacro.h"
#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
//中文字体
#define CHINESE_FONT_NAME  @"Helvetica"
#define Helvetica_FONT_NAME @"Helvetica"
#define CHINESE_SYSTEM(x) [UIFont fontWithName:CHINESE_FONT_NAME size:x]
#define Helvetica_SYSTEM(x) [UIFont fontWithName:Helvetica_FONT_NAME size:x]

//不同屏幕尺寸字体适配（375，667是因为效果图为IPHONE6 如果不是则根据实际情况修改）
#define kScreenWidthRatio  (SCREEN_WIDTH / 375.0)
#define kScreenHeightRatio (SCREEN_HEIGHT / 667.0)
#define AdaptedWidth(x)  ceilf((x) * kScreenWidthRatio)
#define AdaptedHeight(x) ceilf((x) * kScreenHeightRatio)
#define AdaptedFontSize(R)     CHINESE_SYSTEM(AdaptedWidth(R))
#define AdaptedHelveticaFontSize(R)     Helvetica_SYSTEM(AdaptedWidth(R))


#define UNICODETOUTF16(x) (((((x - 0x10000) >>10) | 0xD800) << 16)  | (((x-0x10000)&3FF) | 0xDC00))
#define MULITTHREEBYTEUTF16TOUNICODE(x,y) (((((x ^ 0xD800) << 2) | ((y ^ 0xDC00) >> 8)) << 8) | ((y ^ 0xDC00) & 0xFF)) + 0x10000


//获取View的属性
#define GetViewWidth(view)  view.frame.size.width
#define GetViewHeight(view) view.frame.size.height
#define GetViewX(view)      view.frame.origin.x
#define GetViewY(view)      view.frame.origin.y


// MainScreen bounds
#define Main_Screen_Bounds [[UIScreen mainScreen] bounds]

//导航栏高度
#define TopBarHeight 64.5

// 字体大小(常规/粗体)
#define BOLDSYSTEMFONT(FONTSIZE)[UIFont boldSystemFontOfSize:FONTSIZE]
#define SYSTEMFONT(FONTSIZE)    [UIFont systemFontOfSize:FONTSIZE]
#define FONT(NAME, FONTSIZE)    [UIFont fontWithName:(NAME) size:(FONTSIZE)]


//App版本号
#define appMPVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
// 当前版本
#define FSystemVersion          ([[[UIDevice currentDevice] systemVersion] floatValue])
#define DSystemVersion          ([[[UIDevice currentDevice] systemVersion] doubleValue])
#define SSystemVersion          ([[UIDevice currentDevice] systemVersion])

// 是否大于等于IOS7
#define isIOS7                  ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0)
// 是否IOS6
#define isIOS6                  ([[[UIDevice currentDevice]systemVersion]floatValue] < 7.0)
// 是否大于等于IOS8
#define isIOS8                  ([[[UIDevice currentDevice]systemVersion]floatValue] >=8.0)
// 是否大于IOS9
#define isIOS9                  ([[[UIDevice currentDevice]systemVersion]floatValue] >=9.0)
// 是否iPad
#define isPad                   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

// 是否空对象
#define IS_NULL_CLASS(OBJECT) [OBJECT isKindOfClass:[NSNull class]]



//AppDelegate对象
#define AppDelegateInstance [[UIApplication sharedApplication] delegate]
//一些缩写
#define kApplication        [UIApplication sharedApplication]
#define kKeyWindow          [UIApplication sharedApplication].keyWindow
#define kUserDefaults       [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]

//获取当前语言
#define kCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//获取图片资源
#define GetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

//Library/Caches 文件路径
#define FilePath ([[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil])
//获取temp
#define kPathTemp NSTemporaryDirectory()
//获取沙盒 Document
#define kPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒 Cache
#define kPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

// 国际化字符串
#define local(x) NSLocalizedString((x), nil)

//字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil ? YES : NO )
//数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
//是否是空对象
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

#define kStringSkipEmpty(str)   kStringIsEmpty(str)? @"" : str
#define kDictionarySkipEmpty(dic) kDictIsEmpty(dic)? @{} : dic
#define kZeroSkipEmpty(str)   kStringIsEmpty(str)? @"0" : str


//色值相关

#define SCRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define SCRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

#define SCHEXCOLOR(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]

#define SCHEXACOLOR(hex,a) [UIColor colorWithRed:((float)(((hex) & 0xFF0000) >> 16))/255.0 green:((float)(((hex) & 0xFF00)>>8))/255.0 blue: ((float)((hex) & 0xFF))/255.0 alpha:(a)]



//字体色彩
#define COLOR_WORD_BLACK SCHEXCOLOR(0x333333)
#define COLOR_WORD_GRAY_1 SCHEXCOLOR(0x666666)
#define COLOR_WORD_GRAY_2 SCHEXCOLOR(0x999999)


// clear背景颜色
#define SCClearColor [UIColor clearColor]

//弱引用/强引用  可配对引用在外面用SCWeakSelf(self)，block用SCStrongSelf(self)  也可以单独引用在外面用SCWeakSelf(self) block里面用weakself

#define SCWeakSelf(type)  __weak typeof(type) weak##type = type;
#define SCStrongSelf(type)  __strong typeof(type) type = weak##type;
#define kLineColor SCHEXCOLOR(0xe7e7e7)
//日志
#ifdef DEBUG
#define SCLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define SCLog(...)
#endif

#define NULLString(string) ((![string isKindOfClass:[NSString class]])||[string isEqualToString:@""] || (string == nil) ||[string isEqualToString:@""] || [string isKindOfClass:[NSNull class]]||[[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)

#define kAppDelegate [[UIApplication sharedApplication] delegate]
#define kUserDefault [NSUserDefaults standardUserDefaults]
#define kDefaultCenter [NSNotificationCenter defaultCenter]
#endif /* Macros_h */
