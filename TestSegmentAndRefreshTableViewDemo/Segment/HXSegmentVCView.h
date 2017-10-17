//
//  HXSegmentVCView.h
//  Catering
//
//  Created by Guohx on 2017/3/10.
//  Copyright © 2017年 howsur. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "HMSegmentedControl.h"
#import <HMSegmentedControl/HMSegmentedControl.h>


#define HXSegmentDefaultH 40.0f
/**
 分段控件视图
 */
@interface HXSegmentVCView : UIViewController

//@property (nonatomic, assign) CGFloat segmentHeight;


@property (nonatomic, strong) HMSegmentedControl * segmentedControl;
@property (nonatomic, assign) NSInteger defaultIndex;

+ (CGFloat)getHeight;
- (instancetype)initWithTitleArr:(NSArray *)titleArr contentVCArr:(NSMutableArray<UIViewController *> *)contentVCArr;

- (void)setSegSelect:(void(^)(UIViewController * vc, NSInteger index))block;
- (void)setSegTitle:(NSString *)title index:(NSInteger)index;

//default custom Rewrite this,like this.
- (void)defaultStyle;
//{
//    self.segmentedControl.borderWidth = 3.0f;
//    
//    //竖直分割线
//    //    self.segmentedControl.verticalDividerEnabled = YES;
//    //    self.segmentedControl.verticalDividerWidth = 0.5f;
//    
//    //底部选中 高度
//    self.segmentedControl.selectionIndicatorHeight = 3.0f;
//    
//    
//    //选项卡标题组
//    self.segmentedControl.sectionTitles = _titleArr;
//    
//    //默认选择索引
//    self.segmentedControl.selectedSegmentIndex = 0;
//    
//    //选项卡背景颜色
//    self.segmentedControl.backgroundColor = [UIColor whiteColor];
//    //选项卡 选中与未选中 的属性
//    self.segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : HXSegmentFont_color,NSFontAttributeName : HXSegmentFont};
//    self.segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : HXSegmentFont_select_color,NSFontAttributeName : HXSegmentFont};
//    
//    //选中状态 的 指示颜色
//    self.segmentedControl.selectionIndicatorColor = HXSegmentFont_select_color;
//    
//    //选中状态 指示类型
//    self.segmentedControl.selectionStyle =
//    //HMSegmentedControlSelectionStyleFullWidthStripe;// 屏幕按选项卡 数量均分
//    HMSegmentedControlSelectionStyleTextWidthStripe; //文字长度 (和 selectionIndicatorEdgeInsets搭配使用)
//    //底部选中宽度
//    self.segmentedControl.selectionIndicatorEdgeInsets = UIEdgeInsetsMake(0, - 20, 0, - 40);
//    
//    self.segmentedControl.selectionIndicatorLocation =
//    HMSegmentedControlSelectionIndicatorLocationDown; //选择的选项卡 位置 方向
//    //HMSegmentedControlSelectionIndicatorLocationUp;
//    
//    // 边缘 现在是 底部 线
//    self.segmentedControl.borderType = HMSegmentedControlBorderTypeBottom;
//    self.segmentedControl.borderColor = [UIColor lightGrayColor];
//    self.segmentedControl.borderWidth = 0.5;
//}



@end
