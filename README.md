# 支持 IOS7+  详见Demo
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

# 使用 HXTableView
```
pod 'HXTableView'
```
```
- (void)initUI {
    CGRect tableVFrame = self.view.frame;
    tableVFrame.size.height = tableVFrame.size.height;
    
    tableV = [[HXTableView alloc] initWithFrame:tableVFrame style:UITableViewStylePlain];
    
//    tableV.hiddenExtraLine = YES; //default

//空页面设置
    tableV.emptyImage = [UIImage imageNamed:@"icon_refresh_1@2x"];
//    tableV.emptyTitle = @"121222";
    tableV.emptySubtitle = @"描述";
//    tableV.emptyButtontitle = @"按钮啊";
    
    tableV.hxDelegate = self;
    
    [self.view addSubview:tableV];
    
    //空页面点击 刷新
//    tableV.emptyAllowTouch = YES;
//    [tableV hxTableViewEmptyClick:^{
//        NSLog(@"点击了空页面 ，执行刷新");
//        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            dataArr = [NSMutableArray arrayWithArray:@[@"1",@"2"]];
//            [tableV reloadData];
//        });
//
//        
//    }];
   
    dataArr = nil;
    
    //刷新 gif 图片
//    tableV.refreshGifImageArr = [NSMutableArray arrayWithArray:@[@"icon_refresh_1",@"icon_refresh_2",@"icon_refresh_3"]];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        tableV.refreshGifImageArr = nil;
//    });
    tableV.hxCanLoadState = HXCanLoadAll;
    
}

HX_TABLEVIEW_SepInset(0, 0,tableV)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CustomCell";
    //自定义cell类
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = dataArr[indexPath.row];
    
    //选中状态
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //指示类型
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}

#pragma mark hxTableViewDelegate
-(void)loadDataRefreshOrPull:(HXRefreshState)state {
    
    [self requestTest:state];
    
}


#pragma mark- Request simulate
- (void)requestTest:(HXRefreshState)state {
    
#warning 正常情况下 都是 一页一页的取数据 如下
    NSMutableArray * tmpDataArr = [NSMutableArray arrayWithArray:
                                   @[
                                     @[@"1",@"2"],
                                     @[@"3",@"4"],
                                     @[@"5"]
                                     ]
                                   ];

    
#warning 成功的情况下
    
    NSArray * currDataArr = tmpDataArr[tableV.page]; //获取到的分页数据
    
    if (state == HXRefreshing) { //下拉
        
        dataArr = [NSMutableArray arrayWithArray:tmpDataArr[0]];
        
    } else  { //上拉
        
        [tableV getCurrentPage]; //page + 1，也可通过获取的page赋值
        
        NSMutableArray * tmpArr = [NSMutableArray array];
        if (currDataArr.count >= tableV.pageNum) {
            [dataArr addObjectsFromArray:currDataArr];
        } else {
            [dataArr addObjectsFromArray:currDataArr];
            [tableV noMoreData];
        }
        [dataArr addObjectsFromArray:tmpArr];
        
    }
    [tableV endLoading];
    
    
  
```
# 使用 分段控件
```
pod 'HXSegment'
```
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
