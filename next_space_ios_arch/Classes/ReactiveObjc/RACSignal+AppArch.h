//
//  RACSignal+AppArch.h
//  AppArch
//
//  Created by XXF on 2022/9/8.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <next_space_ios_arch/NXLifecycleEvent.h>
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

/**
 订阅在子线程
 @param inheritContext 代表是否继承上文的子线程  如果上文是子线程 那么还是在那个子线程
 */
- (RACSignal<ValueType> *)subscribeOnSubThread:(BOOL)inheritContext;


//观察在子线程
- (RACSignal<ValueType> *)deliverOnOnSubThread;

/**
 /观察在子线程
 @param inheritContext 代表是否继承上文的子线程  如果上文是子线程 那么还是在那个子线程
 */
- (RACSignal<ValueType> *)deliverOnOnSubThread:(BOOL)inheritContext;


// 自定义是否节流
- (RACSignal<ValueType> *)distinctUntilChangedWithBlock:(BOOL (^)(ValueType last,ValueType current))block;

/**
 绑定生命周期到具体放到节点
 */
- (RACSignal<ValueType> *)bindLifecycleWithOwner:(NSObject *)lifecycleOwner toSelector:(SEL)toSelector;

/**
 绑定生命周期到对象销毁
 (UITableViewHeaderFooterView / UITableViewCell / UICollectionReusableView/ MKAnnotationView)有 rac_prepareForReuseSignal
 rac_prepareForReuseSignal 是复用的时候 会让上次的completed 但是Dealloc不会执行completed
 rac_willDeallocSignal 是Dealloc执行completed
 
 */
- (RACSignal<ValueType> *)bindLifecycleWithOwner:(NSObject *)lifecycleOwner;

/**
 绑定生命周期到对象销毁
 */
- (RACSignal<ValueType> *)bindLifecycleWithVC:(UIViewController *)lifecycleOwner toEvent:(NXLifecycleEvent *)event;

@end

NS_ASSUME_NONNULL_END
