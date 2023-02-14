//
//  NSObject+NXRACSignalSupport.h
//  next_space_ios_arch
//
//  Created by XXF on 2023/2/14.
//

#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject(NXRACSignalSupport)
/**
 是Dealloc执行completed
 */
@property (nonatomic, strong, readonly) RACSignal<RACUnit *> *untilDeallocSignal;
@end

NS_ASSUME_NONNULL_END
