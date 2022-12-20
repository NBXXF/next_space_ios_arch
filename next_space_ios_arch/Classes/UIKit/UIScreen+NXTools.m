//
//  UIScreen+NXTools.m
//  next_space_ios_arch
//
//  Created by XXF on 2022/12/20.
//

#import "UIScreen+NXTools.h"

@implementation UIScreen(NXTools)

- (CGFloat)getDensity{
    /**
     以scale==3 为基准   375的iphone x 和iphone 14 pro max 都在这一区间
     倒着运算  分辨率越低(区间) 文字越大
     **/
    static CGFloat standardScale=3;
    /**
     [UIScreen mainScreen].bounds.size.width 这个得到的是 【没有】乘以倍数的
     */
    static CGFloat density = 1.0;
    
    /**
     权重
     */
    static CGFloat weight=0.8;

    static dispatch_once_t  densityOnceToken;
    dispatch_once(&densityOnceToken, ^{
        if ([NSThread isMainThread]) {
            density = [self _formatDensity:standardScale/[[UIScreen mainScreen] scale]];
            if(density>1.0){
                density=[self _formatDensity:density *weight];
            }
        } else {
            dispatch_sync(dispatch_get_main_queue(), ^{
                density =[self _formatDensity: standardScale/[[UIScreen mainScreen] scale]];
                if(density>1.0){
                    density=[self _formatDensity:density *weight];
                }
            });
        }
    });
    return density;
}

-(CGFloat)_formatDensity:(CGFloat)density{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
            [formatter setPositiveFormat:@"###0.0"];
    formatter.maximumFractionDigits = 1;
    formatter.roundingMode = NSNumberFormatterRoundDown;
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    NSString *string = [formatter stringFromNumber:@(density)];
    return string.doubleValue;
}

- (CGFloat)getDensityValue:(CGFloat)value{
    return value*[self getDensity];
}
@end
