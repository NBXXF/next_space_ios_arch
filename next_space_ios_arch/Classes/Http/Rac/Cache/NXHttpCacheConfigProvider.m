//
//  NXHttpCacheConfigProvider.m
//  next_space_ios_arch
//
//  Created by XXF on 2022/5/24.
//

#import "NXHttpCacheConfigProvider.h"
#import <next_space_ios_arch/NXSessionDataTaskResult.h>
#import <next_space_ios_arch/NXSessionDataTaskResult+NXTools.h>
#import <next_space_ios_arch/NSObject+NXTools.h>
@implementation NXHttpCacheConfigProvider

/**
  * 缓存目录 唯一标签 最好区分uid 或者token
  */
-(NSString *)getDirectory{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    return [NXPath networkCachePathWithName:@"XXFHttpCache" userId:XXF.getUserId];
#pragma clang diagnostic pop
}

/**
* 最大缓存空间 单位B
*/
-(NSUInteger)maxSize{
    return 200*1024*1024;
}

/**
  * 是否缓存 场用于 用于下游判断code是否应该缓存
  */
-(BOOL)isCache:(id)body{
    NXSessionDataTaskResult *result=[NXSessionDataTaskResult toMemberOfClassObjectOrNilFrom:body];
    if(result){
        if(result.isJSON||result.isBinary){
            return YES;
        }else{
            return NO;
        }
    }
    return NO;
}

/**
全局默认缓存时间 毫秒
*/
-(long long)cacheTime{
    return NXTimeUnit.DAYS.toMillis(1);
}

@end
