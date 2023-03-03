//
//  UIImage+NXFile.h
//  next_space_ios_arch
//  拼接图片
//  Created by XXF on 2023/3/1.
//


#import "UIImage+NXAppending.h"

@implementation UIImage (NXAppending)

/**
 拼接图片
 
 @param img 要拼接的图片
 @param gap 拼接图片之间的间隔
 @param appendingDirection 需要拼接到的位置
 @param appendingAlignment 拼接时的对齐方式
 @return 拼接后的图片
 */
- (UIImage * _Nullable)appendingWithImage:(UIImage * _Nonnull)img imageGap:(CGFloat)gap appendingDirection:(NXImageAppendingDirection)appendingDirection appendingAlignment:(NXImageAppendingAlignment)appendingAlignment {
    
    UIImage *retImg = self;
    
    if (!img || CGSizeEqualToSize(CGSizeZero, img.size)) {
        return retImg;
    }
    
    // 总大小
    CGSize totalSize = self.size;
    // 原始图片尺寸
    CGRect originImgFrame = CGRectMake(0, 0, self.size.width, self.size.height);
    // 拼接图片尺寸
    CGRect appendingImgFrame = CGRectMake(0, 0, img.size.width, img.size.height);
    
    switch (appendingDirection) {
        case NXImageAppendingDirectionAbove:
        {
            // 拼接到上方
            totalSize.width = self.size.width > img.size.width ? self.size.width : img.size.width;
            totalSize.height = self.size.height + gap + img.size.height;
            
            if (appendingAlignment == NXImageAppendingAlignmentLeft) {
                // 居左
                appendingImgFrame = CGRectMake(0, 0, img.size.width, img.size.height);
                originImgFrame = CGRectMake(0, img.size.height + gap, self.size.width, self.size.height);
                
            }else if(appendingAlignment == NXImageAppendingAlignmentRight) {
                // 居右
                appendingImgFrame = CGRectMake(totalSize.width - img.size.width, 0, img.size.width, img.size.height);
                originImgFrame = CGRectMake(totalSize.width - self.size.width, img.size.height + gap, self.size.width, self.size.height);
            }else {
                // 居中
                appendingImgFrame = CGRectMake((totalSize.width - img.size.width) / 2.0f, 0, img.size.width, img.size.height);
                originImgFrame = CGRectMake((totalSize.width - self.size.width) / 2.0f, img.size.height + gap, self.size.width, self.size.height);
            }
        }
            break;
            
        case NXImageAppendingDirectionBelow:
        {
            // 拼接到下方
            totalSize.width = self.size.width > img.size.width ? self.size.width : img.size.width;
            totalSize.height = self.size.height + gap + img.size.height;
            
            if (appendingAlignment == NXImageAppendingAlignmentLeft) {
                // 居左
                appendingImgFrame = CGRectMake(0, self.size.height + gap, img.size.width, img.size.height);
                originImgFrame = CGRectMake(0, 0, self.size.width, self.size.height);
                
            }else if(appendingAlignment == NXImageAppendingAlignmentRight) {
                // 居右
                appendingImgFrame = CGRectMake(totalSize.width - img.size.width, self.size.height + gap, img.size.width, img.size.height);
                originImgFrame = CGRectMake(totalSize.width - self.size.width, 0, self.size.width, self.size.height);
            }else {
                // 居中
                appendingImgFrame = CGRectMake((totalSize.width - img.size.width) / 2.0f, self.size.height + gap, img.size.width, img.size.height);
                originImgFrame = CGRectMake((totalSize.width - self.size.width) / 2.0f, 0, self.size.width, self.size.height);
            }
        }
            break;
            
        case NXImageAppendingDirectionLeft:
        {
            // 拼接到左边
            totalSize.width = self.size.width + img.size.width + gap;
            totalSize.height = self.size.height > img.size.height ? self.size.height : img.size.height;
            
            if (appendingAlignment == NXImageAppendingAlignmentUp) {
                // 居上
                appendingImgFrame = CGRectMake(0, 0, img.size.width, img.size.height);
                originImgFrame = CGRectMake(img.size.width + gap, 0, self.size.width, self.size.height);
                
            }else if(appendingAlignment == NXImageAppendingAlignmentDown) {
                // 居下
                appendingImgFrame = CGRectMake(0, totalSize.height - img.size.height, img.size.width, img.size.height);
                originImgFrame = CGRectMake(img.size.width + gap, totalSize.height - self.size.height, self.size.width, self.size.height);
            }else {
                // 居中
                appendingImgFrame = CGRectMake(0, (totalSize.height - img.size.height) / 2.0f, img.size.width, img.size.height);
                originImgFrame = CGRectMake(img.size.width + gap, (totalSize.height - self.size.height) / 2.0f, self.size.width, self.size.height);
            }
        }
            break;
            
        case NXImageAppendingDirectionRight:
        {
            // 拼接到右边
            totalSize.width = self.size.width + img.size.width + gap;
            totalSize.height = self.size.height > img.size.height ? self.size.height : img.size.height;
            
            if (appendingAlignment == NXImageAppendingAlignmentUp) {
                // 居上
                appendingImgFrame = CGRectMake(self.size.width + gap, 0, img.size.width, img.size.height);
                originImgFrame = CGRectMake(0, 0, self.size.width, self.size.height);
                
            }else if(appendingAlignment == NXImageAppendingAlignmentDown) {
                // 居下
                appendingImgFrame = CGRectMake(self.size.width + gap, totalSize.height - img.size.height, img.size.width, img.size.height);
                originImgFrame = CGRectMake(0, totalSize.height - self.size.height, self.size.width, self.size.height);
            }else {
                // 居中
                appendingImgFrame = CGRectMake(self.size.width + gap, (totalSize.height - img.size.height) / 2.0f, img.size.width, img.size.height);
                originImgFrame = CGRectMake(0, (totalSize.height - self.size.height) / 2.0f, self.size.width, self.size.height);
            }
        }
            break;
            
        default:
        {
            // 拼接到上方
            totalSize.width = self.size.width > img.size.width ? self.size.width : img.size.width;
            totalSize.height = self.size.height + gap + img.size.height;
            
            if (appendingAlignment == NXImageAppendingAlignmentLeft) {
                // 居左
                appendingImgFrame = CGRectMake(0, 0, img.size.width, img.size.height);
                originImgFrame = CGRectMake(0, img.size.height + gap, self.size.width, self.size.height);
                
            }else if(appendingAlignment == NXImageAppendingAlignmentRight) {
                // 居右
                appendingImgFrame = CGRectMake(totalSize.width - img.size.width, 0, img.size.width, img.size.height);
                originImgFrame = CGRectMake(totalSize.width - self.size.width, img.size.height + gap, self.size.width, self.size.height);
            }else {
                // 居中
                appendingImgFrame = CGRectMake((totalSize.width - img.size.width) / 2.0f, 0, img.size.width, img.size.height);
                originImgFrame = CGRectMake((totalSize.width - self.size.width) / 2.0f, img.size.height + gap, self.size.width, self.size.height);
            }
        }
            break;
    }
    
    UIGraphicsBeginImageContextWithOptions(totalSize, NO, [UIScreen mainScreen].scale);

    [self drawInRect:originImgFrame];
    [img drawInRect:appendingImgFrame];
    
    retImg = UIGraphicsGetImageFromCurrentImageContext();
    
    return retImg;
}
@end
