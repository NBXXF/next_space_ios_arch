//
//  NXLifecycleEvent.m
//  next_space_ios_arch
//
//  Created by XXF on 2023/2/14.
//

#import "NXLifecycleEvent.h"
@interface NXLifecycleEvent()
@property(nonatomic,strong,class)  NXLifecycleEvent *viewDidLoad;
@property(nonatomic,strong,class)  NXLifecycleEvent *viewWillAppear;
@property(nonatomic,strong,class)  NXLifecycleEvent *viewDidAppear;
@property(nonatomic,strong,class)  NXLifecycleEvent *viewWillDisappear;
@property(nonatomic,strong,class)  NXLifecycleEvent *viewDidDisappear;
@property(nonatomic,strong,class)  NXLifecycleEvent *viewDealloc;


@property(nonatomic,assign)SEL selctor;

@end
@implementation NXLifecycleEvent
-(instancetype)initWithSelector:(SEL)selctor{
    self=[super init];
    if(self){
        self.selctor=selctor;
    }
    return  self;
}
+ (void)initialize{
    NXLifecycleEvent.viewDidLoad=NXLifecycleEvent.new;
}

@end
