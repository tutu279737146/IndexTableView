//
//  ViewController.m
//  indexTableView
//
//  Created by A on 2020/1/14.
//  Copyright © 2020 A. All rights reserved.
//

#import "ViewController.h"
#import "IndexedTableView.h"

@interface ViewController ()<
UITableViewDelegate,
UITableViewDataSource,
IndexedTableViewDataSource
>

@property (nonatomic, strong) IndexedTableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) UIButton *changeButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[IndexedTableView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height - 60) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.indexedDataSource = self;
    [self.view addSubview:self.tableView];
    
    self.changeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 40)];
    self.changeButton.backgroundColor = [UIColor redColor];
    [self.changeButton setTitle:@"reloadTable" forState:UIControlStateNormal];
    [self.changeButton addTarget:self action:@selector(changeState:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.changeButton];
    
    self.dataSource = [NSMutableArray arrayWithCapacity:100];
    for (int i = 0; i < 100; i ++) {
        [self.dataSource addObject:@(i+1)];
    }
}
//MARK:  索引个数
- (NSArray<NSString *> *)indexTitlesForIndexedTableView:(UITableView *)tableView{
    //奇数次调用返回6个字母，偶数次调用返回11个
    static BOOL change = NO;
    if (change) {
        change = NO;
        return @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K"];
    }else{
        change = YES;
        return @[@"A",@"B",@"C",@"D",@"E",@"F"];
    }
}
//MARK:  dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"reuseId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    //如果重用池当中没有可重用的cell，那么创建一个cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    // 文案设置
    cell.textLabel.text = [[self.dataSource objectAtIndex:indexPath.row] stringValue];
    //返回一个cell
    return cell;
}
//MARK:  Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

//MARK:  模拟
- (void)changeState:(id)sender{
    NSLog(@"reloadData");
    [self.tableView reloadData];
}
@end
