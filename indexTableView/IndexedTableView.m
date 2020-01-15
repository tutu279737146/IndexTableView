//
//  IndexedTableView.m
//  indexTableView
//
//  Created by A on 2020/1/14.
//  Copyright © 2020 A. All rights reserved.
//

#import "IndexedTableView.h"
#import "ViewReusePool.h"

@interface IndexedTableView ()

// 容器
@property (nonatomic, strong) UIView *containerView;
// 重用池
@property (nonatomic, strong) ViewReusePool *reusePool;

@end

@implementation IndexedTableView

- (void)reloadData{
    [super reloadData];
    // 容器懒加载
    if (_containerView == nil) {
        _containerView = [[UIView alloc] initWithFrame:CGRectZero];
        _containerView.backgroundColor = [UIColor whiteColor];
        [self.superview insertSubview:_containerView aboveSubview:self];
    }
    // 重用池懒加载
    if (_reusePool == nil) {
        _reusePool = [[ViewReusePool alloc] init];
    }
    // 重置所有视图为可重用状态
    [_reusePool reset];
    // 刷新字母索引表
    [self reloadIndexedBar];
}

- (void)reloadIndexedBar{
    // 获取字母索引条显示内容
    NSArray <NSString *> *titleArr = nil;
    if ([self.indexedDataSource respondsToSelector:@selector(indexTitlesForIndexedTableView:)]) {
        titleArr = [self.indexedDataSource indexTitlesForIndexedTableView:self];
    }
    // 判断字母索引是否为空
    if (!titleArr || titleArr.count <= 0) {
        [_containerView setHidden:YES];
        return;
    }
    NSUInteger count = titleArr.count;
    CGFloat buttonWidth = 60;
    CGFloat buttonHeight = self.frame.size.height / count;
    
    for (int i = 0; i < [titleArr count]; i ++) {
        NSString *title = [titleArr objectAtIndex:i];
        // 重用池取出一个可用的button
        UIButton *button = (UIButton *)[_reusePool dequeueReuseableView];
        // 如果没有 创建一个
        if (button == nil) {
            button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.backgroundColor = [UIColor whiteColor];
            
            //将button添加到重用池
            [_reusePool addAUsingView:button];
            NSLog(@"创建了一个button");
        }else{
            NSLog(@"重用了button");
        }
        [_containerView addSubview:button];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        // 设置frame
        [button setFrame:CGRectMake(0, i * buttonHeight, buttonWidth, buttonHeight)];
    }
    [_containerView setHidden:NO];
    _containerView.frame = CGRectMake(self.frame.origin.x + self.frame.size.width - buttonWidth, self.frame.origin.y, buttonWidth, self.frame.size.height);
}

@end
