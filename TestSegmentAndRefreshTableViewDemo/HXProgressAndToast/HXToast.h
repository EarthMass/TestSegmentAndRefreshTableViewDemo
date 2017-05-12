//
//  Toast.h
//  Lift
//
//  Created by Guohx on 16/11/17.
//  Copyright © 2016年 howsur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Toast/UIView+Toast.h>
#import <UIKit/UIKit.h>


/*
 NSString * CSToastPositionTop       = @"CSToastPositionTop";
 NSString * CSToastPositionCenter    = @"CSToastPositionCenter";
 NSString * CSToastPositionBottom    = @"CSToastPositionBottom";
 */
typedef NS_ENUM(NSInteger, HXToastPosition) {
    HXToastPositionTop = 0,
    HXToastPositionCenter,
    HXToastPositionBottom
};

static NSTimeInterval ShowToastTime = 2;
/**
 Toast提示框
 */
@interface HXToast : NSObject

+ (void)showToast:(UIView *)view msg:(NSString *)msg;

+ (void)showToast:(UIView *)view customView:(UIView *)customView;

+ (void)showToast:(UIView *)view msg:(NSString *)msg time:(NSTimeInterval)time;


/**
 Toast提示框

 @param view view
 @param msg msg
 @param time time
 @param position  
 NSString * CSToastPositionTop       = @"CSToastPositionTop";
 NSString * CSToastPositionCenter    = @"CSToastPositionCenter";
 NSString * CSToastPositionBottom    = @"CSToastPositionBottom";
 */
+ (void)showToast:(UIView *)view
              msg:(NSString *)msg
             time:(NSTimeInterval)time
         position:(HXToastPosition)position;

+ (void)showToast:(UIView *)view
       customView:(UIView *)customView
             time:(NSTimeInterval)time
         position:(HXToastPosition)position;


@end
