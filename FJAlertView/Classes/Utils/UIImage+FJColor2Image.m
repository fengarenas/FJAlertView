//
//  UIImage+FJColor2Image.m
//  FJAlertViewProject
//
//  Created by fengj on 2020/3/1.
//  Copyright © 2020 objc.co. All rights reserved.
//


#import "UIImage+FJColor2Image.h"

@implementation UIImage (FJJCColor2Image)

+ (UIImage *)createImageWithColor:(UIColor *)color {
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
