//
//  NXTimeUnit_HOURS.m
//  AFNetworking
//
//  Created by XXF on 2023/2/8.
//

#import "NXTimeUnit_HOURS.h"

@implementation NXTimeUnit_HOURS
/**
 内部方法 转换成纳秒
 */
-(long long)___convertToNanos{
    return (long long)1*1000*1000*1000*60*60;
}
@end
