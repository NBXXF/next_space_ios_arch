//
//  NSLayoutConstraint+NXVisibiltiy.h
//  XXF
//  替代系统的hidden字段隐藏还展位的情况
//  Created by xxf on 2022/11/21.
//
#import "NSLayoutConstraint+NXVisibiltiy.h"
#import <objc/runtime.h>

static const void *key = &key;

@implementation NSLayoutConstraint(NXVisibiltiy)

-(void)clear {
    if (self.constant != 0) {
        NSNumber *oldConstant = @(self.constant);
        self.constant = 0;
        objc_setAssociatedObject(self, &key, oldConstant, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

-(void)restore {
    NSNumber *oldConstant = objc_getAssociatedObject(self, &key);
    if (oldConstant) {
        self.constant = oldConstant.floatValue;
        objc_setAssociatedObject(self, &key, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

@end
