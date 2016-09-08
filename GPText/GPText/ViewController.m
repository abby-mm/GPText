//
//  ViewController.m
//  GPText
//
//  Created by dandan on 16/8/31.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "ViewController.h"
#import "GPAttributeViewController.h"
#import "GPPageViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSArray *dataS;
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@end

@implementation ViewController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self regisCell];
}

#pragma mark - 初始化
- (void)loadData
{
    self.dataS = @[@"富文本",@"分页显示文字"];
}
- (void)regisCell
{
    [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - 表格数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataS.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.dataS[indexPath.row];
    return cell;
}

#pragma mark - 表格的代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        GPAttributeViewController *attributeVc = GPSBVC(GPAttributeViewController);
        [self.navigationController pushViewController:attributeVc animated:YES];
    }else if (indexPath.row ==1){
        GPPageViewController *pageVc = GPSBVC(GPPageViewController);
        [self.navigationController pushViewController:pageVc animated:YES];
    }
}

@end
