//
//  UICollectionView+NXAdapter.m
//  AFNetworking
//
//  Created by XXF on 2022/11/25.
//

#import "UICollectionView+NXAdapter.h"

@implementation UICollectionView(NXAdapter)

- (NXListAdapter *)adapter{
    if([self.dataSource isKindOfClass:NXListAdapter.class]){
        return (NXListAdapter *)self.dataSource;
    }
    return nil;
}
- (void)setAdapter:(NXListAdapter *)adapter{
    adapter.collectionView=self;
    self.dataSource=adapter;
}

@end
