//
//  HXTableView.m
//  TestSegmentAndRefreshTableViewDemo
//
//  Created by Guohx on 2017/5/3.
//  Copyright © 2017年 ghx. All rights reserved.
//

#import "HXTableView.h"
#import "MJRefreshGifHeader.h"

@interface HXTableView()
<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, getter=isLoading) BOOL loading;

@property (nonatomic, copy) HXEmptyClick hxEmptyClick;

@end

@implementation HXTableView

#pragma mark- init
-(instancetype)init{
    if (self = [super init]) {
        [self defaultSetting];
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super initWithCoder:aDecoder]) {
        [self defaultSetting];
    }
    
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self defaultSetting];
    }
    
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self =[super initWithFrame:frame style:style]) {
        [self defaultSetting];
    }
    
    return self;
}

- (void)setHxDelegate:(id<HXTableViewDelegate>)hxDelegate {
    _hxDelegate = hxDelegate;
    self.delegate = (id<UITableViewDelegate>)_hxDelegate;
    self.dataSource = (id<UITableViewDataSource>)_hxDelegate;

}
#pragma mark- Public Setting
- (void)setHiddenExtraLine:(BOOL)hiddenExtraLine {
    _hiddenExtraLine = hiddenExtraLine;
    [self setExtraCellLineHidden:self];
}

- (void)setShowEmpty:(BOOL)showEmpty {
    _showEmpty = showEmpty;
}
- (void)setEmptyAllowTouch:(BOOL)emptyAllowTouch {
    _emptyAllowTouch = emptyAllowTouch;
}
- (void)setEmptyAllowScroll:(BOOL)emptyAllowScroll {
    _emptyAllowScroll = emptyAllowScroll;
}

- (void)setEmptyAllowImageViewAnimate:(BOOL)emptyAllowImageViewAnimate {
    _emptyAllowImageViewAnimate = emptyAllowImageViewAnimate;
}

- (void)hxTableViewEmptyClick:(HXEmptyClick)hxEmptyClick {
    self.hxEmptyClick = hxEmptyClick;
}

- (void)setRefreshGifImageArr:(NSMutableArray<NSString *> *)refreshGifImageArr {
    _refreshGifImageArr = refreshGifImageArr;
    if (refreshGifImageArr.count) {
        [self setRefreshHeader];
    }
}


#pragma mark- Default Setting
- (void)defaultSetting {
    self.hiddenExtraLine = YES;
    
    self.tableFooterView                = [UIView new];
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator   = NO;
    
    
    //empty page
    self.showEmpty = YES;
    self.emptyAllowScroll = YES;
    self.emptyAllowTouch = NO;
    self.emptyAllowImageViewAnimate = NO;
    
    self.emptyDataSetSource = self;
    self.emptyDataSetDelegate = self;
    self.emptyImage = [UIImage imageNamed:@"empty_placeholder"];
    self.emptyColor = [UIColor whiteColor];
//    self.emptyTitle = @"没有数据啦";
//    self.emptySubtitle = @"没有数据的描述";
//    self.emptyButtontitle = @"点击界面重新加载";
    
//    self.customEmptyView = ({
//        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//            [activityView startAnimating];
//            activityView;
//    });
    
    // A little trick for removing the cell separators
    self.tableFooterView = [UIView new];
    
    self.hxCanLoadState  = HXCanLoadNone;
    self.refreshGifImageArr = nil;
    self.page                           = 1;
    self.pageNum = 10;

}


#pragma mark - Table view data source
#pragma mark -TableView DataSource

#pragma mark TableView Delegate

- (void)setExtraCellLineHidden: (UITableView *)tableView{
    
    //隐藏多余的cell分割线
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:(_hiddenExtraLine)?view:nil];
//    [tableView setTableHeaderView:(_hiddenExtraLine)?view:nil];
    
}

#pragma mark- Empty page
#pragma mark - DZNEmptyDataSetSource Methods

//nil 图片

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return self.emptyImage;
}
//nil标题
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.emptyAtrtibutedTitle) {
        return self.emptyAtrtibutedTitle;
    }
    
    if (!self.emptyTitle) {
        return nil;
    }

    
    NSString *text =self.emptyTitle;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
//nil描述
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.emptyAtrtibutedSubtitle) {
        return self.emptyAtrtibutedSubtitle;
    }
    
    if (!self.emptySubtitle) {
        return nil;
    }
    
    NSString *text = self.emptySubtitle;
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:17.0f],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
//按钮刷新
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    if (self.emptyAtrtibutedButtonTitle) {
        return self.emptyAtrtibutedButtonTitle;
    }
    
    if (!self.emptyButtontitle) {
        return nil;
    }
    
    NSString *text = nil;
    UIFont *font = nil;
    UIColor *textColor = nil;
    text = self.emptyButtontitle;
    font = [UIFont boldSystemFontOfSize:16.0];
    textColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];

    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
