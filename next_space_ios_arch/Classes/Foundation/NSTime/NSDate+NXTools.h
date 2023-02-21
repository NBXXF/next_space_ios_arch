//
//  NSDate+NXTools.h
//  next_space_ios_arch
//
//  Created by XXF on 2023/2/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate(NXTools)

+ (void)initializeStatics;

+ (NSCalendar *)sharedCalendar;
+ (NSDateFormatter *)sharedDateFormatter;


@property (nonatomic,assign,readonly,class) long long currentTimeMillis;/// < 当前时间戳
@property (nonatomic,strong,readonly,class) NSString *currentTimeMillisString;/// < 当前时间戳
@property (nonatomic,assign,readonly) NSInteger dayOfYear; ///< Day component (1~365或者366)
@property(nonatomic,assign,readonly)  long long milliseconds;/// 时间戳 毫秒

/**
 开始结束时间区域
 */
@property (nonatomic,strong,readonly)  NSDate *beginningOfWeek;
@property (nonatomic,strong,readonly)  NSDate *beginningOfDay;
@property (nonatomic,strong,readonly)  NSDate *endOfWeek;
@end

NS_ASSUME_NONNULL_END
