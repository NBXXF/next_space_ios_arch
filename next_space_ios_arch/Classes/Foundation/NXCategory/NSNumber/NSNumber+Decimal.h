//
//  NSNumber+Decimal.h
//  ETicket
//
//  Created by chunjian wang on 14/12/2017.
//  Copyright © 2017 Bkex Technology Co.Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef numberObj
#define numberObj(object) ((typeof(object))_SL_MakeNumber(object))
#endif

typedef NSNumber *(^CaculBlock)(NSNumber *);
typedef NSNumber *(^CaculRoundBlock)(NSNumber *, NSInteger scale);
typedef NSNumber *(^GetRoundBlock)(NSInteger scale);
typedef BOOL (^CompBlock)(NSNumber *);

@interface NSNumber(Decimal)

@property (nonatomic, readonly) NSDecimalNumber *decimalWrapper;
@property (nonatomic, readonly) NSDecimalNumber *formatDecimalWrapper;

/// >
- (CompBlock)g;
 /// >=
- (CompBlock)ge;
/// <
- (CompBlock)l;
/// <=
- (CompBlock)le;
/// ==
- (CompBlock)e;
/// !=
- (CompBlock)ne;
/// +
- (CaculBlock)add;
/// -
- (CaculBlock)sub;
 /// *
- (CaculBlock)mul;
/// /
- (CaculBlock)div;

//在运算过程中保留指定位数，内部捕获异常
- (CaculRoundBlock)addR;
- (CaculRoundBlock)subR;
- (CaculRoundBlock)mulR;
- (CaculRoundBlock)divR;

//如果运算中出现异常，抛出
- (CaculBlock)addExc;
- (CaculBlock)subExc;
- (CaculBlock)mulExc;
- (CaculBlock)divExc;

- (GetRoundBlock)roundToPlain;     // 四舍五入
- (GetRoundBlock)roundToBankers;   // 四舍五入六去耦
- (GetRoundBlock)roundToUp;        // 向上舍入
- (GetRoundBlock)roundToDown;      // 向下舍入

@end

static inline id _SL_MakeNumber(id object){
    return object ? object : [[NSDecimalNumber alloc] initWithString:@"0"];
}

