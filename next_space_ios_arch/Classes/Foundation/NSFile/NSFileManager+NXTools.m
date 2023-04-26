//
//  NSFileManager+NXTools.m
//  next_space_ios_arch
//
//  Created by XXF on 2023/4/26.
//

#import "NSFileManager+NXTools.h"
#import <next_space_ios_arch/NSString+NXTools.h>

@implementation NSFileManager(NXTools)
+ (NSString *)externalDocDirByAppendingPathComponent:(NSString *)path{
    NSString *newPath=[NSFileManager.externalDocDir stringByAppendingPathComponent:path];
    [NSFileManager.defaultManager  createPathDirectoryAtPath:newPath withIntermediateDirectories:YES attributes:nil error:nil];
    return newPath;
}

+ (NSString *)docDirByAppendingPathComponent:(NSString *)path{
    NSString *newPath=[NSFileManager.docDir stringByAppendingPathComponent:path];
    [NSFileManager.defaultManager  createPathDirectoryAtPath:newPath withIntermediateDirectories:YES attributes:nil error:nil];
    return newPath;
}

+ (NSString *)cachesDirByAppendingPathComponent:(NSString *)path{
    NSString *newPath=[NSFileManager.cachesDir stringByAppendingPathComponent:path];
    [NSFileManager.defaultManager  createPathDirectoryAtPath:newPath withIntermediateDirectories:YES attributes:nil error:nil];
    return newPath;
}

- (BOOL)createPathDirectoryAtPath:(NSString *)path withIntermediateDirectories:(BOOL)createIntermediates attributes:(NSDictionary<NSFileAttributeKey,id> *)attributes error:(NSError *__autoreleasing  _Nullable *)error{
    NSString *dir=[path pathDirectory];
    if([self fileExistsAtPath:dir]){
        return [self createDirectoryAtPath:dir withIntermediateDirectories:createIntermediates attributes:attributes error:error];
    }
    return YES;
}


@end
