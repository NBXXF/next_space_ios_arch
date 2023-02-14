//
//  NXLifecycleEvent.h
//  next_space_ios_arch
//
//  Created by XXF on 2023/2/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NXLifecycleEvent : NSObject
@property(nonatomic,strong,readonly,class)  NXLifecycleEvent *viewDidLoad;
@property(nonatomic,strong,readonly,class)  NXLifecycleEvent *viewWillAppear;
@property(nonatomic,strong,readonly,class)  NXLifecycleEvent *viewDidAppear;
@property(nonatomic,strong,readonly,class)  NXLifecycleEvent *viewWillDisappear;
@property(nonatomic,strong,readonly,class)  NXLifecycleEvent *viewDidDisappear;
@property(nonatomic,strong,readonly,class)  NXLifecycleEvent *viewDealloc;
@end

NS_ASSUME_NONNULL_END
