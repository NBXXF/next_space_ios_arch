//
//  UIImage+NXFile.m
//  next_space_ios_arch
//
//  Created by XXF on 2023/3/1.
//

#import "UIImage+NXTools.h"

@implementation UIImage(NXFile)
CGFloat degreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};
CGFloat radiansToDegrees(CGFloat radians) {return radians * 180/M_PI;};


- (BOOL)writePNGToFile:(NSString *)path
            atomically:(BOOL)useAuxiliaryFile{
    BOOL result = [self.toPNGData writeToFile:path
                                                   atomically:YES];
    return result;
}
- (BOOL)writePNGToFile:(NSString *)path
               options:(NSDataWritingOptions)writeOptionsMask
                 error:(NSError *__autoreleasing  _Nullable *)errorPtr{
    BOOL result = [self.toPNGData writeToFile:path
                                                      options:writeOptionsMask
                                                        error:errorPtr];
    return result;
}

- (BOOL)writeJPEGToFile:(NSString *)path
             atomically:(BOOL)useAuxiliaryFile{
    return [self writeJPEGToFile:path
                      atomically:useAuxiliaryFile
              compressionQuality:1];
}

- (BOOL)writeJPEGToFile:(NSString *)path
             atomically:(BOOL)useAuxiliaryFile
     compressionQuality:(CGFloat)compressionQuality
{
    BOOL result = [[self toJPEGDataWithQuality:compressionQuality] writeToFile:path
                                                                        atomically:YES];
    return result;
}

- (BOOL)writeJPEGToFile:(NSString *)path
                options:(NSDataWritingOptions)writeOptionsMask
                  error:(NSError *__autoreleasing  _Nullable *)errorPtr{
    return [self writeJPEGToFile:path
                         options:writeOptionsMask
                           error:errorPtr
              compressionQuality:1];
}

- (BOOL)writeJPEGToFile:(NSString *)path
                options:(NSDataWritingOptions)writeOptionsMask
                  error:(NSError *__autoreleasing  _Nullable *)errorPtr
     compressionQuality:(CGFloat)compressionQuality{
    BOOL result = [[self toJPEGDataWithQuality:compressionQuality] writeToFile:path
                                                                           options:writeOptionsMask
                                                                             error:errorPtr];
    return result;
}

/**
 最高效的一种方式,尤其是对大图片有好处
 UIImagePNGRepresentation 会导致内存与CPU暴涨
 @param fileType 参考系统api 有 kUTTypeJPEG, kUTTypePNG
 */
-(BOOL)writeToFile:(NSString *)path fileType:(CFStringRef)fileType{
    @try {
        NSURL *tmpURL = [NSURL fileURLWithPath:path];
        CGImageDestinationRef destination = CGImageDestinationCreateWithURL((__bridge CFURLRef)tmpURL, fileType, 1, nil);
        CGImageDestinationAddImage(destination, self.CGImage, nil);
        CGImageDestinationFinalize(destination);
        CFRelease(destination);
        return YES;
    } @catch (NSObject *exception) {
        return NO;
    }
}




- (NSData *)toPNGData{
    return UIImagePNGRepresentation(self);
}

- (NSData *)toJPEGData{
    return [self toJPEGDataWithQuality:1];
}
- (NSData *)toJPEGDataWithQuality:(CGFloat)compressionQuality{
    return UIImageJPEGRepresentation(self, compressionQuality);
}





/*
    根据颜色获取图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color{
    return [self imageWithColor:color size:CGSizeMake(1, 1)];
}

/*
    根据颜色获取图片  大小自定
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

///禁止图片旋转
+(UIImage *)fixOrientation:(UIImage *)aImage {

    

    // No-op if the orientation is already correct

    if (aImage.imageOrientation == UIImageOrientationUp)

        return aImage;

    

    // We need to calculate the proper transformation to make the image upright.

    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.

    CGAffineTransform transform = CGAffineTransformIdentity;

    

    switch (aImage.imageOrientation) {

        case UIImageOrientationDown:

        case UIImageOrientationDownMirrored:

            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);

            transform = CGAffineTransformRotate(transform, M_PI);

            break;

            

        case UIImageOrientationLeft:

        case UIImageOrientationLeftMirrored:

            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);

            transform = CGAffineTransformRotate(transform, M_PI_2);

            break;

            

        case UIImageOrientationRight:

        case UIImageOrientationRightMirrored:

            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);

            transform = CGAffineTransformRotate(transform, -M_PI_2);

            break;

        default:

            break;

    }

    

    switch (aImage.imageOrientation) {

        case UIImageOrientationUpMirrored:

        case UIImageOrientationDownMirrored:

            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);

            transform = CGAffineTransformScale(transform, -1, 1);

            break;

            

        case UIImageOrientationLeftMirrored:

        case UIImageOrientationRightMirrored:

            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);

            transform = CGAffineTransformScale(transform, -1, 1);

            break;

        default:

            break;

    }

    

    // Now we draw the underlying CGImage into a new context, applying the transform

    // calculated above.

    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,

                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,

                                             CGImageGetColorSpace(aImage.CGImage),

                                             CGImageGetBitmapInfo(aImage.CGImage));

    CGContextConcatCTM(ctx, transform);

    switch (aImage.imageOrientation) {

        case UIImageOrientationLeft:

        case UIImageOrientationLeftMirrored:

        case UIImageOrientationRight:

        case UIImageOrientationRightMirrored:

            // Grr...

            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);

            break;

            

        default:

            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);

            break;

    }

    

    // And now we just create a new UIImage from the drawing context

    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);

    UIImage *img = [UIImage imageWithCGImage:cgimg];

    CGContextRelease(ctx);

    CGImageRelease(cgimg);

    return img;

}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)cropToRect:(CGRect)rect {
    CGFloat scale = rect.size.width / self.size.width;
    scale = self.size.height * scale < rect.size.height ? rect.size.height/self.size.height : scale;
    CGSize croppedImsize = CGSizeMake(rect.size.width/scale, rect.size.height/scale);
    CGRect croppedImrect = CGRectMake((self.size.width-croppedImsize.width)/2.0, (self.size.height-croppedImsize.height)/2.0, croppedImsize.width, croppedImsize.height);
    UIGraphicsBeginImageContextWithOptions(croppedImsize, NO, 0.0);
    [self drawAtPoint:CGPointMake(-croppedImrect.origin.x, -croppedImrect.origin.y)];
    UIImage *croppedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [UIImage imageWithImage:croppedImage scaledToSize:rect.size];
}



- (UIImage *)imageByFilledWithColor:(UIColor *)color {
    return [self imageWithTintColor:color];
}

- (UIImage *)imageWithRotate:(CGFloat)angle {
    
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.size.width, self.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(degreesToRadians(angle));
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    // Rotate the image context
    CGContextRotateCTM(bitmap, degreesToRadians(angle));
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)imageByApplyingAlpha:(CGFloat) alpha {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);

    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, self.size.width, self.size.height);

    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);

    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);

    CGContextSetAlpha(ctx, alpha);

    CGContextDrawImage(ctx, area, self.CGImage);

    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return newImage;
}

@end
