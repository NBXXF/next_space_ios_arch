//
//  NXAutoHeightTableView.m
//  next_space_ios_arch
//
//  高度自适应
//  Created by XXF on 2022/11/24.
//

#import "NXAutoHeightTableView.h"

@implementation NXAutoHeightTableView

- (void) layoutSubviews {
    [super layoutSubviews];
    if (!CGSizeEqualToSize(self.bounds.size, [self intrinsicContentSize])){
        [self invalidateIntrinsicContentSize];
    }
}

- (CGSize)intrinsicContentSize{
    return self.contentSize;
}
@end
