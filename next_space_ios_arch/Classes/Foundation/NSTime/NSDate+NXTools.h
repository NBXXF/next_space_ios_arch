//
//  NSDate+NXTools.h
//  next_space_ios_arch
//
//  Created by XXF on 2023/2/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate(NXTools)
@property (nonatomic,assign,readonly,class) long long currentTimeMillis;/// < 当前时间戳
@property (nonatomic,strong,readonly,class) NSString *currentTimeMillisString;/// < 当前时间戳
@property (nonatomic,assign,readonly) NSInteger dayOfYear; ///< Day component (1~365或者366)
@property(nonatomic,assign,readonly)  long long milliseconds;/// 时间戳 毫秒

@property (nonatomic,assign,readonly) long long startMillisOfDay; /// 这天的开始时间毫秒
@property (nonatomic,assign,readonly) long long endMillisOfDay; /// 这天的结束时间毫秒
@end

NS_ASSUME_NONNULL_END
