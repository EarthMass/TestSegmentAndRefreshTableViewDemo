//
//  HXTableView.h
//  TestSegmentAndRefreshTableViewDemo
//
//  Created by Guohx on 2017/5/3.
//  Copyright © 2017年 ghx. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MJRefresh/MJRefresh.h>
#import "MJRefreshAutoFooter.h"

#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h> //nil page


typedef void(^HXEmptyClick)(void);


typedef NS_ENUM(NSInteger, HXRefreshState) {
    
    HXRefreshing = 0, /** 下拉刷新的状态 */
    HXPulling,        /** pull 加载更多刷新中的状态 */
};

typedef NS_ENUM(NSInteger,HXCanLoadState) {
    
    HXCanLoadNone = 0,/**不支持下拉和加载更多*/
    HXCanLoadRefresh, /**只支持下拉刷新 default*/
    HXCanLoadAll,     /** 同时支持下拉和加载更多 */
};


@protocol HXTableViewDelegate <UITableViewDataSource, UITableViewDelegate>
@required
/**@param state Refreshing 下拉刷新 Pulling 为 Pull 加载更多*/
-(void)loadDataRefreshOrPull:(HXRefreshState)state;


@end

/**
 UITableView Easy to User, With Head and Foot Refresh
 */
@interface HXTableView : UITableView

@property (nonatomic, assign) IBInspectable BOOL hiddenExtraLine; //default hidden

#pragma mark- Refreshing Setting Param
/** HXTableView 加载支持，默认同时支持下拉和加载更多*/
@property (nonatomic,assign) IBInspectable HXCanLoadState hxCanLoadState; //HXCanLoadRefresh
@property (nonatomic,strong) IBInspectable NSMutableArray<NSString *> * refreshGifImageArr;
/**  当前访问的page 下标*/
@property (nonatomic,assign) NSInteger page; //default 1
@property (nonatomic,assign) NSInteger pageNum; //default 10

@property(nonatomic, weak) IBInspectable id<HXTableViewDelegate> hxDelegate;

/** 获取当下访问接口Page下标 默认从1开始 以来代替控制器计算Page*/
-(NSNumber *)getCurrentPage;
/** 开始加载*/
-(void)beginLoading;
/**结束加载，并刷新数据*/
-(void)endLoading;
/**提示无更多数据*/
-(void)noMoreData;



#pragma mark- EmptyView Setting Param
/** 是否展示空白页 默认为YES*/
@property(nonatomic,assign,getter = isShowEmpty) BOOL showEmpty; //YES
@property(nonatomic,assign) BOOL emptyAllowTouch; //default NO
@property(nonatomic,assign) BOOL emptyAllowScroll; //YES
@property(nonatomic,assign) BOOL emptyAllowImageViewAnimate; //YES

/**空白页的标题 默认为 “" 为空,不显示*/
@property(nonatomic,copy) IBInspectable NSString *emptyTitle;
/**  空白页的副标题 默认为 “" 为空,不显示*/
@property(nonatomic,copy) IBInspectable NSString *emptySubtitle;

/**  空白页的按钮标题 默认为 “" 为空,不显示*/
@property(nonatomic,copy) IBInspectable NSString *emptyButtontitle;

/**  空白页展位图名称 默认为 nil,不显示*/
@property(nonatomic,strong) IBInspectable UIImage *emptyImage;
/**  空白页背景颜色,默认白色*/
@property(nonatomic,strong) IBInspectable UIColor *emptyColor;

/**空白页的标题 默认为 nil,显示emptyTitle*/
@property(nonatomic,copy) IBInspectable NSAttributedString *emptyAtrtibutedTitle;
/**  空白页的副标题 默认为 nil,emptySubtitle*/
@property(nonatomic,copy) IBInspectable NSAttributedString *emptyAtrtibutedSubtitle;
/**  空白页的点击刷新按钮样式 默认为 nil,emptyAtrtibutedButtonTitle*/
@property(nonatomic,copy) IBInspectable NSAttributedString *emptyAtrtibutedButtonTitle;

/* ##### 自定义空白页 有设置的话，默认的就没掉了，优先执行这个 */
@property(nonatomic,strong) IBInspectable UIView * customEmptyView;

- (void)hxTableViewEmptyClick:(HXEmptyClick)hxEmptyClick;



/**
 *  tableView 分割线位置 默认（15，0）
 */
#define HX_TABLEVIEW_SepInset(left, right,tableV)  \
-(void)viewDidLayoutSubviews \
{ \
    if ([tableV respondsToSelector:@selector(setSeparatorInset:)]) { \
        [tableV setSeparatorInset:UIEdgeInsetsMake(0, left, 0, right)]; \
    } \
\
    if ([tableV respondsToSelector:@selector(setLayoutMargins:)]) { \
        [tableV setLayoutMargins:UIEdgeInsetsMake(0, left, 0, right)]; \
    } \
} \
\
 \
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath \
{ \
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) { \
        [cell setSeparatorInset:UIEdgeInsetsMake(0, left, 0, right)]; \
    } \
    \
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) { \
        [cell setLayoutMargins:UIEdgeInsetsMake(0, left, 0, right)]; \
    } \
}



@end



