//
//  RACSignal+AppArch.h
//  AppArch
//
//  Created by XXF on 2022/9/8.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
NS_ASSUME_NONNULL_BEGIN

@interface RACSignal(AppArch)
///简化订阅,不关心结果
-(RACSignal *)subscribe;

///将普通数据转换成流
+(RACSignal *)just:(id __nullable)value;

//通过回调创建数据流
+(RACSignal *)fromCallbck:(id __nullable (^)(void))block;

//遇到错误 返回对应的值
-(RACSignal *)onErrorReturnItem:(id)value;

//遇到错误 返回对应的值
-(RACSignal *)onErrorReturn:(id __nullable (^)(void))block;

//遇到错误 返回对应的值
-(RACSignal *)onErrorResumeNext:(RACSignal * (^)(NSError *error))catchBlock;

/// 错误信号连接
- (RACSignal *)concatIgnoreError:(RACSignal *)signal;

/// ignoreError 转换成nil信号
- (RACSignal *)ignoreError DEPRECATED_MSG_ATTRIBUTE("这个不应该这样设计");

//订阅再子线程
- (RACSignal *)subscribeOnSubThread;


// 自定义是否节流
- (RACSignal *)distinctUntilChangedWithBlock:(BOOL (^)(id last,id current))block;

@end

NS_ASSUME_NONNULL_END
