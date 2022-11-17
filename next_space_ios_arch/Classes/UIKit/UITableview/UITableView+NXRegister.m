//
//  UITableView+NXRegister.m
//  next_space_ios_arch
//
//  Created by 1234 on 2022/11/17.
//

#import "UITableView+NXRegister.h"

@implementation UITableView(NXRegister)

/**
 简化注册identifier 就是class名称
 */
- (void)registerClassforCellReuse:(nullable Class)cellClass{
    [self registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
}


/**
 简化注册identifier 就是class名称
 */
- (void)registerClassForHeaderFooterViewReuse:(nullable Class)aClass{
    [self registerClass:aClass forHeaderFooterViewReuseIdentifier:NSStringFromClass(aClass)];
}


/**
 不注册也可以用,本质identifier 就是class名称
 */
- (nullable __kindof UITableViewCell *)dequeueReusableCellWithClass:(Class)cellClass{
  [self registerClassforCellReuse:cellClass];
   return  [self dequeueReusableCellWithIdentifier:NSStringFromClass(cellClass)];
}


/**
 不注册也可以用,本质identifier 就是class名称
 */
- (__kindof UITableViewCell *)dequeueReusableCellWithClass:(Class)cellClass forIndexPath:(NSIndexPath *)indexPath{
    [self registerClassforCellReuse:cellClass];
    return [self dequeueReusableCellWithIdentifier:NSStringFromClass(cellClass) forIndexPath:indexPath];
}


/**
 不注册也可以用,本质identifier 就是class名称
 */
- (nullable __kindof UITableViewHeaderFooterView *)dequeueReusableHeaderFooterViewWithClass:(Class)aClass{
    [self registerClassForHeaderFooterViewReuse:aClass];
    return [self dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(aClass)];
}

@end