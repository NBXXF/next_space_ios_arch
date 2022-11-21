//
//  TKGradient.h
//  AFNetworking
//
//  Created by 1234 on 2022/11/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKGradient : NSObject<NSCopying>

/**
 颜色
 */
@property(nonatomic,strong)UIColor *color;
/**
 位置比例 0-1.0
 */
@property(nonatomic,assign)CGFloat *location;

- (instancetype)initWithBlock: (void (^)(__kindof TKGradient * _Nonnull it))block;

@end

NS_ASSUME_NONNULL_END
