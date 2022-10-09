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

- (void)disposeSafe;

@end

NS_ASSUME_NONNULL_END
