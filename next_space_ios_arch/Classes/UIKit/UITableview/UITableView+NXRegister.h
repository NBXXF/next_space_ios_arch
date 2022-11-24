//
//  UITableView+NXRegister.h
//  next_space_ios_arch
//
//  Created by XXF on 2022/11/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView(NXRegister)

/**
 简化注册identifier 就是class名称
 */
- (void)registerClassForCellReuse:(nullable Class)cellClass;


/**
 简化注册identifier 就是class名称
 */
- (void)registerClassForHeaderFooterViewReuse:(nullable Class)aClass;


/**
 不注册也可以用(框架实现自动注册),本质identifier 就是class名称
 */
- (nullable __kindof UITableViewCell *)dequeueReusableCellWithClass:(Class)cellClass;


/**
 不注册也可以用(框架实现自动注册),本质identifier 就是class名称
 */
- (__kindof UITableViewCell *)dequeueReusableCellWithClass:(Class)cellClass forIndexPath:(NSIndexPath *)indexPath;


/**
 不注册也可以用(框架实现自动注册),本质identifier 就是class名称
 */
- (nullable __kindof UITableViewHeaderFooterView *)dequeueReusableHeaderFooterViewWithClass:(Class)aClass;

@end

NS_ASSUME_NONNULL_END
