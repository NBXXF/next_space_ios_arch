//
//  UIResponder+NXTools.h
//  next_space_ios_arch
//
//  Created by XXF on 2023/2/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIResponder(NXTools)
/**
  向上查找对应的nextResponder
 */
- (UIResponder * __nullable)findNextResponderClass:(Class)clazz;

/**
 向上查找对应的nextResponder
 */
- (UIResponder * __nullable)findNextResponderBlock:(BOOL (^)(UIResponder *nextResponder))block;

@end

NS_ASSUME_NONNULL_END
