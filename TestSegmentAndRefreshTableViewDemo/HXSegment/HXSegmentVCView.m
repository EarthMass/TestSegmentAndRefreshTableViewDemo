 //
//  HXSegmentVCView.m
//  Catering
//
//  Created by Guohx on 2017/3/10.
//  Copyright © 2017年 howsur. All rights reserved.
//

#import "HXSegmentVCView.h"

//#define HXSegmentDefaultH 40.0f
#define HXSegmentFont_select_color [UIColor colorWithRed:0.984 green:0.429 blue:0.077 alpha:1.000]
#define HXSegmentFont_color [UIColor blackColor]
#define HXSegmentFont [UIFont systemFontOfSize:16]


#define HX_SEG_SCREEN_WIDTH ([[UIScreen mainScreen]bounds].size.width)
#define HX_SEG_SCREEN_HEIGHT ([[UIScreen mainScreen]bounds].size.height)
#define HX_SEG_SCREEN_WITHOUT_STATUS_HEIGHT (SCREEN_HEIGHT - [[UIApplication sharedApplication] statusBarFrame].size.height)






@interface HXSegmentVCView ()<UIScrollViewDelegate>


@property (nonatomic, strong) NSArray * titleArr;
@property (nonatomic, strong) NSArray * contentVCArr;

@property (nonatomic, strong) UIViewController * currVc;

@property(nonatomic,copy) void(^dataRefreshBlock)(void);

@property(nonatomic,copy) void(^segSelectBlock)(UIViewController * vc, NSInteger index);

@end



@implementation HXSegmentVCView


#pragma mark- Cycle Life
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSeg];
    [self initVcs];
    
}

//- (void)viewDidLayoutSubviews {
//    [super viewDidLayoutSubviews];
//
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- init
- (instancetype)initWithTitleArr:(NSArray *)titleArr contentVCArr:(NSMutableArray<UIViewController *> *)contentVCArr {
    if (self = [super init]) {
        
        NSAssert(_titleArr.count != contentVCArr.count, @"HXSegmentVCView _titleArr.count must equal to contentVCArr.count");
        
        _titleArr = [NSMutableArray arrayWithArray:titleArr];
        self.contentVCArr = [NSArray arrayWithArray:contentVCArr];
    }
    return self;
}
- (void)initSeg {
    
    CGFloat segH = HXSegmentDefaultH;
    
    //顶部选项卡初始化化
    self.segmentedControl = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, 0, HX_SEG_SCREEN_WIDTH, segH)];
    
    //default style
    [self defaultStyle];
    
    
    //改变选择 block
    __block typeof(self) weakSelf = self;
    [self.segmentedControl setIndexChangeBlock:^(NSInteger index) {
        //选项卡点击
        [weakSelf transitionViewIndex:index];
        if (weakSelf.segSelectBlock) {
            weakSelf.segSelectBlock(weakSelf.currVc,index);
        }
        
    }];
    [self.view addSubview:self.segmentedControl];

    self.view.clipsToBounds = YES;
}

- (void)initVcs {
    
    NSAssert( self.contentVCArr.count != 0,@"HXSegmentVCView self.contentVCArr can't be nil");
    
    for (int i = 0;i < self.contentVCArr.count; i++) {
        UIViewController * vc = self.contentVCArr[i];
        [self operateVcToBaseVC:vc];
    }
    self.currVc = [self.contentVCArr lastObject]; //最后一个添加的
    self.defaultIndex = 0;
}

#pragma mark- Other
- (void)operateVcToBaseVC:(UIViewController *)originVc {
    [self getNewFrame:originVc];
    [self addChildView:originVc];
}

- (void)getNewFrame:(UIViewController *)originVc {
    CGRect frame = originVc.view.frame;
    frame.origin.y =  HXSegmentDefaultH;
    frame.size.height =  self.view.frame.size.height - HXSegmentDefaultH;
    originVc.view.frame = frame;
}

- (void)addChildView:(UIViewController *)orginVc  {
    [self addChildViewController:orginVc];
    [self.view addSubview:orginVc.view];
}

