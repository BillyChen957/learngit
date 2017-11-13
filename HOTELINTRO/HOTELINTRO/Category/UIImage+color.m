//
//  UIImage+color.m
//  HOTELINTRO
//
//  Created by xin on 2017/11/2.
//  Copyright © 2017年 pasaaa. All rights reserved.
//

#import "UIImage+color.h"

@implementation UIImage (color)

+ (UIImage *)imageWithRenderNamed:(NSString *)name
{
    UIImage *image =[UIImage imageNamed:name];
    image =[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);//图片尺寸
    UIGraphicsBeginImageContext(rect.size);//填充画笔
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //根据颜色填充区域
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();//消除画笔
    
    return image;
}
// 画三角形
+ (UIImage *)imageTriangleWithColor:(UIColor *)color rect:(CGRect)rect point1:(CGPoint)point1 point2:(CGPoint)point2 point3:(CGPoint)point3{
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctx, point1.x, point1.y);
    CGContextAddLineToPoint(ctx, point2.x, point2.y);
    CGContextAddLineToPoint(ctx, point3.x, point3.y);
    CGContextClosePath(ctx);
    [color setStroke];
    [color setFill];
    CGContextDrawPath(ctx, kCGPathFillStroke);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
