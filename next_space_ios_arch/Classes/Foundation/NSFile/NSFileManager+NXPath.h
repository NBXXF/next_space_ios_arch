//
//  NSFileManager+NXPath.h
//  next_space_ios_arch
//  整理路径
//  Created by XXF on 2023/4/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager(NXPath)
/**
 获取沙盒Documents目录路径
 特点:对外可见,会被icould同步
 /var/mobile/Containers/Data/Application/05A8F368-3E89-4168-81A6-F82C8F8EE0C9/Documents
 */
+(NSString *)externalDocDir;


/**
 获取沙盒Documentation目录路径
 特点:对外不可见,不会会被icould同步
 /var/mobile/Containers/Data/Application/BBC8BF53-D353-4959-96A7-1CCFCC607C02/Library/Documentation
 */
+(NSString *)docDir;


/**
 获取沙盒Caches目录路径
 特点:对外不可见,不会会被icould同步
 /var/mobile/Containers/Data/Application/05A8F368-3E89-4168-81A6-F82C8F8EE0C9/Library/Caches
 */
+(NSString *)cachesDir;


/**
 获取沙盒tmp目录路径
 特点:应用关闭系统会清理,对外不可见,不会会被icould同步
 /private/var/mobile/Containers/Data/Application/05A8F368-3E89-4168-81A6-F82C8F8EE0C9/tmp/
 */
+(NSString *)tmpDir;

@end

NS_ASSUME_NONNULL_END
