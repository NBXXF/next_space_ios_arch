//
//  NSObject+NXUtil.h
//  NX
//
//  Created by hedeyong on 16/9/12.
//  Copyright © 2021年 NextSpace. All rights reserved.
//

#import <Foundation/Foundation.h>


#define kNXUserInfo @"bdhkuserinfo"
#define kNXUserInfoAdditon @"bdhkuserinfo_addition"

#define NX_setYYUserInfo(obj_,value_) [obj_ setAssociatedObject:kNXUserInfo value:(value_)]
#define NX_getYYUserInfo(obj_) [(obj_) getAssociatedObject:kNXUserInfo]

#define NX_setYYUserInfoAdd(obj_,value_) [obj_ setAssociatedObject:kNXUserInfoAdditon value:(value_)]
#define NX_getYYUserInfoAdd(obj_) [(obj_) getAssociatedObject:kNXUserInfoAdditon]


@class NXDestoryNotify;

//自己义释放前调用的 block
typedef void(^NXDestoryNotifyBlock)(NXDestoryNotify *notify);


@interface NSObject (NXUtil)

/*!
 @method swizzleMethod:withMethod:error:
 @abstract 对方法进行替换
 @param originalSelector 想要替换的方法
 @param swizzledSelector 实际替换为的方法
 @param error 替换过程中出现的错误，如果没有错误为nil; NSError* __autoreleasing error = nil;
 @result 返回是否替换成功
 */
+ (BOOL)swizzleMethod:(SEL)originalSelector withMethod:(SEL)swizzledSelector error:(NSError * __autoreleasing *)error;

/*!
 @method performSelector:array:
 @abstract performSelector 扩展
 @param aSelector selector
 @param objects NSArray类型参数指针
 @result 返回调用的值类型为id
 */
- (id)performSelector:(SEL)aSelector array:(NSArray *)objects;

/*!
 @method performSelector:parameters:
 @abstract performSelector 扩展
 @param aSelector selector
 @param parameters 参数指针
 @result 返回调用的值类型为id
 */
- (id)performSelector:(SEL)aSelector parameters:(void *)parameters, ...;

/*!
 @method performSelector:afterDelay:parameters:
 @abstract performSelector 扩展
 @param aSelector selector
 @param delay 延时执行
 @param parameters NSObject类型参数指针，这里不能用void *，因为非NSObject局部变量不能retain
 */
- (void)performSelector:(SEL)aSelector afterDelay:(NSTimeInterval)delay parameters:(NSObject *)parameters, ...;

/*!
 @method setAssociatedObject:value:
 @abstract 设置一个对象与另外一个对象的关联，用完要用removeAssociatedObject:或removeAssociatedObjects移除
 @param key 键
 @param value 值
 */
- (void)setAssociatedObject:(id)key value:(id)value;

/*!
 @method getAssociatedObject:
 @abstract 获取一个对象与另外一个对象的关联
 @param key 键
 @result 返回对象
 */
- (id)getAssociatedObject:(id)key;

/*!
 @method removeAssociatedObject:
 @abstract 移除一个对象与另外一个对象的关联
 @param key 键
 */
- (void)removeAssociatedObject:(id)key;

/*!
 @method associatedObjectExists:
 @abstract 获取一个对象与另外一个对象的关联是否存在
 @param key 键
 @result 返回BOOL存在为YES，不存在为NO
 */
- (BOOL)associatedObjectExists:(id)key;

/*!
 @method removeAssociatedObjects:
 @abstract 移除对象的关联
 */
- (void)removeAssociatedObjects;

/*!
 @method destoryNotifySetName:block:
 @param name key
 @param block 处理block
 @abstract 添加自己定义释放
 */
- (void)destoryNotifyAddName:(NSString *)name block:(NXDestoryNotifyBlock)block;

/*!
 @method destoryNotifySetName:userInfo:block:
 @param name key
 @param userInfo 自义定信息
 @param block 处理block
 @abstract 添加自己定义释放
 */
- (void)destoryNotifyAddName:(NSString *)name userInfo:(NSDictionary *)userInfo block:(NXDestoryNotifyBlock)block;

/*!
 @method destoryNotifyRemoveWithName:
 @abstract 移除自己定义释放
 */
- (void)destoryNotifyRemoveWithName:(NSString *)name;

@end


/*!
 @class NXDestoryNotify
 @abstract 释放自注销类
 */
@interface NXDestoryNotify : NSObject

/*!
 @property name
 @abstract 名称,Key
 */
@property (nonatomic, strong) NSString *name;

/*!
 @property userInfo
 @abstract 用户信息
 */
@property (nonatomic, strong) NSDictionary *userInfo;

/*!
 @property block
 @abstract 自己义释放前调用的 block
 */
@property (nonatomic, strong) NXDestoryNotifyBlock block;

@end

