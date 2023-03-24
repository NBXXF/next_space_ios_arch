//
//  UILabel+NXCopy.h
//  AFNetworking
//  支持能复制的Label
//  Created by XXF on 2023/3/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel(NXCopy)
/**
 是否允许拷贝文字
 */
@property(nonatomic,assign)BOOL enableCopyText;
@end

NS_ASSUME_NONNULL_END
