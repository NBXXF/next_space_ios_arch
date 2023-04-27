//
//  NXNetCacheType.h
//  next_space_ios_arch
//
//  Created by XXF on 2023/2/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, NXNetCacheType) {///网络缓存
    /// 只走网络
    NXNetCacheTypeOnlyRemote = 0,
    /// 先网络,没有网络 就走本地
    NXNetCacheTypeIfRemote = 1,
    /// 先本地  后网络  如果本地没有就回调一次  否则回调两次(onNext 最多两次)
    NXNetCacheTypeFirstCache = 2,
    /// 如果本地有就走本地  没有就走网络 只走一次
    NXNetCacheTypeIfCache = 3,
    ///只走本地 判断是否需要显示下拉刷新用的,或者局部筛选搜索场景
    NXNetCacheTypeOnlyCache = 4,

};

NS_ASSUME_NONNULL_END
