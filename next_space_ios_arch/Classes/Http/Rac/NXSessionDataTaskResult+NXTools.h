//
//  NXSessionDataTaskResult+NXTools.h
//  next_space_ios_arch
//
//  Created by XXF on 2023/2/24.
//

#import <Foundation/Foundation.h>
#import <next_space_ios_arch/NXSessionDataTaskResult.h>

NS_ASSUME_NONNULL_BEGIN

@interface NXSessionDataTaskResult(NXTools)
/**
 对应NSDictory 和NSArray
 */
@property(nonatomic,assign,readonly) BOOL isJSON;

/**
 对应NSData
 */
@property(nonatomic,assign,readonly) BOOL isBinary;
@end

NS_ASSUME_NONNULL_END
