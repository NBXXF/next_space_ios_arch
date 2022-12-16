//
//  RACSignal+AppArch.h
//  AppArch
//
//  Created by XXF on 2022/9/8.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
NS_ASSUME_NONNULL_BEGIN

@interface RACSignal<__covariant ValueType>(AppArch)
///简化订阅,不关心结果
-(RACSignal *)subscribe;

///将普通数据转换成流
+(RACSignal *)just:(id __nullable)value;

//通过回调创建数据流
+(RACSignal *)fromCallbck:(id __nullable (^)(void))block;

//遇到错误 返回对应的值
-(RACSignal<ValueType> *)onErrorReturnItem:(ValueType __nullable)value;

//遇到错误 返回对应的值
-(RACSignal<ValueType> *)onErrorReturn:(ValueType __nullable (^)(void))block;

//遇到错误 返回对应的值
-(RACSignal<ValueType> *)onErrorResumeNext:(RACSignal<ValueType> * (^)(NSError *error))catchBlock;

/// 错误信号连接
- (RACSignal *)concatIgnoreError:(RACSignal *)signal DEPRECATED_MSG_ATTRIBUTE("这个不应该这样设计");

/// ignoreError 转换成nil信号
- (RACSignal *)ignoreError DEPRECATED_MSG_ATTRIBUTE("这个不应该这样设计");

//订阅在子线程
- (RACSignal<ValueType> *)subscribeOnSubThread;


//观察在子线程
- (RACSignal<ValueType> *)deliverOnOnSubThread;

// 自定义是否节流
- (RACSignal<ValueType> *)distinctUntilChangedWithBlock:(BOOL (^)(ValueType last,ValueType current))block;

@end

NS_ASSUME_NONNULL_END
