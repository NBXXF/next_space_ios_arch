//
//  NSObject+NXRACSignalSupport.h
//  next_space_ios_arch
//
//  Created by XXF on 2023/2/14.
//

#import <ReactiveObjC/ReactiveObjC.h>
#import <ReactiveObjC/ReactiveObjC-umbrella.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject(NXRACSignalSupport)
/**
 是Dealloc执行completed
 
 如果是vc的话 可以配合
observeViewDidLoad;
observeViewWillAppear;
observeViewDidAppear;
observeViewWillDisappear;
observeViewDidDisappear;
 这些来 限制 在vc 某个局部的声明周期区间
 */
@property (nonatomic, strong, readonly) RACSignal<RACUnit *> *untilDeallocSignal;


/**
 唯一标识控制生命周期 比如一个bind方法内部会有监听 但是这个bind方法会多次执行,那么会重复订阅多次(如RACObserve(target,xxField)) 这个api 就是解决这个的 【再次绑定的时候会上次的执行completed】
 注意:【如果是一个方法中有多个且identifier一样    需要写成局部变量去共享使用】
  比如当前方法 identifier=NSStringFromSelector(_cmd)
 */
- (RACSignal<RACUnit *> * (^)(NSString *identifier))untilUniqueSignalWithIdentifier;



/**
   避免重复绑定
 【再次绑定的时候会上次的执行completed】
 注意:【如果是一个方法中有多个且identifier一样    需要写成局部变量去共享使用】
   比untilUniqueSignalWithIdentifier 多一个绑定销毁的生命周期
 */
- (RACSignal<RACUnit *> * (^)(NSString *identifier))untilUniqueOrDeallocSignalWithIdentifier;
@end

NS_ASSUME_NONNULL_END
