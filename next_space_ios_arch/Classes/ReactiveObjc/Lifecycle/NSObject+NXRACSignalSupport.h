//
//  NSObject+NXRACSignalSupport.h
//  next_space_ios_arch
//
//  Created by XXF on 2023/2/14.
//

#import <ReactiveObjC/ReactiveObjC.h>
#import <ReactiveObjC/ReactiveObjC-umbrella.h>

/**
 唯一标识 文件代码运行位置 没性能影响
 */
#define __FILE_LINE__ [NSString stringWithFormat:@"%s_%d",__FILE__, __LINE__]

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
 推荐使用宏定义 __FILE_LINE__ 不要一行代码使用两次或者多次这个
 */
- (RACSignal<RACUnit *> * (^)(NSString *identifier))untilUniqueSignalWithIdentifier;



/**
   避免重复绑定
 【再次绑定的时候会上次的执行completed】
 推荐使用宏定义 __FILE_LINE__ 不要一行代码使用两次或者多次这个
   比untilUniqueSignalWithIdentifier 多一个绑定销毁的生命周期
 */
- (RACSignal<RACUnit *> * (^)(NSString *identifier))untilUniqueOrDeallocSignalWithIdentifier;
@end

NS_ASSUME_NONNULL_END
