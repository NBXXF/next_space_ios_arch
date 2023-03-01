//
//  NXTimeUnit_MILLISECONDS.m
//  AFNetworking
//
//  Created by XXF on 2023/2/8.
//

#import "NXTimeUnit_MILLISECONDS.h"

@implementation NXTimeUnit_MILLISECONDS

/**
 内部方法 转换成纳秒
 */
-(long long)___convertToNanos{
    return (long long)1*1000*1000;
}
@end
