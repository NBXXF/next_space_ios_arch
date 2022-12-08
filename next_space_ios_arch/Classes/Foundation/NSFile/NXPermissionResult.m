//
//  NXPermissionResult.m
//  next_space_ios_arch
//
//  Created by XXF on 2022/12/8.
//

#import "NXPermissionResult.h"

@implementation NXPermissionResult

- (instancetype)initWithEnable:(BOOL)enable andMsg:(NSString *)msg{
    self=[super init];
    if(self){
        self.enable=enable;
        self.msg=msg;
    }
    return self;
}
@end
