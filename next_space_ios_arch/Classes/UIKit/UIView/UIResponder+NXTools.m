//
//  UIResponder+NXTools.m
//  next_space_ios_arch
//
//  Created by 1234 on 2023/2/8.
//

#import "UIResponder+NXTools.h"

@implementation UIResponder(NXTools)

- (UIResponder *)findNextResponderClass:(Class)clazz{
    return [self findNextResponderBlock:^BOOL(UIResponder * _Nonnull nextResponder) {
        return nextResponder.class==clazz;
    }];
}

- (UIResponder *)findNextResponderBlock:(BOOL (^)(UIResponder * _Nonnull))block{
    UIResponder *nextResponder = self.nextResponder;
    while (nextResponder) {
        if(block(nextResponder)){
            return nextResponder;
        }
        nextResponder=[nextResponder nextResponder];
    }
    return nil;
}
@end
