//
//  NTT.m
//  next_space_ios_arch
//
//  Created by 1234 on 2023/3/1.
//

#import  "ThreadUtils.h"
#import "next_space_ios_arch/XXF.h"

@implementation ThreadUtils
+(void)assertAtMainThread{
#if DEBUG
    if(!XXF.shared.config.disableThreadCheck){
        NSAssert([[NSThread currentThread] isMainThread],@"只能在主线程访问");
    }
#else

#endif
   
}

+(void)assertAtSubThread{
#if DEBUG
    if(!XXF.shared.config.disableThreadCheck){
        NSAssert(![[NSThread currentThread] isMainThread],@"只能在子线程访问");
    }
#else

#endif
}
@end
