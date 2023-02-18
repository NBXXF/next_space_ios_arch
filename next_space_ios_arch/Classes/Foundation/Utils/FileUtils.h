//
//  FileUtils.h
//  AppArch
//
//  Created by XXF on 2022/9/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FileUtils : NSObject

/**
 获取文件/文件夹的大小
 */
+ (long long)getFileSize:(NSString *) filePath;

+ (BOOL)deleteFile:(NSString *) filePath;

+ (NSString *)getFileName: (NSString *)input;

+ (NSString *)getFileExtName:(NSString *)input;

+ (NSString *)convertExtNameToLowcaseWithUrl:(NSString *)url;
@end

NS_ASSUME_NONNULL_END
