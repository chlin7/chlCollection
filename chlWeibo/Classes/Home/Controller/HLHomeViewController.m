//
//  HLHomeViewController.m
//  chlWeibo
//
//  Created by chlin7 on 15-6-3.
//  Copyright (c) 2015年 chlin7. All rights reserved.
//

#import "HLHomeViewController.h"
#import "UIBarButtonItem+HL.h"
#import "HLTitleButton.h"
#import "HLAccountTool.h"
#import "HLAccount.h"
#import "MJExtension.h"
#import "HLStatus.h"
#import "HLUser.h"
#import "HLStatusFrame.h"
#import "HLStatusCell.h"

//微博数据url
#define urlDef @"https://api.weibo.com/2/statuses/home_timeline.json"


@interface HLHomeViewController ()

//微博的frame数组
@property(nonatomic,strong)NSArray *statusFrames;

@end

@implementation HLHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    [self setupNavBar];
    //加载微博数据
    [self setupStatusData];
}
/**
 *  设置导航栏
 */
-(void)setupNavBar{
    //导航左边自定义图片按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_friendsearch" highIcon:@"navigationbar_friendsearch_highlighted"  target:self action:@selector(leftBtnItemClick)];
    //导航右边自定义图片按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_pop" highIcon:@"navigationbar_pop_highlighted"  target:self action:@selector(rightBtnItemClick)];
    //设置中间的按钮
    HLTitleButton *titleBtn = [[HLTitleButton alloc] init];
    //图标
    [titleBtn setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    //文字
    [titleBtn setTitle:@"哈哈哈" forState:UIControlStateNormal];
    titleBtn.frame = CGRectMake(0, 0, 100, 40);
    
    [titleBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleBtn;
}
/**
 *  获取微博数据
 */
-(void)setupStatusData{
    
    //1.0 创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //2.0 封装请求对象
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[HLAccountTool account].access_token forKey:@"access_token"];
    [params setObject:@10 forKey:@"count"];
    //3.0 发送请求
    [mgr GET:urlDef parameters:params success:^(AFHTTPRequestOperation *operation,id responseObject){
        NSArray *dicArray = [responseObject objectForKey:@"statuses"];
        
//        NSMutableArray *statusArray = [NSMutableArray array];
//        for (NSDictionary *dict in dicArray) {
//            //使用MJExtension.h框架字典自动转模型
//            HLStatus *status = [HLStatus objectWithKeyValues:dict];
//            [statusArray addObject:status];
//        }
        //使用MJExtension.h框架字典数组自动转模型数组
        NSArray * statusArray = [HLStatus objectArrayWithKeyValuesArray:dicArray];
        //创建frame模型
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for (HLStatus *status in statusArray) {
            HLStatusFrame *statusFrame = [[HLStatusFrame alloc] init];
            //传递微博数据模型
            statusFrame.status = status;
            [statusFrameArray addObject:statusFrame];
        }
        //赋值
        self.statusFrames = statusFrameArray;
        
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DEBUGLog(@"++++++++++++++++++");
    }];
}

- (void)titleClick:(HLTitleButton *)titleButton
{
    if (titleButton.selected) {
        titleButton.selected = NO;
        [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    }else{
        titleButton.selected = YES;
        [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    }
}
-(void)leftBtnItemClick{
    DEBUGLog(@"HLHomeViewController  ----leftBtnItemClick");
}
-(void)rightBtnItemClick{
    DEBUGLog(@"HLHomeViewController  ----rightBtnItemClick");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusFrames.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HLStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    return statusFrame.cellHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //1.创建cell
    HLStatusCell *cell = [HLStatusCell cellWithTableView:tableView];
    //2.设置cell数据
    cell.statusFrame = self.statusFrames[indexPath.row];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
