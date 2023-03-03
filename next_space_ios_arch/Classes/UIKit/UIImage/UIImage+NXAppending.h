//
//  UIImage+NXFile.h
//  next_space_ios_arch
//  拼接图片
//  Created by XXF on 2023/3/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/* 拼接图片的位置 */
typedef enum : NSUInteger {
    NXImageAppendingDirectionAbove,       // 拼接到上方
    NXImageAppendingDirectionBelow,       // 拼接到下方
    NXImageAppendingDirectionLeft,        // 拼接到左边
    NXImageAppendingDirectionRight,       // 拼接到右边
} NXImageAppendingDirection;


/* 拼接图片的对齐方式 */
typedef enum : NSUInteger {
    NXImageAppendingAlignmentUp,          // 居上对齐
    NXImageAppendingAlignmentDown,        // 居下对齐
    NXImageAppendingAlignmentLeft,        // 居左对齐
    NXImageAppendingAlignmentRight,       // 居右对齐
    NXImageAppendingAlignmentCenter,      // 居中对齐
} NXImageAppendingAlignment;

@interface UIImage (NXAppending)

/**
 拼接图片
 
              |————> gap
              |
    |—————————|——————————|—
    ||——————| ||——————|  |
    || 图片一|  | 图片二|  |
    ||______|  |______|  |
    |————————————————————|
 
 @param image 要拼接的图片
 @param gap 拼接图片之间的间隔
 @param appendingDirection 需要拼接到的位置
 @param appendingAlignment 拼接时的对齐方式
 @return 拼接后的图片
 */
- (UIImage * _Nullable)appendingWithImage:(UIImage * _Nonnull)image
                                 imageGap:(CGFloat)gap
                       appendingDirection:(NXImageAppendingDirection)appendingDirection
                       appendingAlignment:(NXImageAppendingAlignment)appendingAlignment;

@end

NS_ASSUME_NONNULL_END
