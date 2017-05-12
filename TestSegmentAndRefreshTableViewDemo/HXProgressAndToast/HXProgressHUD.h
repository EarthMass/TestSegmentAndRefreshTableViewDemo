//
//  HXProgressHUD.h
//  Lift
//
//  Created by Guohx on 16/11/17.
//  Copyright © 2016年 howsur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SVProgressHUD/SVProgressHUD.h>

static NSString * msg = @"加载中...";
/**
 加载提示框 【无法实现控制导航栏的点击或者不点击 想要可用JGProgressHUD替换】
 */
@interface HXProgressHUD : NSObject


/**
 无文字的HUD
 */
+ (void)showHUD;

/**
 默认文字 加载中...
 */
+ (void)showHUDDefault;

/**
 自定义文字

 @param string 文字内容
 */
+ (void)showWithStatus:(NSString*)string;

/**
 自定义文字 自定义消失时间

 @param string 文字内容
 @param duration 持续时间
 */
+ (void)showWithStatus:(NSString*)string duration:(NSTimeInterval)duration;


/**
 消失
 */
+ (void)dismissHUD;

+ (void)showImage:(UIImage*)image status:(NSString*)string;
/**
 消失 带图片

 @param image 图片 [图片是无色的]
 */
+ (void)dismissHUD:(UIImage *)image status:(NSString*)string;

+ (void)setDefaultStyle; //默认 设置默认的 在初始化的时候 初始化一次就好了
//+ (void)setDefaultStyle {
//    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
//    [SVProgressHUD setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.3]];
//    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
//    
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
//}

@end


