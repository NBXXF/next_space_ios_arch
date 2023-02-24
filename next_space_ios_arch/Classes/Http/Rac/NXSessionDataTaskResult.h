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
 参考
NXNetworkingTaskUrlKey;
NXNetworkingTaskMethodKey;
NXNetworkingTaskParametersKey;
NXNetworkingTaskHeadersKey;
 */
@property(nonatomic,strong)NSDictionary *userInfo;
@property(nonatomic,assign,nullable) id responseObject;
@end

NS_ASSUME_NONNULL_END
