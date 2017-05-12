# 支持 IOS7+ 
# TestSegmentAndRefreshTableViewDemo
多种功能集成，带Refresh刷新的tableV,Seg分段控件，加载提示toast
<br>##使用到了 
<br> pod 'HMSegmentedControl' ##分段控件
<br> pod 'MJRefresh'       ##上下拉刷新  
<br> pod 'DZNEmptyDataSet' ##空页面  
<br> pod 'SVProgressHUD'    ##加载中… 
<br> pod 'Toast'            ##Toast提示 

# 图片效果 
 ![image](https://github.com/EarthMass/TestSegmentAndRefreshTableViewDemo/blob/master/TestSegmentAndRefreshTableViewDemo.gif)

# 使用 
## 详见代码如seg
``` Object-C
//初始化 视图
NSMutableArray * contentVCArr = [NSMutableArray array];
for (int i = 0; i < 3; i ++) {

if (i < 2) {
ExampleTableVC * exampleTableVC = [[ExampleTableVC alloc] init];
exampleTableVC.view.backgroundColor = (i == 0)?[UIColor yellowColor]:[UIColor redColor];
[contentVCArr addObject:exampleTableVC];
} else {
UIViewController * exampleTableVC = [[UIViewController alloc] init];
exampleTableVC.view.backgroundColor = [UIColor greenColor];
[contentVCArr addObject:exampleTableVC];
}

}

HXSegmentVCView * seg = [[HXSegmentVCView alloc] initWithTitleArr:@[@"tableVC1",@"tableVC2",@"VC"] contentVCArr:contentVCArr];
seg.view.frame = CGRectMake(0, 64, HX_SEG_SCREEN_WIDTH, HX_SEG_SCREEN_HEIGHT - 64);
seg.defaultIndex = 1; //设置默认
[self.view addSubview:seg.view];

//改变标题
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
[seg setSegTitle:@"1212（1）" index:0];
});
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
[seg setSegTitle:@"1111（10）" index:1];
});

//点击事件回调
[seg setSegSelect:^(UIViewController *vc, NSInteger index) {
NSLog(@"seg click %ld",(long)index);
}];

```

# 联系我
<br>有什么问题，发邮件到(627556038@qq.com) 或者直接 提问题
