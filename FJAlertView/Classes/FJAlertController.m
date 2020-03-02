//
//  FJAlertViewController.m
//  FJAlertViewProject
//
//  Created by fengj on 2020/3/1.
//  Copyright © 2020 objc.co. All rights reserved.
//

#import "FJAlertController.h"
#import "FJAlertView.h"
#import "Masonry.h"
#import "UIWindow+FJBlur.h"

@interface FJAlertController ()<UIViewControllerTransitioningDelegate, FJAlertViewDelegate>
@property (nonatomic, strong) UIImageView *blurView;
@property (nonatomic, strong) UIButton *coverView;

@property (nonatomic, strong) FJAlertView *alertView;
@property (nonatomic, copy) NSString *alertTitle;
@property (nonatomic, copy) NSString *alertMessage;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) FJAlertStyle *style;
@property (nonatomic, strong) NSMutableArray <FJAlertAction *> *actions;
@end

#pragma mark - transitionAnimation
@interface FJDimissAnimation : NSObject <UIViewControllerAnimatedTransitioning>
@end
@implementation FJDimissAnimation
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.2;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    FJAlertController *alertController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        alertController.coverView.alpha = 0;
        alertController.blurView.alpha = 0;
        alertController.alertView.alpha = 0;
    } completion:^(BOOL finished) {
        [alertController.view removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        alertController.alertView.transform = CGAffineTransformMakeScale(0.7, 0.7);
    } completion:^(BOOL finished) {
        alertController.alertView.transform = CGAffineTransformIdentity;
    }];
}
@end

@interface FJPresentAnimation : NSObject <UIViewControllerAnimatedTransitioning>
@end
@implementation FJPresentAnimation
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.4;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    FJAlertController *alertController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    [[transitionContext containerView] addSubview:alertController.view];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];

    alertController.blurView.alpha = 0;
    alertController.coverView.alpha = 0;
    alertController.alertView.alpha = 1;
    alertController.alertView.transform = CGAffineTransformMakeScale(0.4, 0.4);
    
    [UIView animateWithDuration:duration / 2 animations:^{
        alertController.coverView.alpha = alertController.style.background.alpha;
    }];
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        alertController.blurView.alpha = 1;
    } completion:nil];
    
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:20 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        alertController.alertView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}
@end

@implementation FJAlertController

#pragma mark - life cycle

+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message {
    return [[self alloc]initWithTitle:title message:message contentView:nil style:nil];
}

+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message style:(FJAlertStyle *)style {
    return [[self alloc]initWithTitle:title message:message contentView:nil style:style];
}

+ (instancetype)alertWithTitle:(NSString *)title contentView:(UIView *)contentView {
    return [[self alloc]initWithTitle:title message:nil contentView:contentView style:nil];
}

+ (instancetype)alertWithTitle:(NSString *)title contentView:(UIView *)contentView style:(FJAlertStyle *)style {
    return [[self alloc]initWithTitle:title message:nil contentView:contentView style:style];
}

+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message contentView:(UIView *)contentView {
    return [[self alloc]initWithTitle:title message:message contentView:contentView style:nil];
}

+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message contentView:(UIView *)contentView style:(FJAlertStyle *)style {
    return [[self alloc]initWithTitle:title message:message contentView:contentView style:style];
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message contentView:(UIView *)contentView style:(FJAlertStyle *)style {
    self = [super init];
    if (self) {
        if (!title&&!message&&!contentView&&!style) {
            [NSException raise:@"参数不能全部为空" format:@""];
        }
        self.alertTitle = title;
        self.alertMessage = message;
        self.contentView = contentView;
        self.style = style?style:[FJAlertStyle defaultStyle];
        
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self;
    }
    return self;
}

- (void)addAction:(FJAlertAction *)action {
    if (!action) {
        return;
    }
    [self.actions addObject:action];
}

#pragma mark - UI

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBlurView];
    [self setupAlphaCoverView];
    [self setupAlertView];
}

- (void)setupBlurView {
    if (self.style.background.blur) {
        // check the window
        NSArray* reversedWindows = [[[UIApplication sharedApplication].windows reverseObjectEnumerator] allObjects];
        for (UIWindow *window in reversedWindows) {
            if ([NSStringFromClass([window class]) isEqualToString:@"UIWindow"] && CGRectEqualToRect(window.frame, [UIScreen mainScreen].bounds)) {
                self.blurView = [window blurScreenshot];
                [self.view addSubview:self.blurView];
                break;
            }
        }
    }
}

- (void)setupAlphaCoverView {
    self.coverView = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];

    FJAlertStyleBackground *backgroundStyle = self.style.background;
    BOOL canDismiss = backgroundStyle.canDismiss;
    self.coverView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.coverView];
    if (canDismiss) {
        [self.coverView addTarget:self action:@selector(dismissViewController) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)setupAlertView {
    self.alertView = [FJAlertView alertWithTitle:self.alertTitle message:self.alertMessage contentView:self.contentView style:self.style];
    self.alertView.delegate = self;
    [self.alertView addActions:self.actions];
    [self.view addSubview:self.alertView];
    
    //set alertView style
    FJAlertStyleAlertView *style = self.style.alertView;
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    CGFloat screenMaxHeight = [UIScreen mainScreen].bounds.size.height-statusBarHeight*2;
    CGFloat maxHeight = style.maxHeight<screenMaxHeight?style.maxHeight:screenMaxHeight;
    [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(@(style.width));
        make.height.lessThanOrEqualTo(@(maxHeight));
    }];
    self.alertView.backgroundColor = style.backgroundColor;
    if (style.cornerRadius>0) {
        self.alertView.layer.masksToBounds = YES;
        self.alertView.layer.cornerRadius = style.cornerRadius;
    }
    self.alertView.layer.borderColor = style.borderColor.CGColor;
    self.alertView.layer.borderWidth = style.borderWidth;
}

- (void)dismissViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - transtionAnimation

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [FJPresentAnimation new];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [FJDimissAnimation new];
}

#pragma mark - FJAlertViewDelegate

- (void)alertButtonClicked {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark - setter and getter

- (NSMutableArray<FJAlertAction *> *)actions {
    if (!_actions) {
        _actions = @[].mutableCopy;
    }
    return _actions;
}

@end
