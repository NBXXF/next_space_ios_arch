//
//  NXTimeUnit_DAYS.m
//  AFNetworking
//
//  Created by 1234 on 2023/2/8.
//

#import "NXTimeUnit_DAYS.h"

@implementation NXTimeUnit_DAYS
/**
 内部方法 转换成纳秒
 */
-(long long)___convertToNanos{
    return (long long)1*1000*1000*1000*60*60*24;
}
@end
