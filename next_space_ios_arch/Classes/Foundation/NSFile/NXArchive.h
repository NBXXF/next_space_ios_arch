//
//  NXArchiveS.h
//  NXUIKit
//
//  Created by jsonLee on 2021/9/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NXArchive : NSObject
// filePath 是完整路径
+ (void)archiveObject:(id)objc withFilePathName:(NSString *)filePath;

//objClass 存储的对象类型
+ (instancetype)unarchivedObjectWithPath:(NSString *)filePath withObjClass:(Class)objClass;

+ (void)archiveModalObject:(id)objc WithFilePathName:(NSString *)fileName WithIsImportant:(BOOL)isImportant;

+ (void)archiveModalObject:(id)objc WithFilePathName:(NSString *)fileName userid:(NSString *)userid WithIsImportant:(BOOL)isImportant;


+ (instancetype)unarchivedModalObjectWithPathName:(NSString *)fileName WithIsImportant:(BOOL)isImportant withClass:(Class)objClass;
+ (instancetype)unarchivedModalObjectWithPathName:(NSString *)fileName userid:(NSString *)userid WithIsImportant:(BOOL)isImportant withClass:(Class)objClass;

/// 判断文件是否存在 不区分用户
/// - Parameters:
///   - fileName: 文件名字
///   - isImportant: 是否是重要文件
+ (BOOL)fileIsExistWithPathName:(NSString *)fileName WithIsImportant:(BOOL)isImportant;
@end

NS_ASSUME_NONNULL_END
