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
   等价initially 系统那个方法不好记忆
 */
- (RACSignal<ValueType> *)doSubscribe:(void (^)(void))block;
   


/**
 绑定声明周期 取代takeUtil 绑定生命周期单独提供方法
 untilSignal 的可选值如下 详细解释请点击到具体方法里面的注释或者参考源码(特征 都是untilXXX)
 1. 销毁的 self.untilDeallocSignal
 2. KVO 避免多次订阅 [self untilUniqueSignalWithIdentifier:xxxx]
 2. KVO 避免多次订阅或者销毁的 [self  untilUniqueOrDeallocSignalWithIdentifier:xxx]
 4.针对复用的ui列表组件  (UITableViewHeaderFooterView / UITableViewCell / UICollectionReusableView/ MKAnnotationView)
  4.1 self.untilReuseSignal 复用
  4.2 self.untilReuseOrDeallocSignal ==untilDeallocOrReuseSignal  复用或者销毁
 
 */
- (RACSignal<ValueType> *)bindLifecycle:(RACSignal<RACUnit *> *)untilSignal;



- (RACSignal<ValueType> *)bindLifecycleWithOwner:(NSObject *)lifecycleOwner DEPRECATED_MSG_ATTRIBUTE("过时了 请直接使用#bindLifecycle方法");


/**
 检查每个流节点的耗时问题,仅仅在debug生效,不会影响线上
 场景 主线程也卡不住,cpu也有富裕,那么每个流节点耗时太长,转圈圈太多的情况,
 需要手动去排查,还要做时间剪法,比较糟糕,那么可以选择每个节点去去加一个timeoutOnlyDebug
 */
- (RACSignal<ValueType> *)timeoutOnlyDebug:(NSTimeInterval)interval;

@end

NS_ASSUME_NONNULL_END
