//
//  UITableView+BabyKit.h
//  BabyKit
//
//  Created by li hua on 2018/6/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 拷贝YYKit😄
@interface UITableView (BabyKit)

- (void)tableReloadRow:(NSUInteger)row inSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation;
- (void)tableReloadRowAtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation;
- (void)tableReloadSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation;

- (void)tableInsertRow:(NSUInteger)row inSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation;
- (void)tableInsertRowAtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation;
- (void)tableInsertSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation;

- (void)tableDeleteRow:(NSUInteger)row inSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation;
- (void)tableDeleteRowAtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation;
- (void)tableDeleteSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation;


- (void)tableUpdateWithBlock:(void (^)(UITableView *tableView))block;

- (void)tableScrollToRow:(NSUInteger)row inSection:(NSUInteger)section atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated;

- (void)tableClearSelectedRowsAnimated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END

