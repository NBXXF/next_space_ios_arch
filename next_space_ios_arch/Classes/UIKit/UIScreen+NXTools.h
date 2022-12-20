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

@end

NS_ASSUME_NONNULL_END
