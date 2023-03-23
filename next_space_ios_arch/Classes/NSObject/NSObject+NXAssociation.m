//
//  NSObject+NXAssociation.m
//  next_space_ios_arch
//
//  Created by XXF on 2023/3/22.
//

#import "NSObject+NXAssociation.h"

static NSMutableDictionary *objcAssociatedObjectKeyBuffer;
@implementation NSObject(NXAssociation)
+ (void)load {
    objcAssociatedObjectKeyBuffer = [NSMutableDictionary dictionary];
}

- (void)setObjcAssociatedObject:(id)object
                         forKey:(NSString *)key
                         policy:(objc_AssociationPolicy)policy{
    const char *cKey = [objcAssociatedObjectKeyBuffer[key] pointerValue];
    if (cKey == NULL) {
        cKey = key.UTF8String;
        objcAssociatedObjectKeyBuffer[key] = [NSValue valueWithPointer:cKey];
    }
    objc_setAssociatedObject(self, cKey, object, policy);
}

- (void)setObjcAssociatedObject:(id)object forKey:(NSString *)key{
    [self setObjcAssociatedObject:object forKey:key policy:OBJC_ASSOCIATION_RETAIN];
}


- (id)getObjcAssociatedObject:(NSString *)key{
    const char *cKey = [objcAssociatedObjectKeyBuffer[key] pointerValue];
    if (cKey == NULL) {
        return nil;
    } else {
        return objc_getAssociatedObject(self, cKey);
    }
}

@end
