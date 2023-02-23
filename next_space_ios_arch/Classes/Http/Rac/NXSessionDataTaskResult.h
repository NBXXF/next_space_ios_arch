//
//  NXSessionDataTask.h
//  next_space_ios_arch
//
//  Created by XXF on 2023/2/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NXSessionDataTaskResult : NSObject
@property(nonatomic,strong) NSURLSessionDataTask *task;
@property(nonatomic,assign,nullable) id responseObject;
@end

NS_ASSUME_NONNULL_END
