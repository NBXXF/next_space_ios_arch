//
//  NXSessionDataTask.h
//  next_space_ios_arch
//
//  Created by XXF on 2023/2/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NXSessionDataTaskResult : NSObject

/**
 参考NXHTTPSessionManager+RACSingal 中定义
 NXNetworkingTaskRequestUrlKey;
 NXNetworkingTaskRequestMethodKey;
 NXNetworkingTaskRequestParametersKey;
 NXNetworkingTaskRequestHeadersKey;
 NXNetworkingTaskResponseHeadersKey;
 NXNetworkingTaskResponseIsCacheKey;
 */
@property(nonatomic,strong)NSDictionary *userInfo;
@property(nonatomic,strong,nullable) id responseObject;
@end

NS_ASSUME_NONNULL_END
