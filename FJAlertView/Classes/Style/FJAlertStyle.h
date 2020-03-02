//
//  FJAlertStyle.h
//  FJAlertViewProject
//
//  Created by fengj on 2020/3/1.
//  Copyright © 2020 objc.co. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FJAlertStyleAlertView : NSObject
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat maxHeight;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic) CGFloat cornerRadius;
@property (nonatomic) CGFloat borderWidth;
@property (nonatomic, strong) UIColor *borderColor;
+ (instancetype)defaultStyle;
@end

@interface FJAlertStyleBackground : NSObject
@property (nonatomic) BOOL blur;
@property (nonatomic) BOOL canDismiss; // dismissed with touched the bg
@property (nonatomic) float alpha;
+ (instancetype)defaultStyle;
@end

@interface FJAlertStyleTitle : NSObject
@property (nonatomic) UIEdgeInsets insets;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, assign) NSTextAlignment textAlignment;
+ (instancetype)defaultStyle;
@end

@interface FJAlertStyleContent : NSObject
@property (nonatomic) UIEdgeInsets insets;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, assign) NSTextAlignment textAlignment;
+ (instancetype)defaultStyle;
@end

@interface FJAlertStyleButtonSpace : NSObject
@property (nonatomic) CGFloat buttonHeight;
@property (nonatomic) UIEdgeInsets insets;
@property (nonatomic) CGFloat interitemSpacing;
+ (instancetype)defaultStyle;
@end

@interface FJAlertStyleButton : NSObject
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *highlightTextColor;
@property (nonatomic, strong) UIColor *highlightBackgroundColor;
@property (nonatomic) CGFloat cornerRadius;
@property (nonatomic) CGFloat borderWidth;
@property (nonatomic, strong) UIColor *borderColor;
+ (instancetype)defaultStyle;
@end

@interface FJAlertStyleButtonNormal : FJAlertStyleButton
@end

@interface FJAlertStyleButtonCancel : FJAlertStyleButton
@end

@interface FJAlertStyleButtonDestructive : FJAlertStyleButton
@end


@interface FJAlertStyle : NSObject
@property (nonatomic, strong) FJAlertStyleAlertView *alertView;
@property (nonatomic, strong) FJAlertStyleBackground *background;
@property (nonatomic, strong) FJAlertStyleTitle *title;
@property (nonatomic, strong) FJAlertStyleContent *content;
@property (nonatomic, strong) FJAlertStyleButtonSpace *buttonSpace;
@property (nonatomic, strong) FJAlertStyleButtonNormal *buttonNormal;
@property (nonatomic, strong) FJAlertStyleButtonCancel *buttonCancel;
@property (nonatomic, strong) FJAlertStyleButtonDestructive *buttonDestructive;
+ (instancetype)defaultStyle;
@end

NS_ASSUME_NONNULL_END
