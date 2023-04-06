//
//  UIImage+NXFile.h
//  next_space_ios_arch
//
//  Created by XXF on 2023/3/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage(NXFile)

/**
 将图片保存到本地
 图片保存本地
 */
- (BOOL)writePNGToFile:(NSString *)path
            atomically:(BOOL)useAuxiliaryFile;
- (BOOL)writePNGToFile:(NSString *)path
               options:(NSDataWritingOptions)writeOptionsMask
                 error:(NSError **)errorPtr;

- (BOOL)writeJPEGToFile:(NSString *)path
             atomically:(BOOL)useAuxiliaryFile;
- (BOOL)writeJPEGToFile:(NSString *)path
             atomically:(BOOL)useAuxiliaryFile
     compressionQuality:(CGFloat)compressionQuality;
- (BOOL)writeJPEGToFile:(NSString *)path
                options:(NSDataWritingOptions)writeOptionsMask
                  error:(NSError **)errorPtr;
- (BOOL)writeJPEGToFile:(NSString *)path
                options:(NSDataWritingOptions)writeOptionsMask
                  error:(NSError **)errorPtr
     compressionQuality:(CGFloat)compressionQuality;

/**
 转data
 */
-(NSData *)toPNGData;

-(NSData *)toJPEGData;
-(NSData *)toJPEGDataWithQuality:(CGFloat)compressionQuality;



/*
    根据颜色获取图片  大小1*1
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/*
    根据颜色获取图片  大小自定
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;


///禁止图片旋转
+(UIImage *)fixOrientation:(UIImage *)aImage;


//缩放图片
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

/// 裁剪并缩放到rect的size大小
/// - Parameter rect: 裁剪大小
- (UIImage *)cropToRect:(CGRect)rect;
/// 使用颜色填充图片
- (UIImage *)imageByFilledWithColor:(UIColor *)color;

/// 旋转图片
- (UIImage *)imageWithRotate:(CGFloat)angle;

/// 设置透明度
/// @param alpha 透明度
- (UIImage *)imageByApplyingAlpha:(CGFloat) alpha ;
@end

NS_ASSUME_NONNULL_END
