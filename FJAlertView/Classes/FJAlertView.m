//
//  FJAlertView.m
//  FJAlertViewProject
//
//  Created by fengj on 2020/3/1.
//  Copyright © 2020 objc.co. All rights reserved.
//

#import "FJAlertView.h"
#import "Masonry.h"
#import "UIImage+FJColor2Image.h"
#import "UIColor+FJHightlightedColor.h"

@interface FJAlertView ()
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) FJAlertStyle *style;
@property (nonatomic, copy) NSArray<FJAlertAction*> *actions;

@property (nonatomic, strong) UIView *titleContainer;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *messageContainer;
@property (nonatomic, strong) UITextView *messageTextView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *buttonsContainer;

@end

@implementation FJAlertView

#pragma mark - life cycle

+ (instancetype)alertWithTitle:(NSString *)title
                       message:(NSString *)message
                   contentView:(UIView *)contentView
                         style:(FJAlertStyle *)style {
    return [[self alloc]initWithTitle:title message:message contentView:contentView style:style];
}

- (instancetype)initWithTitle:(NSString *)title
                       message:(NSString *)message
                   contentView:(UIView *)contentView
                         style:(FJAlertStyle *)style {
    self = [super init];
    if (self) {
        self.title = title;
        self.message = message;
        self.contentView = contentView;
        self.style = style;
        [self.messageTextView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentSize"] && object == self.messageTextView) {
        CGSize contentSize = [[change objectForKey:NSKeyValueChangeNewKey] CGSizeValue];
        CGFloat height = contentSize.height;
        [self.messageTextView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(height)).priorityLow();
            make.height.lessThanOrEqualTo(@(height)).priorityHigh();
        }];
    }
}

- (void)dealloc {
    [self.messageTextView removeObserver:self forKeyPath:@"contentSize"];
}

#pragma mark - event response

