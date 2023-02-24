//
//  NXNetCacheFactory.m
//  next_space_ios_arch
//
//  Created by XXF on 2022/5/24.
//

#import "NXNetCacheFactory.h"
#import <next_space_ios_arch/NXHttpCacheConfigProvider.h>
#import <next_space_ios_arch/ThreadUtils.h>
@interface NXNetCacheFactory()
@property(nonatomic,strong)NSMutableDictionary *cacheDict;
@end
@implementation NXNetCacheFactory
singleton_implementation(NXNetCacheFactory)

- (NSMutableDictionary *)cacheDict{
    if(!_cacheDict){
        _cacheDict=[NSMutableDictionary dictionary];
    }
    return _cacheDict;
}

- (YYDiskCache *)getCache:(NXHttpCacheConfigProvider *)provider{
    assertAtSubThread();
    NSString *directory=provider.getDirectory;
    @synchronized (self) {
        YYDiskCache *diskCache = [self.cacheDict objectForKey:directory];
        if(!diskCache){
            diskCache=[[YYDiskCache alloc] initWithPath:directory inlineThreshold:provider.maxSize];
            [self.cacheDict setObject:diskCache forKey:directory];
        }
        return diskCache;
    }
}
@end
