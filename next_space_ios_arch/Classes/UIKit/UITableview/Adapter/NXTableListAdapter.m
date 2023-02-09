//
//  NXListAdapter.h
//  AFNetworking
//  IGListAdapter 设计过于复杂了,这里简化设计(他的设计 是将collectionView和Adapter 完全糅合) 且不破坏原有api,只是将CollectionViewCell的处理放在这个适配器中
//  单纯的listAdapter,避免VC 业务膨胀,(尤其是一个vc有多个collectionView)
//  用法:collection.adapter=NXListAdapter继承类对象
//  Created by XXF on 2022/11/25.
//
#import "NXTableListAdapter.h"

@interface NXTableListAdapter<T>()
@property(nonatomic,strong,readwrite)NSMutableArray<T> *dataArray;
@end
@implementation NXTableListAdapter

- (NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}

- (void)bindData:(NSArray *)dataList isRefresh:(BOOL)isRefresh{
    if(isRefresh){
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:dataList];
    }else{
        [self.dataArray addObjectsFromArray:dataList];
    }
    [self.container reloadData];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

@end
