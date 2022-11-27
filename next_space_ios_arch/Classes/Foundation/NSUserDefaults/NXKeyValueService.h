//
//  NXKeyValueService.h
//  next_space_ios_arch
//
//  Created by XXF on 2022/11/27.
//

#import <Foundation/Foundation.h>
#import "NXKeyValueServiceProtocal.h"

NS_ASSUME_NONNULL_BEGIN

@interface NXKeyValueService :NSObject<NXKeyValueServiceProtocal>
@property (class, readonly, strong) NXKeyValueService *shared;
@end

NS_ASSUME_NONNULL_END
