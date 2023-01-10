//
//  UIScreen+NXTools.h
//  next_space_ios_arch
//
//  Created by XXF on 2022/12/20.
//

#import <Foundation/Foundation.h>

//宏 定义大小
#define KRealWidth(px) [UIScreen.mainScreen getDensityValue:px]


NS_ASSUME_NONNULL_BEGIN

@interface UIScreen(NXTools)

/**
 屏幕缩放比例
 */
- (CGFloat)getDensity;

/**
 获取缩放适配的值
 */
-(CGFloat)getDensityValue:(CGFloat)value;


/**
 当前屏幕方向
 */
@property(nonatomic,assign,readonly) UIInterfaceOrientation orientation;


/**
 当前屏幕方向矩阵
 */
@property(nonatomic,assign,readonly) CGRect currentBounds;


/**
 当前屏幕方向大小
 */
@property(nonatomic,assign,readonly) CGSize currentSize;


/**
 最小边 边长度
 */
@property(nonatomic,assign,readonly)CGFloat minimumEdgeWidth;


/**
 最大边 边长度
 */
@property(nonatomic,assign,readonly)CGFloat maximumEdgeWidth;



/**
 获取指定屏幕的方向的矩阵
 */
- (CGRect)boundsForOrientation:(UIInterfaceOrientation)orientation;


/**
 获取指定屏幕的方向的大小
 */
- (CGSize)sizeForOrientation:(UIInterfaceOrientation)orientation;


@end

NS_ASSUME_NONNULL_END
