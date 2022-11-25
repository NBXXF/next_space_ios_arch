//
//  NXListAdapter.h
//  AFNetworking
//  IGListAdapter 设计过于复杂了,这里简化设计(他的设计 是将collectionView和Adapter 完全糅合) 且不破坏原有api,只是将CollectionViewCell的处理放在这个适配器中
//  单纯的listAdapter,避免VC 业务膨胀,(尤其是一个vc有多个collectionView)
//  用法:collection.adapter=NXListAdapter继承类对象
//  Created by XXF on 2022/11/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NXListAdapter<T> : NSObject<UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong,readonly)NSMutableArray<T> *dataArray;

-(void)bindData:(NSArray<T> *)dataList isRefresh:(BOOL)isRefresh;
@end

NS_ASSUME_NONNULL_END
