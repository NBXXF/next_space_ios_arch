//
//  UITableView+NXAdapter.h
//  next_space_ios_arch
//
//  Created by XXF on 2022/11/25.
//

#import <UIKit/UIKit.h>
#import "NXTableListAdapter.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITableView(NXAdapter)
@property(nonatomic,strong)NXTableListAdapter *adapter;
@end

NS_ASSUME_NONNULL_END
