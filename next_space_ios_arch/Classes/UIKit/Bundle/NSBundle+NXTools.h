//
//  NSBundle+NXTools.h
//  next_space_ios_arch
//
//  Created by XXF on 2023/3/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle(NXTools)

/**
 传递 全量文件名 没必要有传系统的ext参数(因为不确定性 可能是.json可能是.txt）
 @param fileName 系统传递 全量文件名 会自动解析 亲自验证 eg.  emoji.json emoji.txt
 */
- (nullable NSString *)pathForResource:(nullable NSString *)fileName;

/**
 @param fileName 系统传递 全量文件名 会自动解析 亲自验证 eg.  emoji.json emoji.txt
 */
- (nullable NSString *)stringForResource:(nullable NSString *)fileName;

/**
 @param fileName 系统传递 全量文件名 会自动解析 亲自验证 eg.  emoji.json emoji.txt
 */
- (nullable NSData *)dataForResource:(nullable NSString *)fileName;
@end

NS_ASSUME_NONNULL_END
