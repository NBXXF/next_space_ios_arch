//
//  UICollectionView+NXAdapter.h
//  AFNetworking
//
//  Created by 1234 on 2022/11/25.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NXListAdapter.h"
NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView(NXAdapter)

@property(nonatomic,strong)NXListAdapter *adapter;
@end

NS_ASSUME_NONNULL_END
