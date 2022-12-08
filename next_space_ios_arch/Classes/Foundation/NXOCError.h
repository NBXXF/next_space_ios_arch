//
//  NXResponseException.h
//  next_space
//
//  Created by XXF on 2021/7/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NXOCError : NSError

@property(nonatomic,copy) NSString *msg;

-(instancetype)initWithCode:(NSInteger)code andMsg:(NSString *)msg andExt:(NSDictionary *)ext;

/// 通用参数错误
+(NXOCError *)paramsError;
/// 无权限操作提示
+(NXOCError *)noPermissionError;

@end

NS_ASSUME_NONNULL_END
