//
//  UIImage+NXFile.m
//  next_space_ios_arch
//
//  Created by XXF on 2023/3/1.
//

#import "UIImage+NXTools.h"

@implementation UIImage(NXFile)

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

- (NSData *)toPNGData{
    return UIImagePNGRepresentation(self);
}

- (NSData *)toJPEGData{
    return [self toJPEGDataWithQuality:1];
}
- (NSData *)toJPEGDataWithQuality:(CGFloat)compressionQuality{
    return UIImageJPEGRepresentation(self, compressionQuality);
}


@end
