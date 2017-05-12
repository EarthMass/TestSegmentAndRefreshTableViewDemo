//
//  ProgressHUD.m
//  Lift
//
//  Created by Guohx on 16/11/17.
//  Copyright © 2016年 howsur. All rights reserved.
//

#import "HXProgressHUD.h"

@implementation HXProgressHUD

+ (void)initialize {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.3]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
}

#pragma mark - 需要dismiss
+ (void)showHUD {
    
    [SVProgressHUD show];
}

+ (void)showHUDDefault {
     
    [SVProgressHUD showWithStatus:msg];
}

+ (void)showWithStatus:(NSString*)string {
     
    [SVProgressHUD showWithStatus:string];
}



#pragma mark - 不需要dismiss
+ (void)showImage:(UIImage*)image status:(NSString*)string {
     
    [SVProgressHUD showImage:image status:string];
}

+ (void)showWithStatus:(NSString*)string duration:(NSTimeInterval)duration {
     
    [SVProgressHUD showWithStatus:msg];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

#pragma mark - dismiss
+ (void)dismissHUD {
    [SVProgressHUD dismiss];
}


+ (void)dismissHUD:(UIImage *)image status:(NSString*)string {
    [SVProgressHUD showImage:image status:string];
    [SVProgressHUD dismissWithDelay:1.0];
}

+ (void)dismissHUD:(UIImage *)image {
    [SVProgressHUD showImage:image status:nil];
    [SVProgressHUD dismissWithDelay:1.0];
}

#pragma mark- style
+ (void)setDefaultStyle {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.3]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
}


@end


