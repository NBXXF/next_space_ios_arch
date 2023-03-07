//
//  NSMutableDictionary+NXTools.h
//  next_space_ios_arch
//
//  Created by XXF on 2022/12/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableDictionary<KeyType,ObjectType>(NXTools)
/**
 变换整体
 */
-(instancetype)applyWithBlock:(void (^)(NSMutableDictionary<KeyType,ObjectType> *it))block;



/**
 注意全部是【正向】的方法,利于将语法糖写的字典转换过来 等价于- (void)setObject:(ObjectType)anObject forKey:(KeyType <NSCopying>)aKey;
 @abstract 检查设置指定key和anObject是不是为nil;不是则设置
 @param aKey 键
 @param anObject 值
 */
-(void)put:(id<NSCopying>)aKey forObject:(id)anObject;



/**
 注意全部是【正向】的方法,利于将语法糖写的字典转换过来 等价于- (void)setObject:(ObjectType)anObject forKey:(KeyType <NSCopying>)aKey;
 @abstract 检查设置指定key和anObject是不是为nil;不是则设置
 @param aKey 键
 @param anObject 值
 */
-(BOOL)putCheck:(id<NSCopying>)aKey forObject:(id)anObject;
@end

NS_ASSUME_NONNULL_END
