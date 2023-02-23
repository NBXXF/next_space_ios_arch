//
//  NXPath.h
//  next_space
//
//  Created by jsonLee on 2021/5/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NXPath : NSObject

+ (NSString *)documentPath;

//外部路径
+ (NSString *)externalDocumentPath;


/// 请注意此处是创建文件夹
/// @param fileName 文件夹名字
+ (NSString *)documentPath:(NSString *)fileName;


//外部路径
+ (NSString *)externalDocumentPath:(NSString *)fileName;


+ (NSString * )tmpPath;


/// 缓存图片的位置
+ (NSString *)cacheImageDir;


/// 暂存文件夹地址
+ (NSString *)cachePath;


/// 下载文件管理文件夹
+ (NSString *)cacheDownloadFilePath;

///保存文件直接覆盖: cachePath: 缓存路径 指定路径filePath (覆盖存储)
+ (NSString *)cacheDownloadFileFrom: (NSURL *)cachePath fileName:(NSString *)fileName;

///创建文件夹如果指定路径上文件夹不存在
+ (BOOL)createFolderAtPath:(NSString *)dir;
/**
 *  重要文件不区分用户
 */
+ (NSString *)importantFilePath:(NSString * )fileName;
/**
 *  区分用户的重要文件
 */
+ (NSString *)importantFilePath:(NSString * )fileName userId:(NSString *)userid;

/**
 *  不重要文件路径不区分用户
 */
+ (NSString *)unimportantFilePath:(NSString * )fileName;

/**
 *  不重要文件路径区分用户
 */
+ (NSString *)unimportantFilePath:(NSString * )fileName userId:(NSString *)userid;

/**
 *  存放重要文件的文件夹
 */
+ (NSString *)importPath;

/**
 *  存放不重要文件的文件夹
 */
+ (NSString *)unimportPath;


// 崩溃信息文件
+ (NSString * )getCrashPath:(NSString * )time;


+ (NSString *)netWordCachePathWithName:(NSString *)name userId:(NSString *)userid DEPRECATED_MSG_ATTRIBUTE("这个api单词写错了 请用networkCachePathWithName");

/**
 * 网络缓存路径   都是不重要可清理的 都是区分用户de
 */
+ (NSString *)networkCachePathWithName:(NSString *)name userId:(NSString *)userid;
@end

NS_ASSUME_NONNULL_END
