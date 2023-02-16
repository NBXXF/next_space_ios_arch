//
//  XXFConfigOption.h
//  next_space_ios_arch
//  配置
//  Created by XXF on 2022/8/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XXFConfigOption : NSObject

/**
 是否允许访问堆栈
 */
@property(nonatomic,assign) BOOL allowCallStackSymbols;

@end

NS_ASSUME_NONNULL_END
