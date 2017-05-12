//
//  CustomTableVC.m
//  TestSegmentAndRefreshTableViewDemo
//
//  Created by Guohx on 2017/5/4.
//  Copyright © 2017年 ghx. All rights reserved.
//

#import "CustomTableVC.h"

#import "HXTableView.h"

@interface CustomTableVC ()<HXTableViewDelegate> {
    HXTableView * tableV;
    NSMutableArray * dataArr;
}

@end

@implementation CustomTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self initUI];
    
    //首次 获取数据
    [tableV beginLoading];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI {
    CGRect tableVFrame = self.view.frame;
    tableVFrame.size.height = tableVFrame.size.height;
    
    tableV = [[HXTableView alloc] initWithFrame:tableVFrame style:UITableViewStylePlain];
    
    tableV.hiddenExtraLine = YES; //default

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
    
    
    
    
    
    
//#warning 数据中截取数据测试   
//    NSMutableArray * tmpDataArr = [NSMutableArray array];
//    for (int i = 0; i < 3; i++) {
//        [tmpDataArr addObject:[NSString stringWithFormat:@"%d",i]];
//    }
//    
//#warning 成功的情况下
//    if (state == HXRefreshing) { //下拉
//        
//        if (tmpDataArr.count <= tableV.pageNum) {
//            dataArr = [NSMutableArray arrayWithArray:tmpDataArr];
//        } else {
//            dataArr = [NSMutableArray arrayWithArray:[tmpDataArr subarrayWithRange:NSMakeRange(0, tableV.pageNum)]];
//        }
//        
//    } else  { //上拉
//        
//        [tableV getCurrentPage]; //page + 1
//        
//        NSMutableArray * tmpArr = [NSMutableArray array];
//        if (tmpDataArr.count >= tableV.pageNum*tableV.page) {
//            tmpArr = [NSMutableArray arrayWithArray:[tmpDataArr subarrayWithRange:NSMakeRange((tableV.page - 1)*tableV.pageNum,tableV.pageNum)]];
//        } else {
//            
////            tmpArr = [NSMutableArray arrayWithArray:[tmpDataArr subarrayWithRange:NSMakeRange((tableV.page - 1)*tableV.pageNum,tableV.pageNum - (tableV.page*tableV.pageNum -  tmpDataArr.count))]];
////            [tableV noMoreData];
//            
//            if (tableV.pageNum*(tableV.page -1) < tmpDataArr.count) {
//                tmpArr = [NSMutableArray arrayWithArray:[tmpDataArr subarrayWithRange:NSMakeRange((tableV.page - 1)*tableV.pageNum,tableV.pageNum - (tableV.page*tableV.pageNum -  tmpDataArr.count))]];
//            } else {
//                [tableV noMoreData];
//            }
//        }
//        [dataArr addObjectsFromArray:tmpArr];
//        
//    }
//    [tableV endLoading];
    

}



@end
