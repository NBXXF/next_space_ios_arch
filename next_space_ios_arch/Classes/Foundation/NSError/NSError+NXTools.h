//
//  NSError+NXTools.h
//  next_space_ios_arch
//
//  Created by XXF on 2022/12/12.
//


NS_ASSUME_NONNULL_BEGIN

@interface NSError(NXTools)
+ (NSError *)nx_ErrorWithCode:(NSInteger)code text:(NSString *)text;

+ (NSError *)nx_ErrorWithError:(NSError *)error userInfo:(NSDictionary *)userInfo;

+ (NSError *)nx_convertException:(NSException *)exception;

@end

NS_ASSUME_NONNULL_END
