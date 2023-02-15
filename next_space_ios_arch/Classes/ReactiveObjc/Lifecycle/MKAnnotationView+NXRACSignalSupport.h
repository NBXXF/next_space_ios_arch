//
//  MKAnnotationView+NXRACSignalSupport.h
//  next_space_ios_arch
//
//  Created by XXF on 2023/2/14.
//

#import <MapKit/MapKit.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKAnnotationView(NXRACSignalSupport)
/**
 复用开始时会执行上次的completed
 */
@property (nonatomic, strong, readonly) RACSignal<RACUnit *> *untilReuseSignal;
/**
 (UITableViewHeaderFooterView / UITableViewCell / UICollectionReusableView/ MKAnnotationView)有 rac_prepareForReuseSignal
 rac_prepareForReuseSignal 是复用的时候 会让上次的completed 但是Dealloc不会执行completed
 rac_willDeallocSignal 是Dealloc执行completed
 
 【复用组件 既想复用的时候结束也想销毁的时候能结束】
 untilDeallocOrReuseSignal 【等价】 untilDeallocOrReuseSignal
 只是为了代码提示
 */
@property (nonatomic, strong, readonly) RACSignal<RACUnit *> *untilReuseOrDeallocSignal;

/**
 (UITableViewHeaderFooterView / UITableViewCell / UICollectionReusableView/ MKAnnotationView)有 rac_prepareForReuseSignal
 rac_prepareForReuseSignal 是复用的时候 会让上次的completed 但是Dealloc不会执行completed
 rac_willDeallocSignal 是Dealloc执行completed
 
 【复用组件 既想复用的时候结束也想销毁的时候能结束】
 untilDeallocOrReuseSignal 【等价】 untilDeallocOrReuseSignal
 只是为了代码提示
 */
@property (nonatomic, strong, readonly) RACSignal<RACUnit *> *untilDeallocOrReuseSignal;

/**
 重复添加的问题(批量场景)
 每次都要重置对象
 - (void)prepareForReuse {
     [super prepareForReuse];
     self.disposeBag = [[NSObject alloc] init];
 }
 */
//@property (nonatomic, strong, readonly) RACCompoundDisposable *disposeBag;
@end

NS_ASSUME_NONNULL_END