- (void)addActions:(NSArray<FJAlertAction*> *)actions {
    self.actions = actions;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    //Layout UI
    
    NSMutableArray <UIView *>*containers = @[].mutableCopy;
    //title
    if (self.title) {
        [containers addObject:self.titleContainer];
        [self addSubview:self.titleContainer];
        [self.titleContainer addSubview:self.titleLabel];
        FJAlertStyleTitle *titleStyle = self.style.title;
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.titleContainer).insets(titleStyle.insets);
        }];
        self.titleLabel.font = titleStyle.font;
        self.titleLabel.textColor = titleStyle.textColor;
        self.titleLabel.backgroundColor = titleStyle.backgroundColor;
        self.titleLabel.textAlignment = titleStyle.textAlignment;
        self.titleLabel.text = self.title;
    }
    
    if (self.message) {
        [containers addObject:self.messageContainer];
        //message
        [self addSubview:self.messageContainer];
        [self.messageContainer addSubview:self.messageTextView];
        FJAlertStyleContent *messageStyle = self.style.content;
        [self.messageTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.messageContainer).insets(messageStyle.insets);
            make.height.equalTo(@(0)).priorityLow();
            make.height.lessThanOrEqualTo(@(0)).priorityHigh();
        }];
        
        self.messageTextView.font = messageStyle.font;
        self.messageTextView.textColor = messageStyle.textColor;
        self.messageTextView.backgroundColor = messageStyle.backgroundColor;
        self.messageTextView.textAlignment = messageStyle.textAlignment;
        self.messageTextView.text = self.message;
    }

    //coustom view
    if (self.contentView) {
        [containers addObject:self.contentView];
        [self addSubview:self.contentView];
    }
    

    if (self.actions.count) {
        [containers addObject:self.buttonsContainer];
        [self addSubview:self.buttonsContainer];

        //buttons
        __block UIView *lastView;
        [self.actions enumerateObjectsUsingBlock:^(FJAlertAction * _Nonnull action, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *btn = UIButton.new;
            [self.buttonsContainer addSubview:btn];
            FJAlertStyleButtonSpace *btnSpaceStyle = self.style.buttonSpace;
            CGFloat buttonWidth = btnSpaceStyle.insets.left + btnSpaceStyle.insets.right + (self.actions.count-1)*btnSpaceStyle.interitemSpacing;
            CGFloat buttonHeight = btnSpaceStyle.buttonHeight;
            BOOL isLast = idx == self.actions.count-1;
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@(buttonWidth)).priority(999);
                if (lastView) {
                    make.width.equalTo(lastView);
                }
                make.height.equalTo(@(buttonHeight));
                if (lastView) {
                    make.leading.equalTo(lastView.mas_trailing).offset(btnSpaceStyle.interitemSpacing);
                } else {
                    make.leading.equalTo(self.buttonsContainer.mas_leading).offset(btnSpaceStyle.insets.left);
                }
                make.top.equalTo(self.buttonsContainer.mas_top).offset(btnSpaceStyle.insets.top);
                make.bottom.equalTo(self.buttonsContainer.mas_bottom).offset(-btnSpaceStyle.insets.bottom);
                if (isLast) {
                    make.trailing.equalTo(self.buttonsContainer.mas_trailing).offset(-btnSpaceStyle.insets.right).priority(1000);
                }
            }];
            lastView = btn;
            
            FJAlertStyleButton *btnStyle;
            if (action.style == FJAlertActionStyleCancel) {
                btnStyle = self.style.buttonCancel?self.style.buttonCancel:FJAlertStyleButtonCancel.defaultStyle;
            } else if (action.style == FJAlertActionStyleDestructive) {
                btnStyle = self.style.buttonDestructive?self.style.buttonDestructive:FJAlertStyleButtonDestructive.defaultStyle;
            } else {
                btnStyle = self.style.buttonNormal?self.style.buttonNormal:FJAlertStyleButtonNormal.defaultStyle;
            }

            
            btn.titleLabel.font = btnStyle.font;
            
            UIColor *textColor = btnStyle.textColor?btnStyle.textColor:[UIColor blackColor];
            UIColor *highlightTextColor = btnStyle.highlightTextColor?btnStyle.highlightTextColor:[textColor hightlightedColor];
            UIColor *backgroundColor = btnStyle.backgroundColor?btnStyle.backgroundColor:[UIColor whiteColor];
            UIColor *highlightBackgroundColor = btnStyle.highlightBackgroundColor?btnStyle.highlightBackgroundColor:[backgroundColor hightlightedColor];
            
            [btn setTitleColor:textColor forState:UIControlStateNormal];
            [btn setTitleColor:highlightTextColor forState:UIControlStateHighlighted];
            [btn setBackgroundImage:[UIImage createImageWithColor:backgroundColor] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage createImageWithColor:highlightBackgroundColor] forState:UIControlStateHighlighted];
            if (btnStyle.cornerRadius>0) {
                btn.layer.masksToBounds = YES;
                btn.layer.cornerRadius = btnStyle.cornerRadius;
            }
            btn.layer.borderColor = btnStyle.borderColor.CGColor;
            btn.layer.borderWidth = btnStyle.borderWidth;
            btn.tag = idx;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:action.title forState:UIControlStateNormal];

        }];
    }
    
    __block UIView *lastView;
    [containers enumerateObjectsUsingBlock:^(UIView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL isLast = idx == containers.count-1;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastView?lastView.mas_bottom:self);
            make.leading.trailing.equalTo(self);
            if (isLast) {
                make.bottom.equalTo(self);
            }
        }];
        lastView = view;
    }];
}

- (void)btnClick:(UIButton *)btn {
    NSUInteger tag = btn.tag;
    if (tag<self.actions.count) {
        FJAlertAction *action = self.actions[tag];
        if (action.handler) {
            action.handler((action));
        }
        if ([self.delegate respondsToSelector:@selector(alertButtonClicked)]) {
            [self.delegate alertButtonClicked];
        }
    }
}

#pragma mark - setter and getter

- (UIView *)titleContainer {
    if (!_titleContainer) {
        _titleContainer = UIView.new;
    }
    return _titleContainer;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
    }
    return _titleLabel;
}

- (UIView *)messageContainer {
    if (!_messageContainer) {
        _messageContainer = UIView.new;
    }
    return _messageContainer;
}

- (UITextView *)messageTextView {
    if (!_messageTextView) {
        _messageTextView = [UITextView new];
        _messageTextView.editable = NO;
        _messageTextView.contentInset = UIEdgeInsetsZero;
        _messageTextView.textContainerInset = UIEdgeInsetsZero;
    }
    return _messageTextView;
}

- (UIView *)buttonsContainer {
    if (!_buttonsContainer) {
        _buttonsContainer = UIView.new;
    }
    return _buttonsContainer;
}

@end
