//
//  FJAlertView.h
//  FJAlertViewProject
//
//  Created by fengj on 2020/3/1.
//  Copyright © 2020 objc.co. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FJAlertStyle.h"
#import "FJAlertAction.h"

NS_ASSUME_NONNULL_BEGIN

@protocol FJAlertViewDelegate <NSObject>
- (void)alertButtonClicked;
@end

@interface FJAlertView : UIView
@property (nonatomic, weak) id <FJAlertViewDelegate> delegate;

+ (instancetype)alertWithTitle:(NSString *)title
                       message:(NSString *)message
                   contentView:(UIView *)contentView
                         style:(FJAlertStyle *)style;
- (void)addActions:(NSArray<FJAlertAction*> *)actions;
@end

NS_ASSUME_NONNULL_END
