//
//  NXBus.h
//  ios_oc_reactiveCocoa
//
//  Created by XXF on 2021/8/3.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface NXBus : NSObject
+(RACSignal *)subscribeEvent:(Class )t;
+(void)postEvent:(id)event;
@end

NS_ASSUME_NONNULL_END
