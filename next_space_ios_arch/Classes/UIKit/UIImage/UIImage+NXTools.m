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
    BOOL result = [self.PNGData writeToFile:path
                                                   atomically:YES];
    return result;
}
- (BOOL)writePNGToFile:(NSString *)path
               options:(NSDataWritingOptions)writeOptionsMask
                 error:(NSError *__autoreleasing  _Nullable *)errorPtr{
    BOOL result = [self.PNGData writeToFile:path
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
    BOOL result = [[self JPEGDataWithQuality:compressionQuality] writeToFile:path
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
    BOOL result = [[self JPEGDataWithQuality:compressionQuality] writeToFile:path
                                                                           options:writeOptionsMask
                                                                             error:errorPtr];
    return result;
}

- (NSData *)PNGData{
    return UIImagePNGRepresentation(self);
}

- (NSData *)JPEGData{
    return [self JPEGDataWithQuality:1];
}
- (NSData *)JPEGDataWithQuality:(CGFloat)compressionQuality{
    return UIImageJPEGRepresentation(self, compressionQuality);
}


@end
