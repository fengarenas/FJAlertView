//
//  FJViewController.m
//  FJAlertView
//
//  Created by FengJ on 03/02/2020.
//  Copyright (c) 2020 FengJ. All rights reserved.
//

#import "FJViewController.h"
#import <FJAlertView/FJAlertController.h>
#import <Masonry.h>

@interface FJViewController ()

@end

@implementation FJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_id"];
    NSUInteger section = indexPath.section;
    NSString *title;
    if (section==0) {
        title = @"default";
    } else if (section==1) {
        title = @"optional param";
    } else if (section==2) {
        title = @"long text";
    } else if (section==3) {
        title = @"custom style";
    } else if (section==4) {
        title = @"custom view";
    }
    cell.textLabel.text = title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSUInteger section = indexPath.section;
    if (section==0) {
        FJAlertController *alert = [FJAlertController alertWithTitle:@"温馨提示"
                                                             message:@"您的交易因网络问题未回调"];
        FJAlertAction *action = [FJAlertAction actionWithTitle:@"继续等待" style:FJAlertActionStyleDefault handler:^(FJAlertAction * _Nonnull action) {
            NSLog(@"1");
        }];
        FJAlertAction *action2 = [FJAlertAction actionWithTitle:@"取消交易" style:FJAlertActionStyleDestructive handler:^(FJAlertAction * _Nonnull action) {
            NSLog(@"2");
        }];
        [alert addAction:action];
        [alert addAction:action2];
        [self presentViewController:alert animated:YES completion:nil];
        
    } else if (section==1) {
        //参数可以为空
        FJAlertController *alert = [FJAlertController alertWithTitle:@"温馨提示"
                                                             message:nil
                                                             contentView:nil
                                                               style:nil];
        FJAlertAction *action = [FJAlertAction actionWithTitle:@"继续等待" style:FJAlertActionStyleDefault handler:^(FJAlertAction * _Nonnull action) {
            NSLog(@"1");
        }];
        FJAlertAction *action2 = [FJAlertAction actionWithTitle:@"取消交易" style:FJAlertActionStyleDestructive handler:^(FJAlertAction * _Nonnull action) {
            NSLog(@"2");
        }];
        [alert addAction:action];
        [alert addAction:action2];
        [self presentViewController:alert animated:YES completion:nil];
    } else if (section==2) {
        FJAlertStyle *style = [FJAlertStyle defaultStyle];
        style.alertView.maxHeight = 200;//设置alertview最大的高度,如果因message文字过长超过此高度,则message自动滚动
        FJAlertController *alert = [FJAlertController alertWithTitle:@"温馨提示"
                                                             message:@"您的交易因网络问题未回调您的交易因网络问题未回调您的交易因网络问题未回调您的交易因网络问题未回调您的交易因网络问题未回调您的交易因网络问题未回调您的交易因网络问题未回调您的交易因网络问题未回调您的交易因网络问题未回调您的交易因网络问题未回调您的交易因网络问题未回调您的交易因网络问题未回调您的交易因网络问题未回调您的交易因网络问题未回调您的交易因网络问题未回调您的交易因网络问题未回调您的交易因网络问题未回调您的交易因网络问题未回调您的交易因网络问题未回调您的交易因网络问题未回调您的交易因网络问题未回调您的交易因网络问题未回调您的交易因网络问题未回调您的交易因网络问题未回调您的交易因网络问题未回调您的交易因网络问题未回调您的交易因网络问题未回调您的交易因网络问题未回调您的交易因网络问题未回调您的交易因网络问题未回调您的交易因网络问题未回调您的交易因网络问题未回调您的交易因网络问题未回调您的交易因网络问题未回调您的交易因网络问题未回调您的交易因网络问题未回调您的交易因网络问题未回调您的交易因网络问题未回调您的交易因网络问题未回调"
                                                             contentView:nil
                                                               style:style];
        FJAlertAction *action = [FJAlertAction actionWithTitle:@"继续等待" style:FJAlertActionStyleDefault handler:^(FJAlertAction * _Nonnull action) {
            NSLog(@"1");
        }];
        FJAlertAction *action2 = [FJAlertAction actionWithTitle:@"取消交易" style:FJAlertActionStyleDestructive handler:^(FJAlertAction * _Nonnull action) {
            NSLog(@"2");
        }];
        [alert addAction:action];
        [alert addAction:action2];
        [self presentViewController:alert animated:YES completion:nil];
    } else if (section==3) {
        FJAlertStyle *style = [FJAlertStyle defaultStyle];
        style.background.blur = YES;//背景模糊效果
        style.background.canDismiss = YES;//点击背景 dismiss
        
        /*
         @property (nonatomic) CGFloat width;
         @property (nonatomic) CGFloat maxHeight;
         @property (nonatomic, strong) UIColor *backgroundColor;
         @property (nonatomic) CGFloat cornerRadius;
         @property (nonatomic) CGFloat borderWidth;
         @property (nonatomic, strong) UIColor *borderColor;
         */
        style.alertView.width = [UIScreen mainScreen].bounds.size.width-10;
        style.alertView.maxHeight = [UIScreen mainScreen].bounds.size.height-100;
        style.alertView.backgroundColor = UIColor.magentaColor;
        style.alertView.cornerRadius = 20.f;
        style.alertView.borderColor = UIColor.redColor;
        style.alertView.borderWidth = 1.f;
        
        
        style.title.textColor = UIColor.blueColor;
        style.title.insets = UIEdgeInsetsMake(10, 10, 10, 10);
        style.title.backgroundColor = UIColor.lightGrayColor;
        
        style.content.backgroundColor = UIColor.darkGrayColor;
        style.content.textColor = UIColor.systemGreenColor;
        
        style.buttonSpace.insets = UIEdgeInsetsMake(20, 0, 0, 0);
        style.buttonSpace.interitemSpacing = 0;
        
        style.buttonNormal.cornerRadius = 0.f;
        style.buttonNormal.borderWidth = 0.f;
        style.buttonNormal.backgroundColor = UIColor.orangeColor;
        style.buttonNormal.textColor = UIColor.redColor;
        
        style.buttonDestructive.cornerRadius = 0.f;
        style.buttonDestructive.borderWidth = 0.f;
        style.buttonDestructive.backgroundColor = UIColor.blueColor;
        style.buttonDestructive.textColor = UIColor.redColor;
        
        FJAlertController *alert = [FJAlertController alertWithTitle:@"自定义样式"
                                                             message:@"您的交易因网络问题未回调"
                                                             contentView:nil
                                                               style:style];
        FJAlertAction *action = [FJAlertAction actionWithTitle:@"继续等待" style:FJAlertActionStyleDefault handler:^(FJAlertAction * _Nonnull action) {
            NSLog(@"1");
        }];
        FJAlertAction *action2 = [FJAlertAction actionWithTitle:@"取消交易" style:FJAlertActionStyleDestructive handler:^(FJAlertAction * _Nonnull action) {
            NSLog(@"2");
        }];
        [alert addAction:action];
        [alert addAction:action2];
        [self presentViewController:alert animated:YES completion:nil];
    } else if (section==4) {
        UIView *v = UIView.new;
        v.backgroundColor = UIColor.blueColor;

        UILabel *label = UILabel.new;
        label.font = [UIFont systemFontOfSize:20];
        label.text = @"custom view";
        label.textColor = UIColor.greenColor;
        label.textAlignment = NSTextAlignmentCenter;
        
        [v addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(v).insets(UIEdgeInsetsMake(20, 20, 20, 20));
        }];
        
        FJAlertController *alert = [FJAlertController alertWithTitle:nil
                                                             message:nil
                                                             contentView:v];
        FJAlertAction *action = [FJAlertAction actionWithTitle:@"继续等待" style:0 handler:^(FJAlertAction * _Nonnull action) {
            NSLog(@"1");
        }];
        FJAlertAction *action2 = [FJAlertAction actionWithTitle:@"取消交易" style:FJAlertActionStyleDestructive handler:^(FJAlertAction * _Nonnull action) {
            NSLog(@"2");
        }];
        [alert addAction:action];
        [alert addAction:action2];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}

@end
