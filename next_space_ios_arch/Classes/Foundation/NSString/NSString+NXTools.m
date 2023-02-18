//
//  NSString+NXTools.m
//  next_space_ios_arch
//
//  Created by XXF on 2023/2/18.
//

#import "NSString+NXTools.h"

@implementation NSString(NXTools)

- (NSString *)firstComponentSeparatedByString:(NSString *)separator{
    NSRange range=[self rangeOfString:separator];
    if(range.length!=0){
        return [self substringToIndex:range.location];
    }
    //系统componentsSeparatedByString 如果查询不到 会返回原始字符串
    return self;
}

- (NSString *)lastComponentSeparatedByString:(NSString *)separator{
    NSRange range=[self rangeOfString:separator options:NSBackwardsSearch];
    if(range.length!=0){
        return [self substringFromIndex:range.location+range.length];
    }
    //系统componentsSeparatedByString 如果查询不到 会返回原始字符串
    return self;
}

@end
