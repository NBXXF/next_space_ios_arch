//
//  NXPath.m
//  next_space
//
//  Created by jsonLee on 2021/5/19.
//

#import "NXPath.h"
#import <next_space_ios_arch/ThreadUtils.h>
@implementation NXPath

#pragma mark - 获取 Documents 目录下文件的路径

+ (NSString *)documentPath
{
    assertAtSubThread();
    ///不要随便换方式  例如下面这种就会出现归档不成功   不要使用  因为这种存储下来的文件会被共享NSDocumentDirectory  需要使用 NSDocumentationDirectory(这是在libary里的)
    return [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}
+ (NSString *)externalDocumentPath{
    assertAtSubThread();
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

+ (NSString *)documentPath:(NSString *)fileName
{
    assertAtSubThread();
    NSString * path = [[self documentPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",fileName]];
    if(![[NSFileManager defaultManager] fileExistsAtPath:path]){
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return [[self documentPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",fileName]];
}

+ (NSString *)externalDocumentPath:(NSString *)fileName{
    assertAtSubThread();
    NSString * path = [[self externalDocumentPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",fileName]];
    NSURL *dir=[NSURL URLWithString:path].URLByDeletingLastPathComponent;
    if(![[NSFileManager defaultManager] fileExistsAtPath:dir.path]){
        [[NSFileManager defaultManager] createDirectoryAtPath:dir.path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return [[self externalDocumentPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",fileName]];
}

+ (NSString *)externalDocumentWithDir:(NSString *)dir{
    NSString *path = [[self externalDocumentPath] stringByAppendingPathComponent:dir];
    [self createFolderAtPath:path];
    return path;
}

// 不是很重要的缓存 可以清除的
+ (NSString *)unimportantFilePath:(NSString * )fileName
{
    assertAtSubThread();
    NSString * path = [self unimportPath];
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString * unDiffPath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",fileName]];
    if([manager fileExistsAtPath:unDiffPath]){
        [manager moveItemAtPath:unDiffPath toPath:[unDiffPath stringByAppendingPathExtension:@"plist"] error:nil];
    }
    return [unDiffPath stringByAppendingPathExtension:@"plist"];
}
/**
 *  不重要文件路径区分用户
 */
+ (NSString *)unimportantFilePath:(NSString * )fileName userId:(NSString *)userid{
    assertAtSubThread();
    NSString * path = [self unimportPath];
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *diffPath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_%@",userid,fileName]];
    if([manager fileExistsAtPath:diffPath]){
        [manager moveItemAtPath:diffPath toPath:[diffPath stringByAppendingPathExtension:@"plist"] error:nil];
    }
    return [diffPath stringByAppendingPathExtension:@"plist"];
}

/**
 *  重要文件不区分用户
 */
+ (NSString *)importantFilePath:(NSString * )fileName{
    assertAtSubThread();
    NSString * path = [self importPath];
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *unDiffPath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",fileName]];
    if([manager fileExistsAtPath:unDiffPath]){
        [manager moveItemAtPath:unDiffPath toPath:[unDiffPath stringByAppendingPathExtension:@"plist"] error:nil];
    }
    return [unDiffPath stringByAppendingPathExtension:@"plist"];
}

/**
 *  区分用户的重要文件
 */
+ (NSString *)importantFilePath:(NSString * )fileName userId:(NSString *)userid{
    assertAtSubThread();
    NSString * path = [self importPath];
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *diffPath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_%@",userid,fileName]];
    if([manager fileExistsAtPath:diffPath]){
        [manager moveItemAtPath:diffPath toPath:[diffPath stringByAppendingPathExtension:@"plist"] error:nil];
    }
    return [diffPath stringByAppendingPathExtension:@"plist"];
}


+ (NSString *)unimportPath{
    return [self documentPath:@"unimportantFile"];
}

+ (NSString *)importPath{
    return [self documentPath:@"importantFile"];
}
+ (NSString * )tmpPath{
    assertAtSubThread();
    return NSTemporaryDirectory();
}

+ (NSString *)cacheImageDir {
    assertAtSubThread();
    NSString *dir = [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"cacheTmpImages"];
    BOOL isDir;
    if (![[NSFileManager defaultManager] fileExistsAtPath:dir isDirectory:&isDir]) {
        BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:nil];
        if (!success) {
            NSLog(@"cacheTmpImages create failed");
            dir = NSTemporaryDirectory();
        }
    }
    return dir;
}

+ (NSString *)cachePath{
    assertAtSubThread();
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)cacheDownloadFilePath{
    assertAtSubThread();
    NSString *dir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"downloadFile"];
    BOOL isDir;
    if (![[NSFileManager defaultManager] fileExistsAtPath:dir isDirectory:&isDir]) {
        BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:nil];
        if (!success) {
            NSLog(@"cacheTmpImages create failed");
            dir = NSTemporaryDirectory();
        }
    }
    return dir;
}

///保存文件直接覆盖: cachePath: 缓存路径 指定路径filePath
+ (NSString *)cacheDownloadFileFrom: (NSURL *)cachePath fileName:(NSString *)fileName {
    assertAtSubThread();
    NSString *fromPath = [cachePath.path stringByReplacingOccurrencesOfString:@"file://" withString:@""];
    NSString *toPath = [[NXPath cacheDownloadFilePath] stringByAppendingPathComponent:fileName];
    BOOL success = [[NSFileManager defaultManager] moveItemAtPath:fromPath toPath:toPath error:nil];
    if (!success) {
        NSLog(@"cache Tmp files failed");
    }
    return @"";
}

+ (BOOL)createFolderAtPath:(NSString *)dir {
    assertAtSubThread();
    BOOL isDir;
    if (![[NSFileManager defaultManager] fileExistsAtPath:dir isDirectory:&isDir]) {
        return [[NSFileManager defaultManager] createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return isDir;
}



///闪退文件
+ (NSString * )getCrashPath:(NSString * )time{
    assertAtSubThread();
    NSString * path = [self documentPath:@"crash"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]){
        [ fileManager createDirectoryAtPath:path withIntermediateDirectories:TRUE attributes:nil error:nil];
    }
    return [path stringByAppendingPathComponent:time];
}

/**
 *  网络缓存路径   都是不重要可清理的 都是区分用户de
 */
+ (NSString *)netWordCachePathWithName:(NSString *)name userId:(NSString *)userid DEPRECATED_MSG_ATTRIBUTE("这个api单词写错了 请用networkCachePathWithName"){
    return [self networkCachePathWithName:name userId:userid];
}

+ (NSString *)networkCachePathWithName:(NSString *)name userId:(NSString *)userid{
    assertAtSubThread();
    NSString * path = [self unimportPath];
    NSString *realPath = [path stringByAppendingString:@"/netWorkCache1"];
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:realPath]){
        [manager createDirectoryAtPath:realPath withIntermediateDirectories:TRUE attributes:nil error:nil];
    }
    NSString *diffPath = [realPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_%@",userid,name]];
    if([manager fileExistsAtPath:diffPath]){
        [manager moveItemAtPath:diffPath toPath:[diffPath stringByAppendingPathExtension:@"plist"] error:nil];
    }
    return [diffPath stringByAppendingPathExtension:@"plist"];
}
@end
