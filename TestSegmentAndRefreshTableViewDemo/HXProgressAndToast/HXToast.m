//
//  Toast.m
//  Lift
//
//  Created by Guohx on 16/11/17.
//  Copyright © 2016年 howsur. All rights reserved.
//

#import "HXToast.h"

#define HXPositionType(type) ({ \
    NSString * typeStr = nil; \
    NSArray * typeArr = @[CSToastPositionTop,CSToastPositionCenter,CSToastPositionBottom]; \
    if (type >= 0 && type < 3) { \
        typeStr = typeArr[type]; \
    } else { \
        typeStr = typeArr[0]; \
    } \
    typeStr; \
})

@interface HXToast()

@property (nonatomic, assign)  BOOL canShow;

@end

@implementation HXToast

#pragma mark -

+ (void)setPosition {
    
}

+ (id)sharedInstance{
    static HXToast * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HXToast alloc] init];
        instance.canShow = YES;
    });
    return instance;
}

+ (void)showToast:(UIView *)view msg:(NSString *)msg {
    
    
    
    if ([[HXToast sharedInstance] canShow]) {
        [[HXToast sharedInstance] setCanShow:NO];
        [view makeToast:msg
               duration:ShowToastTime
               position:CSToastPositionCenter
                  title:nil
                  image:[UIImage imageNamed:@"toast.png"]
                  style:nil
             completion:^(BOOL didTap) {
                 if (didTap) {
                     NSLog(@"completion from tap");
                 } else {
                     NSLog(@"completion without tap");
                 }
                 [[HXToast sharedInstance] setCanShow:YES];
             }];

    }
    
    
}

+ (void)showToast:(UIView *)view msg:(NSString *)msg time:(NSTimeInterval)time {
    
    
    
    if ([[HXToast sharedInstance] canShow]) {
        [[HXToast sharedInstance] setCanShow:NO];
        [view makeToast:msg
               duration:time
               position:CSToastPositionCenter
                  title:nil
                  image:[UIImage imageNamed:@"toast.png"]
                  style:nil
             completion:^(BOOL didTap) {
                 if (didTap) {
                     NSLog(@"completion from tap");
                 } else {
                     NSLog(@"completion without tap");
                 }
                 [[HXToast sharedInstance] setCanShow:YES];
             }];
        
    }
    
    
}


+ (void)showToast:(UIView *)view customView:(UIView *)customView {
    
    if ([[HXToast sharedInstance] canShow]) {
        [[HXToast sharedInstance] setCanShow:NO];
        [view showToast:customView duration:ShowToastTime position:CSToastPositionCenter completion:^(BOOL didTap) {
            [[HXToast sharedInstance] setCanShow:YES];
        }];
    }
}

+ (void)showToast:(UIView *)view
              msg:(NSString *)msg
             time:(NSTimeInterval)time
         position:(HXToastPosition)position {
    
    if ([[HXToast sharedInstance] canShow]) {
        [[HXToast sharedInstance] setCanShow:NO];
        [view makeToast:msg
               duration:time
               position:HXPositionType(position)
                  title:nil
                  image:[UIImage imageNamed:@"toast.png"]
                  style:nil
             completion:^(BOOL didTap) {
                 if (didTap) {
                     NSLog(@"completion from tap");
                 } else {
                     NSLog(@"completion without tap");
                 }
                 [[HXToast sharedInstance] setCanShow:YES];
             }];
        
    }

    
}

+ (void)showToast:(UIView *)view
       customView:(UIView *)customView
             time:(NSTimeInterval)time
         position:(HXToastPosition)position {
    
    if ([[HXToast sharedInstance] canShow]) {
        [[HXToast sharedInstance] setCanShow:NO];
        [view showToast:customView duration:time position:HXPositionType(position) completion:^(BOOL didTap) {
            [[HXToast sharedInstance] setCanShow:YES];
        }];
    }

    
}




@end
