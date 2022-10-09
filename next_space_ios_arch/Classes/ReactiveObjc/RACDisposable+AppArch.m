//
//  RACDisposable+AppArch.m
//  AppArch
//
//  Created by XXF on 2022/9/20.
//

#import "RACDisposable+AppArch.h"


@implementation RACDisposable(AppArch)


/**
 目前是否存在野指针闪退的问题
 */
- (void)disposeSafe{
    @try {
        @try {
            BOOL isMainThread=[[NSThread currentThread] isMainThread];
            if(!isMainThread){
                 //避免多线程出现野指针
                @synchronized (RACDisposable.class) {
                    if(!self.isDisposed){
                        [self dispose];
                    }
                }
            }else{
                if(!self.isDisposed){
                    [self dispose];
                }
            }
        } @catch (NSException *exception) {
        }
    } @catch (NSError *error) {

    }
}
@end
