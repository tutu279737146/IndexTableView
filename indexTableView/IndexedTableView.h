//
//  IndexedTableView.h
//  indexTableView
//
//  Created by A on 2020/1/14.
//  Copyright © 2020 A. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IndexedTableViewDataSource <NSObject>

/// 获取一个tableView字母索引
/// @param tableView <#tableView description#>
- (NSArray <NSString *> *_Nullable)indexTitlesForIndexedTableView:(UITableView *_Nullable)tableView;

@end

NS_ASSUME_NONNULL_BEGIN

@interface IndexedTableView : UITableView

@property (nonatomic, weak) id<IndexedTableViewDataSource> indexedDataSource;

@end

NS_ASSUME_NONNULL_END
