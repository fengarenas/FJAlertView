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
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    
    r = r * 255 - deepValue >= 0 ? r * 255 - deepValue : 0;
    g = g * 255 - deepValue >= 0 ? g * 255 - deepValue : 0;
    b = b * 255 - deepValue >= 0 ? b * 255 - deepValue : 0;
    
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:components[3]];
}

@end
