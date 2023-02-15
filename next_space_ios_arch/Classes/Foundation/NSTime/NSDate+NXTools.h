//
//  NSDate+NXTools.h
//  next_space_ios_arch
//
//  Created by XXF on 2023/2/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate(NXTools)
@property (nonatomic, readonly) NSInteger dayOfYear; ///< Day component (1~365或者366)
@end

NS_ASSUME_NONNULL_END
