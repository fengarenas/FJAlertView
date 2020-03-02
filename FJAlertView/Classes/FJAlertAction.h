//
//  FJAlertAction.h
//  FJAlertViewProject
//
//  Created by fengj on 2020/3/1.
//  Copyright © 2020 objc.co. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, FJAlertActionStyle) {
    FJAlertActionStyleDefault = 0,
    FJAlertActionStyleCancel,
    FJAlertActionStyleDestructive
};

@class FJAlertAction;
typedef void(^actionHandler)(FJAlertAction *action);

@interface FJAlertAction : NSObject

+ (instancetype)actionWithTitle:(nullable NSString *)title style:(FJAlertActionStyle)style handler:(actionHandler)handler;

@property (nullable, nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) FJAlertActionStyle style;
@property (nonatomic, copy, readonly) actionHandler handler;
@property (nonatomic, getter=isEnabled) BOOL enabled;

@end

NS_ASSUME_NONNULL_END
