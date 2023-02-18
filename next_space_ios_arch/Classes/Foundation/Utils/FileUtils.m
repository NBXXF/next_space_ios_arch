//
//  FileUtils.m
//  AppArch
//
//  Created by XXF on 2022/9/7.
//

#import "FileUtils.h"
#import "StringUtils.h"

@implementation FileUtils

/**
 获取文件大小
 */
+ (long long)getFileSize:(NSString *)filePath{
    @try {
        NSFileManager* manager = [NSFileManager defaultManager];
        BOOL isDir=NO;
        if([manager fileExistsAtPath:filePath isDirectory:&isDir]){
            if(isDir){
                NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:filePath] objectEnumerator];
                NSString* fileName;
                long long folderSize = 0;
                while ((fileName = [childFilesEnumerator nextObject]) != nil){
                    NSString* fileAbsolutePath = [filePath stringByAppendingPathComponent:fileName];
                   folderSize += [self getFileSize:fileAbsolutePath];
                }
                return folderSize;
            }else{
                return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
            }
        }else{
            return 0;
        }
    } @catch (NSException *exception) {
        NSLog(@"=======>getFileSizeException:%@",exception);
    } @finally {
    }
   return 0;
}

//删除文件
+ (BOOL)deleteFile:(NSString *)filePath{
    @try {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if([fileManager fileExistsAtPath:filePath]){
            return [fileManager removeItemAtPath:filePath error:NULL];
        }
    } @catch (NSException *exception) {
        NSLog(@"=======>deleteFileException:%@",exception);
    } @finally {
    }
    return NO;
}

///获得文件名
+ (NSString *)getFileName: (NSString *)input {
    //TODO 拷贝而来 这种写法不是很好
    if([input hasPrefix:@"assets-library:"]){
        NSRange startRange = [input rangeOfString:@"?id="];
        if(startRange.location != NSNotFound){
           // NSString * startStr = [input nx_substringFromIndexSafely:startRange.location + 4];
            NSString * startStr = [self substringFromIndexSafely:input andIndex:startRange.location + 4];
            NSRange endRange = [startStr rangeOfString:@"&ext="];
            if(endRange.location != NSNotFound && endRange.location < startStr.length){
                NSString * idStr = [startStr substringToIndex:endRange.location];
                return [NSString stringWithFormat:@"%@.%@",idStr, [self getFileExtName:input]];
            }
        }
    }
    return input.lastPathComponent;
}

///获得文件拓展名
+ (NSString *)getFileExtName:(NSString *)input {
    //TODO 拷贝而来 这种写法不是很好
    if([input hasPrefix:@"assets-library:"]){
        NSRange range = [input rangeOfString:@"ext="];
        if(range.location != NSNotFound){
            ///拍照出来的地址  assets-library://asset/asset.JPG?id=920EABC2-1103-44B8-A323-642D7CACE787&ext=JPG
           // NSString *extName = [input nx_substringFromIndexSafely:range.location + 4];
            NSString *extName = [self substringFromIndexSafely:input andIndex:range.location + 4];
            if(extName){
                return extName;
            }
        }
    }
    return input.pathExtension;
}

/// 把地址后缀转成小写
+ (NSString *)convertExtNameToLowcaseWithUrl:(NSString *)url{
    NSString * extension = url.pathExtension;
    NSString * name = [url stringByDeletingPathExtension];
    if(IsStrEmpty(extension)){
        return url;
    }
    return [NSString stringWithFormat:@"%@.%@",name,extension.lowercaseString];
}

+ (NSString *)substringFromIndexSafely:(NSString*)fromStr andIndex:(NSInteger)atIndex{
    if (fromStr.length > atIndex) {
        return [fromStr substringFromIndex:atIndex];
    }
    return fromStr;
}

@end
