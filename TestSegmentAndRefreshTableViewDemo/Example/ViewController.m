//
//  ViewController.m
//  TestSegmentAndRefreshTableViewDemo
//
//  Created by Guohx on 2017/4/10.
//  Copyright © 2017年 ghx. All rights reserved.
//

#import "ViewController.h"

#import "SegVC.h"
#import "CustomTableVC.h"
#import "ProgressAndToastVC.h"


@interface ViewController ()<UITableViewDelegate, UITableViewDataSource> {
    UITableView * tableV;
    NSArray * dataArr;
    NSArray * classArr;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.title = @"测试";
    
    [self initMainTableV];
    [self initData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#define HX_SEG_SCREEN_HEIGHT ([[UIScreen mainScreen]bounds].size.height)
#pragma mark- initUI
- (void)initMainTableV {
    CGRect tableVFrame = self.view.frame;
    tableVFrame.size.height = tableVFrame.size.height;
    
    tableV = [[UITableView alloc] initWithFrame:tableVFrame style:UITableViewStylePlain];
    tableV.delegate = self;
    tableV.dataSource = self;
    [self setExtraCellLineHidden:tableV];
    [self.view addSubview:tableV];
    
    //tableV 顶格了
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    CGFloat navBarHeight = CGRectGetMaxY(self.navigationController.navigationBar.frame);
//    
//    UIView * aa = [[UIView alloc] initWithFrame:CGRectMake(0, navBarHeight, 100, HX_SEG_SCREEN_HEIGHT - navBarHeight)];
//    aa.backgroundColor = [UIColor redColor];
//    [self.view addSubview:aa];
    
}

- (void)initData {
    dataArr = @[@"SegDemo 选项卡",@"HXTableV 高效tableV",@"提示框"];
    classArr = @[[SegVC class],[CustomTableVC class],[ProgressAndToastVC class]];
}

#pragma mark -TableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"MainCell";
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

#pragma mark TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //点击cell操作
    [self.navigationController pushViewController:[[[classArr objectAtIndex:indexPath.row] alloc] init] animated:YES];
    
}

- (void)setExtraCellLineHidden: (UITableView *)tableView{
    //隐藏多余的cell分割线
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    //    [tableView setTableHeaderView:view];
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    //cell高度
//    return <#cellHeight#>;
//}


@end