//or the image to be used for the specified button state:
- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    return nil;//[UIImage imageNamed:@"button_image"];
}
//The background color for the empty state:
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return self.emptyColor;
}
//自定义界面，这个有写默认的就失效了
- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView
{
//    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    [activityView startAnimating];
//    return activityView;
    if (self.customEmptyView) {
        return self.customEmptyView;
    }
    return nil;
    
}
//The image view animation
- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"transform"];
    
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0)];
    
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    
    return animation;
}
//Additionally, you can also adjust the vertical alignment of the content view (ie: useful when there is tableHeaderView visible):
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return self.tableHeaderView.frame.size.height/2.0f;
}
//Finally, you can separate components from each other (default separation is 11 pts):
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView
{
    return 20.0f;
}
#pragma mark - DZNEmptyDelegate
//Delegate Implementation
//Return the behaviours you would expect from the empty states, and receive the user events.
//Asks to know if the empty state should be rendered and displayed (Default is YES) :

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return self.showEmpty;
}
//Asks for interaction permission (Default is YES) :
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return self.emptyAllowTouch;
}
//Asks for scrolling permission (Default is NO) :
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return self.emptyAllowScroll;
}
//Asks for image view animation permission (Default is NO) :
- (BOOL)emptyDataSetShouldAllowImageViewAnimate:(UIScrollView *)scrollView
{
    return self.emptyAllowImageViewAnimate;
}
//nil界面点击
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    // Do something
    if (self.hxEmptyClick) {
        self.hxEmptyClick();
    }
}
//nil按钮点击
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    // Do something
    if (self.hxEmptyClick) {
        self.hxEmptyClick();
    }

}
#pragma mark-
#pragma mark- Refresh

#pragma  mark public methods
-(void)setHxCanLoadState:(HXCanLoadState)hxCanLoadState{
    _hxCanLoadState = hxCanLoadState;
    switch (_hxCanLoadState) {
        case HXCanLoadAll:{
            [self setRefreshHeader];
            [self setRefreshFooter];
        }break;
        case HXCanLoadRefresh:{
            [self setRefreshHeader];
            self.mj_footer = nil;
        }break;
        case HXCanLoadNone:{
            self.mj_header = nil;
            self.mj_footer = nil;
        }break;
    }
}
-(void)beginLoading{
    //[self.mj_header beginRefreshing];
    [self.mj_header beginRefreshingWithCompletionBlock:^{
        if (_showEmpty) {
            self.emptyDataSetDelegate = self;
            self.emptyDataSetSource   = self;
        }
    }];
}
-(void)endLoading{
    if([self.mj_header isRefreshing]){
        [self.mj_header endRefreshingWithCompletionBlock:^{
            [self hx_reloadData];
        }];
    }
    if ([self.mj_footer isRefreshing])
        [self.mj_footer endRefreshingWithCompletionBlock:^{
            [self hx_reloadData];
        }];
}
-(void)noMoreData{
    if ([self.mj_footer isRefreshing])
        [self.mj_footer endRefreshingWithNoMoreData];
}
-(NSNumber *)getCurrentPage {
    return [NSNumber numberWithInteger:++self.page];
}
#pragma mark private methods
-(void)setRefreshHeader{//设置RefreshHeader
    if (self.refreshGifImageArr.count) {
        MJRefreshGifHeader  *gifHeader = [[MJRefreshGifHeader alloc] init];
        
        NSMutableArray *refreshingImages = [NSMutableArray array];
        for (NSUInteger i = 0; i < self.refreshGifImageArr.count; i++) {
            UIImage *image = [UIImage imageNamed:self.refreshGifImageArr[i]];
            [refreshingImages addObject:image];
        }
        
        [gifHeader setImages:[NSMutableArray arrayWithObject:refreshingImages[0]] forState:MJRefreshStateIdle];
        [gifHeader setImages:refreshingImages forState:MJRefreshStatePulling];
        [gifHeader setImages:refreshingImages forState:MJRefreshStateRefreshing];

        // 隐藏时间
        gifHeader.lastUpdatedTimeLabel.hidden = YES;

        [gifHeader setRefreshingTarget:self refreshingAction:@selector(refreshData)];
        self.mj_header = gifHeader;
    }else{
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self  refreshData];
        }];
    }
    self.mj_header.multipleTouchEnabled = NO;
    
    
}
-(void)setRefreshFooter{//设置RefreshFooter
    self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self pullData];
    }];
    self.mj_footer.multipleTouchEnabled = NO;
    self.mj_footer.hidden = YES;
}
-(BOOL)isEmptyTableView{//判断当前tableView是否为空
    id<UITableViewDataSource> src = self.dataSource;
    NSInteger sections = 1;
    if (src && [src respondsToSelector: @selector(numberOfSectionsInTableView:)]) {
        sections = [src numberOfSectionsInTableView:self];
    }
    for (NSInteger i = 0; i < sections; ++i) {
        NSInteger rows = [src tableView:self numberOfRowsInSection:i];
        if (rows > 0) {
            return NO;
        }
    }
    
    return YES;
}

-(void)hx_reloadData{
    [self reloadData];
    if (self.hxCanLoadState == HXCanLoadAll && [self isEmptyTableView]) {
        self.mj_footer.hidden = YES;
    }else if(self.hxCanLoadState == HXCanLoadAll){
        self.mj_footer.hidden = NO;
    }
}
-(void)refreshData{//下拉刷新
    if (self.mj_footer.state == MJRefreshStateNoMoreData) {
        [self.mj_footer resetNoMoreData];
    }
    if (_hxDelegate && [_hxDelegate respondsToSelector:@selector(loadDataRefreshOrPull:)]) {
        self.page = 1;
        [_hxDelegate loadDataRefreshOrPull:HXRefreshing];
    }
}
-(void)pullData{//加载更多
    if (_hxDelegate && [_hxDelegate respondsToSelector:@selector(loadDataRefreshOrPull:)]) {
        [_hxDelegate loadDataRefreshOrPull:HXPulling];
    }
}

#pragma mark-
@end
