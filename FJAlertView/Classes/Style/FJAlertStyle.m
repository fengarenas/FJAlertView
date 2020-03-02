//
//  FJAlertStyle.m
//  FJAlertViewProject
//
//  Created by fengj on 2020/3/1.
//  Copyright © 2020 objc.co. All rights reserved.
//

#import "FJAlertStyle.h"

#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)

@implementation FJAlertStyleAlertView
+ (instancetype)defaultStyle {
    FJAlertStyleAlertView *style = [[self alloc]init];
    style.width = 281.f;
    style.maxHeight = kScreenHeight - 20*2;
    style.backgroundColor = UIColor.whiteColor;
    style.cornerRadius = 3.f;
    style.borderWidth = 0;
    style.borderColor = UIColor.clearColor;
    return style;
}
@end

@implementation FJAlertStyleBackground
+ (instancetype)defaultStyle {
    FJAlertStyleBackground *style = [[self alloc]init];
    style.canDismiss = NO;
    style.alpha = .6f;
    style.blur = NO;
    return style;
}
@end

@implementation FJAlertStyleTitle
+ (instancetype)defaultStyle {
    FJAlertStyleTitle *style = [[self alloc]init];
    style.insets = UIEdgeInsetsMake(26, 5, 0, 5);
    style.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    style.textColor = [UIColor colorWithRed:0x33/255.f green:0x33/255.f blue:0x33/255.f alpha:1];
    style.backgroundColor = UIColor.clearColor;
    style.textAlignment = NSTextAlignmentCenter;
    return style;
}
@end

@implementation FJAlertStyleContent
+ (instancetype)defaultStyle {
    FJAlertStyleContent *style = [[self alloc]init];
    style.insets = UIEdgeInsetsMake(18, 26, 0, 26);
    style.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    style.textColor = [UIColor colorWithRed:0x66/255.f green:0x66/255.f blue:0x66/255.f alpha:1];
    style.backgroundColor = UIColor.clearColor;
    style.textAlignment = NSTextAlignmentCenter;
    return style;
}
@end


@implementation FJAlertStyleButtonSpace
+ (instancetype)defaultStyle {
    FJAlertStyleButtonSpace *style = [[self alloc]init];
    style.insets = UIEdgeInsetsMake(18, 26, 18, 26);
    style.buttonHeight = 32.f;
    style.interitemSpacing = 12.f;
    return style;
}
@end


@implementation FJAlertStyleButton
+ (instancetype)defaultStyle {
    FJAlertStyleButton *style = [[self alloc]init];
    return style;
}
@end

@implementation FJAlertStyleButtonNormal
+ (instancetype)defaultStyle {
    FJAlertStyleButtonNormal *style = [[self alloc]init];
    style.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
    style.textColor = [UIColor colorWithRed:0x33/255.f green:0x33/255.f blue:0x33/255.f alpha:1];
    style.backgroundColor = UIColor.clearColor;
    style.cornerRadius = 32/2.f;
    style.borderColor = [UIColor colorWithRed:0xd1/255.f green:0xd1/255.f blue:0xd1/255.f alpha:1];
    style.borderWidth = 1.f;
    return style;
}
@end

@implementation FJAlertStyleButtonCancel
+ (instancetype)defaultStyle {
    FJAlertStyleButtonCancel *style = [[self alloc]init];
    style.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
    style.textColor = UIColor.lightGrayColor;
    style.backgroundColor = UIColor.clearColor;
    style.cornerRadius = 32/2.f;
    style.borderColor = [UIColor colorWithRed:0xd1/255.f green:0xd1/255.f blue:0xd1/255.f alpha:1];
    style.borderWidth = 1.f;
    return style;
}
@end

@implementation FJAlertStyleButtonDestructive
+ (instancetype)defaultStyle {
    FJAlertStyleButtonDestructive *style = [[self alloc]init];
    style.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
    style.textColor = [UIColor colorWithRed:0xdf/255.f green:0x7e/255.f blue:0x5a/255.f alpha:1];
    style.backgroundColor = UIColor.clearColor;
    style.cornerRadius = 32/2.f;
    style.borderColor = [UIColor colorWithRed:0xed/255.f green:0x92/255.f blue:0x63/255.f alpha:1];
    style.borderWidth = 1.f;
    return style;
}
@end

@implementation FJAlertStyle
+ (instancetype)defaultStyle {
    FJAlertStyle *style = [[self alloc]init];
    style.alertView = [FJAlertStyleAlertView defaultStyle];
    style.background = [FJAlertStyleBackground defaultStyle];
    style.title = [FJAlertStyleTitle defaultStyle];
    style.content = [FJAlertStyleContent defaultStyle];
    style.buttonSpace = [FJAlertStyleButtonSpace defaultStyle];
    style.buttonNormal = [FJAlertStyleButtonNormal defaultStyle];
    style.buttonCancel = [FJAlertStyleButtonCancel defaultStyle];
    style.buttonDestructive = [FJAlertStyleButtonDestructive defaultStyle];
    return style;
}
@end
