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
- (BOOL)writePNGToFile:(NSString *)path atomically:(BOOL)useAuxiliaryFile;
- (BOOL)writePNGToFile:(NSString *)path options:(NSDataWritingOptions)writeOptionsMask error:(NSError **)errorPtr;


@end

NS_ASSUME_NONNULL_END
