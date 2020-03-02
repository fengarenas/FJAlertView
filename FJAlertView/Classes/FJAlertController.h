//
//  FJAlertViewController.h
//  FJAlertViewProject
//
//  Created by fengj on 2020/3/1.
//  Copyright © 2020 objc.co. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FJAlertStyle.h"
#import "FJAlertAction.h"

@interface FJAlertController : UIViewController

+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message;
+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message style:(FJAlertStyle *)style;

+ (instancetype)alertWithTitle:(NSString *)title contentView:(UIView *)contentView;
+ (instancetype)alertWithTitle:(NSString *)title contentView:(UIView *)contentView style:(FJAlertStyle *)style;

+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message contentView:(UIView *)contentView;
+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message contentView:(UIView *)contentView style:(FJAlertStyle *)style;

- (void)addAction:(nonnull FJAlertAction *)action;

@end