- (void)transitionViewIndex:(NSInteger)index {
    UIViewController * vc = self.contentVCArr[index];
    
    if (vc == self.currVc) {
        return;
    }
    
    [self transitionFromViewController:self.currVc toViewController:vc duration:0.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        self.currVc = vc;
    }];
    
}

#pragma mark- Delegate
#pragma mark- Settting getting
//- (void)setSegmentHeight:(CGFloat)segmentHeight {
//    _segmentHeight = segmentHeight;
//    [self.view setNeedsLayout];
//    
//}

- (void)setDefaultIndex:(NSInteger)defaultIndex {
    if (defaultIndex < 0) {
        defaultIndex = 0;
    }
    if (defaultIndex > self.contentVCArr.count - 1) {
        defaultIndex = self.contentVCArr.count - 1;
    }
    
    _defaultIndex = defaultIndex;
    self.segmentedControl.selectedSegmentIndex = _defaultIndex;
    [self transitionViewIndex:defaultIndex];
}

//- (void)dataRefresh:(void(^)(void))dataRefreshBlock {
//    self.dataRefreshBlock = dataRefreshBlock;
//}

#pragma mark- Public
+ (CGFloat)getHeight {
    return HXSegmentDefaultH;
}


- (void)setSegSelect:(void(^)(UIViewController * vc, NSInteger index))block {
    self.segSelectBlock = block;
}
- (void)setSegTitle:(NSString *)title index:(NSInteger)index {
    if (index >= 0 && index < self.segmentedControl.sectionTitles.count) {
        NSMutableArray * segTitles = [NSMutableArray arrayWithArray:self.segmentedControl.sectionTitles];
        [segTitles replaceObjectAtIndex:index withObject:title];
        [self.segmentedControl setSectionTitles:segTitles];
        [self.segmentedControl setNeedsDisplay];
    }
}

/**
 默认选项卡样式
 */
- (void)defaultStyle
{
    self.segmentedControl.borderWidth = 3.0f;
    
    //竖直分割线
    //    self.segmentedControl.verticalDividerEnabled = YES;
    //    self.segmentedControl.verticalDividerWidth = 0.5f;
    
    //底部选中 高度
    self.segmentedControl.selectionIndicatorHeight = 3.0f;
    
    
    //选项卡标题组
    self.segmentedControl.sectionTitles = _titleArr;
    
    //默认选择索引
    self.segmentedControl.selectedSegmentIndex = 0;
    
    //选项卡背景颜色
    self.segmentedControl.backgroundColor = [UIColor whiteColor];
    //选项卡 选中与未选中 的属性
    self.segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : HXSegmentFont_color,NSFontAttributeName : HXSegmentFont};
    self.segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : HXSegmentFont_select_color,NSFontAttributeName : HXSegmentFont};
    
    //选中状态 的 指示颜色
    self.segmentedControl.selectionIndicatorColor = HXSegmentFont_select_color;
    
    //选中状态 指示类型
    self.segmentedControl.selectionStyle =
     //HMSegmentedControlSelectionStyleFullWidthStripe;// 屏幕按选项卡 数量均分
       HMSegmentedControlSelectionStyleTextWidthStripe; //文字长度 (和 selectionIndicatorEdgeInsets搭配使用)
    //底部选中宽度
    self.segmentedControl.selectionIndicatorEdgeInsets = UIEdgeInsetsMake(0, - 20, 0, - 40);
    
    self.segmentedControl.selectionIndicatorLocation =
    HMSegmentedControlSelectionIndicatorLocationDown; //选择的选项卡 位置 方向
    //HMSegmentedControlSelectionIndicatorLocationUp;
    
    // 边缘 现在是 底部 线
    self.segmentedControl.borderType = HMSegmentedControlBorderTypeBottom;
    self.segmentedControl.borderColor = [UIColor colorWithWhite:0.890 alpha:1.000];
    self.segmentedControl.borderWidth = 0.5;
}


@end
