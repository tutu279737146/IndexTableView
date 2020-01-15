//
//  ViewReusePool.h
//  indexTableView
//
//  Created by A on 2020/1/14.
//  Copyright © 2020 A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewReusePool : NSObject

///  从重用池取出一个可重用的view
- (UIView *)dequeueReuseableView;

/// 向重用池d添加一个视图
/// @param view <#view description#>
- (void)addAUsingView:(UIView *)view;

/// 重置
- (void)reset;

@end

NS_ASSUME_NONNULL_END
