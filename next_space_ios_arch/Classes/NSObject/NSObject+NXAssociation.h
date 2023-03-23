//
//  NSObject+NXAssociation.h
//  next_space_ios_arch
//
//  Created by XXF on 2023/3/22.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSObject(NXAssociation)

/**
 设置关联对象
 1.解决了常量key的问题,但key就必须是具体的类型,这里选择字符串(满足99%的业务)
 2.没有包装字典
 */
- (void)setObjcAssociatedObject:(id _Nullable)object
                     forKey:(NSString *)key
                     policy:(objc_AssociationPolicy)policy;


/**
 设置关联对象
 1.解决了常量key的问题,但key就必须是具体的类型,这里选择字符串(满足99%的业务)
 2.没有包装字典
 3.policy 默认OBJC_ASSOCIATION_RETAIN_NONATOMIC,参考了大部分框架都是这个策略
 注意不要将一个带生命周期的组件 存档到当前对象的关联对象里面,一般是po,dto,primertive value
 */
- (void)setObjcAssociatedObject:(id)object
                         forKey:(NSString *)key;


/**
 获取关联对象
 1.解决了常量key的问题,但key就必须是具体的类型,这里选择字符串(满足99%的业务)
 2.没有包装字典
 */
- (id)getObjcAssociatedObject:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
