//
//  RACDisposable+AppArch.h
//  AppArch
//
//  Created by XXF on 2022/9/20.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface RACDisposable(AppArch)

- (void)disposeSafe DEPRECATED_MSG_ATTRIBUTE("过时了,已经在原始方法上hook了");

@end

NS_ASSUME_NONNULL_END
