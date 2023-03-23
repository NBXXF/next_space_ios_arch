//
//  NSObject+NXAssociation.m
//  next_space_ios_arch
//
//  Created by XXF on 2023/3/22.
//

#import "NSObject+NXAssociation.h"
#import <objc/runtime.h>
static NSMutableDictionary *objcAssociatedObjectKeyBuffer;
@implementation NSObject(NXAssociation)
+ (void)load {
    objcAssociatedObjectKeyBuffer = [NSMutableDictionary dictionary];
}

- (void)nx_setAssociatedObject:(id)object
                         forKey:(NSString *)key
                         policy:(NX_AssociationPolicy)policy{
    const char *cKey = [objcAssociatedObjectKeyBuffer[key] pointerValue];
    if (cKey == NULL) {
        cKey = key.UTF8String;
        objcAssociatedObjectKeyBuffer[key] = [NSValue valueWithPointer:cKey];
    }
    objc_setAssociatedObject(self, cKey, object, (objc_AssociationPolicy)policy);
}

- (void)nx_setAssociatedObject:(id)object forKey:(NSString *)key{
    [self nx_setAssociatedObject:object forKey:key policy:NX_ASSOCIATION_RETAIN];
}


- (id)nx_getAssociatedObject:(NSString *)key{
    const char *cKey = [objcAssociatedObjectKeyBuffer[key] pointerValue];
    if (cKey == NULL) {
        return nil;
    } else {
        return objc_getAssociatedObject(self, cKey);
    }
}

@end
