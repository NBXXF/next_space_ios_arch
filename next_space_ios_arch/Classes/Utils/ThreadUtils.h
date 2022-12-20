//
//  ThreadUtils.h
//  Pods
//  线程工具
//  Created by XXF on 2022/9/8.
//
#define isMainThread() [[NSThread currentThread] isMainThread];
#define assertAtMainThread()  NSAssert([[NSThread currentThread] isMainThread],@"只能在主线程访问");
#define assertAtSubThread()  NSAssert(![[NSThread currentThread] isMainThread],@"只能在子线程访问");
