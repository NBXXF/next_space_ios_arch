//
//  NSError+NXTools.h
//  next_space_ios_arch
//
//  Created by XXF on 2022/12/12.
//


NS_ASSUME_NONNULL_BEGIN

@interface NSError(NXTools)
/**
 比较万能,业务上下游不确定的时候 还有框架保险机制
 1.throw的error  try catch(NSException *) 生效么？
 2.throw的exception  try catch(NSError *) 生效么？
 3.throw的exception或者error  try catch(id *) 生效么？
 答案是NSError 和NSException没任何关系,如果写了具体的类型 类型对不上反而无效
 1.无效
 2.无效
 3.都有效
 
 内部支持将NSException 和NSError转换成 NSError
 
 用法 eg.
 @catch (NSObject *exception) {
    NSError *error=[NSError nx_ErrorWithErrorOrException:exception];
 }
 */
+ (NSError *)nx_ErrorWithErrorOrException:(NSObject *)errorOrException;

+ (NSError *)nx_ErrorWithCode:(NSInteger)code text:(NSString *)text;

+ (NSError *)nx_ErrorWithError:(NSError *)error userInfo:(NSDictionary *)userInfo;

+ (NSError *)nx_convertException:(NSException *)exception;

@end

NS_ASSUME_NONNULL_END
