//
//  StringUtils.m
//  NXUIKit
//  pod 迁移 临时工具类
//  Created by XXF on 2022/8/23.
//

#import "StringUtils.h"

@implementation StringUtils
+ (BOOL)isEmpty:(NSString *)str{
   return (((str) == nil) || ([(str) isEqual:[NSNull null]]) || ([(str) isEqualToString:@""]) || ((str).length == 0));
}
@end
