//
//  UIImage+NXFile.m
//  next_space_ios_arch
//
//  Created by XXF on 2023/3/1.
//

#import "UIImage+NXFile.h"

@implementation UIImage(NXFile)

- (BOOL)writePNGToFile:(NSString *)path atomically:(BOOL)useAuxiliaryFile{
    BOOL result = [UIImagePNGRepresentation(self) writeToFile:path atomically:YES];
    return result;
}
- (BOOL)writePNGToFile:(NSString *)path options:(NSDataWritingOptions)writeOptionsMask error:(NSError *__autoreleasing  _Nullable *)errorPtr{
    BOOL result = [UIImagePNGRepresentation(self) writeToFile:path options:writeOptionsMask error:errorPtr];
    return result;
}
@end
