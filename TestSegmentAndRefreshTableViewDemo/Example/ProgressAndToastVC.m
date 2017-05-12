//
//  ProgressAndToastVC.m
//  TestSegmentAndRefreshTableViewDemo
//
//  Created by Guohx on 2017/5/9.
//  Copyright © 2017年 ghx. All rights reserved.
//

#import "ProgressAndToastVC.h"
#import "HXProgressAndToast.h"

@interface ProgressAndToastVC ()<UITableViewDelegate, UITableViewDataSource> {
    UITableView * tableV;
    NSArray * titleArr;
}

@end

@implementation ProgressAndToastVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"提示框测试";
    
    titleArr = @[@"Toast center",@"Toast bottom",@"Toast Custom View",@"progress",@"progress withImage",@"progress dismiss",@"progress dismiss withImage"];
    
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)initUI {
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    CGRect tableVFrame = self.view.frame;
    tableVFrame.size.height = tableVFrame.size.height;
    
    tableV = [[UITableView alloc] initWithFrame:tableVFrame style:UITableViewStylePlain];
    tableV.delegate = self;
    tableV.dataSource = self;
    [self setExtraCellLineHidden:tableV];
    tableV.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tableV];
}

#pragma mark -TableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"ProgressTestCell";
    //自定义cell类
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = titleArr[indexPath.row];
    
    //选中状态
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //指示类型
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}

#pragma mark TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //点击cell操作
    
    [self showProgress:indexPath.row];
    
}

- (void)setExtraCellLineHidden: (UITableView *)tableView{
    //隐藏多余的cell分割线
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    //    [tableView setTableHeaderView:view];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //cell高度
    return 45.0;
}


#pragma mark- 测试方法
- (void)showProgress:(NSInteger)index {
    switch (index) {
            case 0: {
                [HXToast showToast:self.view msg:@"toast 展示"];
            }
            break;
            case 1: {
                [HXToast showToast:self.view.window msg:@"toast 底部展示" time:2.0 position:HXToastPositionBottom];
            }
            break;
            case 2: {
                [HXToast showToast:self.view customView:({
                    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
                    view.backgroundColor = [UIColor yellowColor];
                    
                    view;
                })];
            }
            break;
            //Progress
            case 3: {
                [HXProgressHUD showHUD];
            }
            break;
            case 4: {
                [HXProgressHUD showImage:[UIImage imageNamed:@"icon_refresh_1"] status:@"带图的啊"];
            }
            break;
            case 5: {
                [HXProgressHUD dismissHUD];
            }
            break;
            case 6: {
                [HXProgressHUD dismissHUD:[UIImage imageNamed:@"icon_refresh_1"] status:@"带图消失的啊"];
                
            }
            break;
            
        default:
            break;
    }
    
}


@end
