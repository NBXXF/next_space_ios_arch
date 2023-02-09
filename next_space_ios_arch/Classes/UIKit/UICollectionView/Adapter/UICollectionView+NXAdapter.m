//
//  UICollectionView+NXAdapter.m
//  AFNetworking
//
//  Created by XXF on 2022/11/25.
//

#import "UICollectionView+NXAdapter.h"
#import <next_space_ios_arch/NSObject+NXTools.h>

@implementation UICollectionView(NXAdapter)

- (NXListAdapter *)adapter{
    return [NXListAdapter toKindOfClassObjectOrNilFrom:self.dataSource];
}
- (void)setAdapter:(NXListAdapter *)adapter{
    adapter.container=self;
    self.dataSource=adapter;
}

@end
