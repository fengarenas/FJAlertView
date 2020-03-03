//
//  UIColor+FJHightlightedColor.m
//  FJAlertViewProject
//
//  Created by fengj on 2020/3/1.
//  Copyright © 2020 objc.co. All rights reserved.
//


#import "UIColor+FJHightlightedColor.h"

#define deepValue 10

@implementation UIColor (FJHightlightedColor)

- (UIColor *)hightlightedColor {
    CGFloat r;
    CGFloat g;
    CGFloat b;
    CGFloat a;
    NSUInteger numberOfComponents = CGColorGetNumberOfComponents(self.CGColor);
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    if (numberOfComponents==4) {
        //UIDeviceRGBColorSpace
        r = components[0];
        g = components[1];
        b = components[2];
        a = components[3];
    } else if (numberOfComponents==2) {
        //UIDeviceWhiteColor
        r = components[0];
        g = components[0];
        b = components[0];
        a = components[1];
    }
    
    r = r * 255 - deepValue >= 0 ? r * 255 - deepValue : 0;
    g = g * 255 - deepValue >= 0 ? g * 255 - deepValue : 0;
    b = b * 255 - deepValue >= 0 ? b * 255 - deepValue : 0;
    
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a];
}

@end
