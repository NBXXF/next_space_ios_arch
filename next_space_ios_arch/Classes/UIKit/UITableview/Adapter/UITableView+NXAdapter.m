//
//  UITableView+NXAdapter.m
//  next_space_ios_arch
//
//  Created by XXF on 2022/11/25.
//

#import "UITableView+NXAdapter.h"
#import <next_space_ios_arch/NSObject+NXTools.h>

@implementation UITableView(NXAdapter)
- (NXTableListAdapter *)adapter{
    return [NXTableListAdapter toKindOfClassObjectOrNilFrom:self.dataSource];
}

- (void)setAdapter:(NXTableListAdapter *)adapter{
    adapter.container=self;
    self.dataSource=adapter;
}
@end
