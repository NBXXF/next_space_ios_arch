//
//  NXKeyValueServiceProtocal.h
//  next_space_ios_arch
/**
 定义key value 存储服务,先设计为底层为MMKV 可支持NSUserDefault 切换,也为业务主线程大量访问过渡做准备
 设计标准
 1.比NSUserDefault高效 且API保持一致 没有学习替换成本
 2.监听 需要实现 比rac_channelTerminalForKey更高效
 3.支持不同用户存储,不用业务去组装不同user的key
 
*/
//  Created by XXF on 2022/11/27.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

@protocol NXKeyValueServiceProtocal <NSObject>

/**
 返回值是真正的key  比rac_channelTerminalForKey更高效,业务自己比较value 是否产生改变
 */
-(RACSignal<NSString *> *_Nonnull)observeChangeWithKey:(NSString *_Nonnull)key
                                    differUser:(BOOL)differUser;


-(BOOL)isDifferUserForKey:(NSString *_Nonnull)key;



-( NSString * _Nonnull )generateKey:(NSString *_Nonnull)key
                         differUser:(BOOL)differUser;



- (void)removeObjectForKey:(NSString *_Nonnull)key
                differUser:(BOOL)differUser;



- (void)setObject:(nullable NSObject<NSCoding> *)value
           forKey:(NSString *_Nonnull)key
           differUser:(BOOL)differUser;

- (nullable NSObject<NSCoding> *)objectForKey:(NSString *_Nonnull)key
               defaultValue:(nullable id)defaultValue
                 differUser:(BOOL)differUser;




- (void)setObjectToJson:(nullable NSObject *)value
           forKey:(NSString *_Nonnull)key
           differUser:(BOOL)differUser;

- (nullable NSObject *)objectFromJson:(Class _Nonnull)value
           forKey:(NSString *_Nonnull)key
           defaultValue:(nullable NSObject *)defaultValue
           differUser:(BOOL)differUser;






- (void)setString:(nullable NSString *)value
           forKey:(NSString *_Nonnull)key
           differUser:(BOOL)differUser;

- (nullable NSString *)stringForKey:(NSString *_Nonnull)key
                       defaultValue:(nullable NSString *)defaultValue
                         differUser:(BOOL)differUser;




- (void)seData:(nullable NSData *)value
        forKey:(NSString *_Nonnull)key
        differUser:(BOOL)differUser;

- (nullable NSData *)dataForKey:(NSString *_Nonnull)key
                   defaultValue:(nullable NSData *)defaultValue
                     differUser:(BOOL)differUser;





- (void)setInteger:(NSInteger)value
            forKey:(NSString *_Nonnull)key
            differUser:(BOOL)differUser;

- (NSInteger)integerForKey:(NSString *_Nonnull)key
              defaultValue:(NSInteger)defaultValue
                differUser:(BOOL)differUser;





- (void)setFloat:(float)value
          forKey:(NSString *_Nonnull)key
          differUser:(BOOL)differUser;

- (float)floatForKey:(NSString *_Nonnull)key
        defaultValue:(float)defaultValue
          differUser:(BOOL)differUser;





- (void)setDouble:(double)value
           forKey:(NSString *_Nonnull)key
           differUser:(BOOL)differUser;

- (double)doubleForKey:(NSString *_Nonnull)key
          defaultValue:(double)defaultValue
            differUser:(BOOL)differUser;





- (void)setBool:(BOOL)value
         forKey:(NSString *_Nonnull)key
         differUser:(BOOL)differUser;

- (BOOL)boolForKey:(NSString *_Nonnull)key
      defaultValue:(BOOL)defaultValue
        differUser:(BOOL)differUser;



@end
