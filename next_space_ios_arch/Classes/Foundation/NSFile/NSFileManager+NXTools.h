//
//  NSFileManager+NXTools.h
//  next_space_ios_arch
//
//  Created by XXF on 2023/4/26.
//

#import <UIKit/UIKit.h>
#import "NSFileManager+NXPath.h"
NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager(NXTools)

/**
 内部会自动创建目录
 */
+ (NSString *)externalDocDirByAppendingPathComponent:(NSString *)path;

/**
 内部会自动创建目录
 */
+ (NSString *)docDirByAppendingPathComponent:(NSString *)path;

/**
 内部会自动创建目录
 */
+ (NSString *)cachesDirByAppendingPathComponent:(NSString *)path;


/**
 比系统的
 createDirectoryAtPath:(NSString *)path;
 智能,内部会判断path是dir还是普通文件
 */
- (BOOL)createPathDirectoryAtPath:(NSString *)path
        withIntermediateDirectories:(BOOL)createIntermediates
                         attributes:(nullable NSDictionary<NSFileAttributeKey, id> *)attributes
                              error:(NSError **)error;
@end

NS_ASSUME_NONNULL_END
