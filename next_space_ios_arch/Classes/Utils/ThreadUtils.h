//
//  ThreadUtils.h
//  Pods
//  线程工具
//  Created by XXF on 2022/9/8.
//
#define isMainThread() [[NSThread currentThread] isMainThread];
#define assertAtMainThread() [ThreadUtils assertAtMainThread];
#define assertAtSubThread()  [ThreadUtils assertAtSubThread];
@interface ThreadUtils : NSObject

+(void)assertAtMainThread;

+(void)assertAtSubThread;
@end
