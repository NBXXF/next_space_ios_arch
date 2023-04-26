//
//  NSFileManager+NXPath.m
//  next_space_ios_arch
//
//  Created by XXF on 2023/4/26.
//

#import "NSFileManager+NXPath.h"

@implementation NSFileManager(NXPath)

+ (NSString *)externalDocDir{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

+ (nonnull NSString *)docDir {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) firstObject];
}

+ (nonnull NSString *)cachesDir {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
}

+ (nonnull NSString *)tmpDir {
    return NSTemporaryDirectory();
}

@end
