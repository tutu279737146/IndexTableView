//
//  ViewReusePool.m
//  indexTableView
//
//  Created by A on 2020/1/14.
//  Copyright © 2020 A. All rights reserved.
//

#import "ViewReusePool.h"

@interface ViewReusePool ()
// 待使用的队列
@property (nonatomic, strong) NSMutableSet *waitUsedQueue;
// 使用中的队列
@property (nonatomic, strong) NSMutableSet *usingQueue;

@end

@implementation ViewReusePool

- (instancetype)init{
    self = [super init];
    if (self) {
        _waitUsedQueue = [NSMutableSet set];
        _usingQueue = [NSMutableSet set];
    }
    return self;
}

- (UIView *)dequeueReuseableView{
    UIView *view = [_waitUsedQueue anyObject];
    if (view == nil) {
        return nil;
    }else{
        [_waitUsedQueue removeObject:view];
        [_usingQueue addObject:view];
        return view;
    }
}

- (void)addAUsingView:(UIView *)view{
    if (view == nil) {
        return;
    }
    [_usingQueue addObject:view];
}

- (void)reset{
    UIView *view = nil;
    while ((view = [_usingQueue anyObject])) {
        [_usingQueue removeObject:view];
        [_waitUsedQueue addObject:view];
    }
}

@end
