//
//  NSString+Decimal.h
//  ETicket
//
//  Created by chunjian wang on 2018/5/16.
//  Copyright © 2018年 chunjian wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>
#import "NSNumber+Decimal.h"
#import "NSNumber+Format.h"
typedef NSString *(^CalBlock)(NSString *);
typedef NSString *(^CalRoundBlock)(NSString *, NSInteger scale);
typedef NSString *(^RoundBlock)(NSInteger scale);
typedef BOOL (^CompareBlock)(NSString *);

#ifndef stringObj
#define stringObj(object) ((typeof(object))_SL_MakeString(object))
#endif

@interface NSString(Decimal)

- (NSDecimalNumber *)decimalWrapper;
- (NSDecimal)decimalStruct;
- (NSNumber *)toNumber;

- (CompareBlock)g;      // >
- (CompareBlock)ge;     // >=
- (CompareBlock)l;      // <
- (CompareBlock)le;     // <=
- (CompareBlock)e;      // ==
- (CompareBlock)ne;      // !=

- (CalBlock)add;        // +
- (CalBlock)sub;        // -
- (CalBlock)mul;        // *
- (CalBlock)div;        // /

//在运算过程中保留指定位数，内部捕获异常
- (CalRoundBlock)addR;
- (CalRoundBlock)subR;
- (CalRoundBlock)mulR;
- (CalRoundBlock)divR;

//如果运算中出现异常，抛出
- (CalBlock)addExc;
- (CalBlock)subExc;
- (CalBlock)mulExc;
- (CalBlock)divExc;

- (RoundBlock)roundToPlain;     // 四舍五入
- (RoundBlock)roundToBankers;   // 四舍五入六去耦
- (RoundBlock)roundToUp;        // 向上舍入
- (RoundBlock)roundToDown;      // 向下舍入

- (NSString *)removeLastZeroes;

- (NSInteger)digits;
///公式
- (NSInteger)formulaDigits;

@end

static inline id _SL_MakeString(id object){
    return object ? object : @"0";
}
