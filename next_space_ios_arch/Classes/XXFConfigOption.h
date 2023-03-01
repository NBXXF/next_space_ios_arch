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
 是否允许访问堆栈 (仅debug生效)
 */
@property(nonatomic,assign) BOOL allowCallStackSymbols;

/**
 一个类最大绑定唯一标识的RAC数量 (仅debug生效)
 */
@property(nonatomic,assign) NSInteger maxBindIdentifierSubjectCount;

/**
 是否禁止线程检查
 */
@property(nonatomic,assign) BOOL disableThreadCheck;

/**
 是否禁止CPU检查
 */
@property(nonatomic,assign) BOOL disableCpuCheck;

/**
 是否禁止内存检查
 */
@property(nonatomic,assign) BOOL disableMemoryCheck;

@end

NS_ASSUME_NONNULL_END
