//
//  NXPermissionResult.h
//  next_space_ios_arch
//
//  Created by XXF on 2022/12/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NXPermissionResult : NSObject
@property(nonatomic,assign) BOOL enable;
@property(nonatomic,strong,nullable) NSString *msg;
- (instancetype)initWithEnable: (BOOL)enable andMsg:(NSString * __nullable)msg;
@end

NS_ASSUME_NONNULL_END
