//
//  FJAlertAction.m
//  FJAlertViewProject
//
//  Created by fengj on 2020/3/1.
//  Copyright © 2020 objc.co. All rights reserved.
//

#import "FJAlertAction.h"

@interface FJAlertAction ()

@end

@implementation FJAlertAction

+ (instancetype)actionWithTitle:(nullable NSString *)title style:(FJAlertActionStyle)style handler:(actionHandler)handler {
    FJAlertAction *action = [[self alloc]initWithTitle:title style:style handler:handler];
    return action;
}

- (instancetype)initWithTitle:(nullable NSString *)title style:(FJAlertActionStyle)style handler:(actionHandler)handler {
    self = [super init];
    if (self) {
        _title = [title copy];
        _style = style;
        _handler = [handler copy];
        _enabled = YES;
    }
    return self;
}

@end
