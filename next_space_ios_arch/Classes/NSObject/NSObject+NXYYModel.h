//
//  NSObject+NXYYModel.h
//  next_space_ios_arch
//  提供以json 形式的copy
//  Created by XXF on 2022/10/27.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject(NXYYModel)


+ (instancetype)copyFrom:(id)fromObject;

/**
 提供以json 形式的copy
 */
+ (instancetype)yy_modelCopyFrom:(id)fromObject;


-(id)copyTo:(Class)toClass;

/**
 提供以json 形式的copy
 */
-(id)yy_copyTo:(Class)toClass;


/**
  增强功能 能解析基本类型 支持数字和字符串
 + (nullable instancetype)yy_modelWithJSON:(id)json;
 */
+ (nullable instancetype)nx_fromJSON:(id)json;

@end

NS_ASSUME_NONNULL_END
