//
//  NXArchiveS.m
//  NXUIKit
//
//  Created by jsonLee on 2021/9/3.
//

#import "NXArchive.h"
#import <next_space_ios_arch/ThreadUtils.h>
#import <next_space_ios_arch/NXPath.h>

@implementation NXArchive
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
+ (void)archiveObject:(id)objc withFilePathName:(NSString *)filePath{
    assertAtSubThread();
    @synchronized (NXArchive.class) {
        [NSKeyedArchiver archiveRootObject:objc toFile:filePath];
    }
}

+ (instancetype)unarchivedObjectWithPath:(NSString *)filePath withObjClass:(Class)objClass{
    assertAtSubThread();
    @synchronized (NXArchive.class) {
        id obj = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        if (!objClass){
            return obj;
        }
        if ([obj isKindOfClass:objClass]){
            return obj;
        }
        return nil;
    }
}


+ (void)archiveModalObject:(id)objc WithFilePathName:(NSString *)fileName WithIsImportant:(BOOL)isImportant{
    assertAtSubThread();
    @synchronized (NXArchive.class) {
        BOOL isSuccess ;
        if(isImportant){
            isSuccess =  [NSKeyedArchiver archiveRootObject:objc toFile:[NXPath importantFilePath:fileName]];
        }else{
            isSuccess = [NSKeyedArchiver archiveRootObject:objc toFile:[NXPath unimportantFilePath:fileName]];
        }
        NSLog(@"存储成功了吗：%d",isSuccess);
    }

}
+ (void)archiveModalObject:(id)objc WithFilePathName:(NSString *)fileName userid:(NSString *)userid WithIsImportant:(BOOL)isImportant{
    assertAtSubThread();
    @synchronized (NXArchive.class) {
        BOOL isSuccess ;
        if(isImportant){
            isSuccess =  [NSKeyedArchiver archiveRootObject:objc toFile:[NXPath importantFilePath:fileName userId:userid]];
        }else{
            isSuccess = [NSKeyedArchiver archiveRootObject:objc toFile:[NXPath unimportantFilePath:fileName userId:userid]];
        }
        NSLog(@"存储成功了吗：%d",isSuccess);
    }
}

+ (instancetype)unarchivedModalObjectWithPathName:(NSString *)fileName WithIsImportant:(BOOL)isImportant withClass:(Class)objClass{
    assertAtSubThread();
    @synchronized (NXArchive.class) {
        id obj = nil;
        if(isImportant){
            obj  = [NSKeyedUnarchiver unarchiveObjectWithFile:[NXPath importantFilePath:fileName]];
        }else{
            obj = [NSKeyedUnarchiver unarchiveObjectWithFile:[NXPath unimportantFilePath:fileName]];
        }
        if (!objClass){
            return obj;
        }
        if ([obj isKindOfClass:objClass]){
            return obj;
        }
        return nil;
    }
}

+ (instancetype)unarchivedModalObjectWithPathName:(NSString *)fileName userid:(NSString *)userid WithIsImportant:(BOOL)isImportant withClass:(Class)objClass{
    assertAtSubThread();
    @synchronized (NXArchive.class) {
        id obj = nil;
        if(isImportant){
            obj  = [NSKeyedUnarchiver unarchiveObjectWithFile:[NXPath importantFilePath:fileName userId:userid]];
        }else{
            obj = [NSKeyedUnarchiver unarchiveObjectWithFile:[NXPath unimportantFilePath:fileName userId:userid]];
        }
        if (!objClass){
            return obj;
        }
        if ([obj isKindOfClass:objClass]){
            return obj;
        }
        return nil;
    }
}

/// 判断文件是否存在 不区分用户
/// - Parameters:
///   - fileName: 文件名字
///   - isImportant: 是否是重要文件
+ (BOOL)fileIsExistWithPathName:(NSString *)fileName WithIsImportant:(BOOL)isImportant{
    assertAtSubThread();
    NSString * path = nil;
    if(isImportant){
        path =  [NXPath importantFilePath:fileName];
    }else{
        path =  [NXPath unimportantFilePath:fileName];
    }
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}
#pragma clang diagnostic pop
@end
