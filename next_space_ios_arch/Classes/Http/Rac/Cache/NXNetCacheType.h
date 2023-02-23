//
//  NXNetCacheType.h
//  next_space_ios_arch
//
//  Created by 1234 on 2023/2/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, NXNetCacheType) {///网络缓存
    /// 只走网络
    NXNetCacheTypeOnlyRemote = 0,
    /// 先网络,没有网络 就走本地
    NXNetCacheTypeFirstRemote = 1,
    /// 先本地  后网络  如果本地没有就回调一次  否则回调两次
    NXNetCacheTypeFirstCache = 2,
    /// 如果本地有就走本地  没有就走网络 只走一次 有没有 都会继续请求接口 覆盖新数据
    NXNetCacheTypeIfCache = 3,
    ///只走本地 判断是否需要显示下拉刷新用的
    NXNetCacheTypeOnlyCache = 4,

};

NS_ASSUME_NONNULL_END
