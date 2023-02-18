//
//  NSNumber+Decimal.m
//  ETicket
//
//  Created by chunjian wang on 14/12/2017.
//  Copyright © 2017 Bkex Technology Co.Ltd. All rights reserved.
//

#import "NSNumber+Decimal.h"

@implementation NSNumber(Decimal)

- (NSDecimalNumber *)decimalWrapper {
    return [NSDecimalNumber decimalNumberWithDecimal:self.decimalValue];
}

- (NSDecimalNumber *)formatDecimalWrapper {
    double doubleValue = [self doubleValue];
    NSString *doubleString = [NSString stringWithFormat:@"%.8f", doubleValue];
    return [NSDecimalNumber decimalNumberWithString:doubleString];
}

- (CompBlock)g {
    return ^BOOL (NSNumber *other) {
        other = other ?:@0;
        return [self.decimalWrapper compare:numberObj(other.decimalWrapper)] == NSOrderedDescending;
    };
}

- (CompBlock)ge {
    return ^BOOL (NSNumber *other) {
        other = other ?:@0;
        NSComparisonResult rel = [self.decimalWrapper compare:numberObj(other.decimalWrapper)];
        return rel == NSOrderedDescending || rel == NSOrderedSame;
    };
}

- (CompBlock)l {
    return ^BOOL (NSNumber *other) {
        other = other ?:@0;
        return [self.decimalWrapper compare:numberObj(other.decimalWrapper)] == NSOrderedAscending;
    };
}

- (CompBlock)le {
    return ^BOOL (NSNumber *other) {
        other = other ?:@0;
        NSComparisonResult rel = [self.decimalWrapper compare:numberObj(other.decimalWrapper)];
        return rel == NSOrderedAscending || rel == NSOrderedSame;
    };
}

- (CompBlock)e {
    return ^BOOL (NSNumber *other) {
        other = other ?:@0;
        return [self.decimalWrapper compare:numberObj(other.decimalWrapper)] == NSOrderedSame;
    };
}

- (CompBlock)ne {
    return ^BOOL (NSNumber *other) {
        other = other ?:@0;
        return [self.decimalWrapper compare:numberObj(other.decimalWrapper)] != NSOrderedSame;
    };
}

- (CaculBlock)add {
    return ^NSNumber *(NSNumber *other) {
        other = other ?:@0;
        NSNumber *rel = nil;
        @try {
            rel = [self.decimalWrapper decimalNumberByAdding:numberObj(other.decimalWrapper)];
            return rel;
        } @catch (NSException *exception) {
            return @0;
        }
    };
}

- (CaculBlock)sub {
    return ^NSNumber *(NSNumber *other) {
        other = other ?:@0;
        NSNumber *rel = nil;
        @try {
            rel = [self.decimalWrapper decimalNumberBySubtracting:numberObj(other.decimalWrapper)];
            return rel;
        } @catch (NSException *exception) {
            return @0;
        }
    };
}

- (CaculBlock)mul {
    return ^NSNumber *(NSNumber *other) {
        other = other ?:@0;
        NSDecimalNumber *rel = nil;
        @try {
            rel = [self.decimalWrapper decimalNumberByMultiplyingBy:numberObj(other.decimalWrapper)];
            return rel;
        } @catch (NSException *exception) {
            return @0;
        }
    };
}

- (CaculBlock)div {
    return ^NSNumber *(NSNumber *other) {
        other = other ?:@0;
        if (other.e(@0)) {
            return @0;
        }
        NSDecimalNumber *rel = nil;
        @try {
            rel = [self.decimalWrapper decimalNumberByDividingBy:numberObj(other.decimalWrapper)];
            return rel;
        } @catch (NSException *exception) {
            return @0;
        }
    };
}

- (CaculRoundBlock)addR {
    return ^NSNumber *(NSNumber *other, NSInteger scale) {
        NSNumber *rel = nil;
        @try {
            rel = [self.decimalWrapper decimalNumberByAdding:numberObj(other.decimalWrapper)];
            return rel.roundToPlain(scale);
        } @catch (NSException *exception) {
            return @0;
        }
    };
}

- (CaculRoundBlock)subR {
    return ^NSNumber *(NSNumber *other, NSInteger scale) {
        other = other ?:@0;
        NSNumber *rel = nil;
        @try {
            rel = [self.decimalWrapper decimalNumberBySubtracting:numberObj(other.decimalWrapper)];
            return rel.roundToPlain(scale);
        } @catch (NSException *exception) {
            return @0;
        }
    };
}

- (CaculRoundBlock)mulR {
    return ^NSNumber *(NSNumber *other, NSInteger scale) {
        other = other ?:@0;
        NSNumber *rel = nil;
        @try {
            rel = [self.decimalWrapper decimalNumberByMultiplyingBy:numberObj(other.decimalWrapper)];
            return rel.roundToPlain(scale);
        } @catch (NSException *exception) {
            return @0;
        }
    };
}

- (CaculRoundBlock)divR {
    return ^NSNumber *(NSNumber *other, NSInteger scale) {
        NSNumber *rel = nil;
        other = other ?:@1;
        @try {
            rel = [self.decimalWrapper decimalNumberByDividingBy:numberObj(other.decimalWrapper)];
            return rel.roundToPlain(scale);
        } @catch (NSException *exception) {
            return @0;
        }
    };
}

- (CaculBlock)addExc {
    return ^NSNumber *(NSNumber *other) {
        other = other ?:@0;
        NSNumber *rel = nil;
        @try {
            rel = [self.decimalWrapper decimalNumberByAdding:numberObj(other.decimalWrapper)];
            return rel;
        } @catch (NSException *exception) {
            @throw exception;
        }
    };
}

- (CaculBlock)subExc {
    return ^NSNumber *(NSNumber *other) {
        NSNumber *rel = nil;
        @try {
            rel = [self.decimalWrapper decimalNumberBySubtracting:numberObj(other.decimalWrapper)];
            return rel;
        } @catch (NSException *exception) {
            @throw exception;
        }
    };
}

- (CaculBlock)mulExc {
    return ^NSNumber *(NSNumber *other) {
        NSNumber *rel = nil;
        other = other ?:@0;
        @try {
            rel = [self.decimalWrapper decimalNumberByMultiplyingBy:numberObj(other.decimalWrapper)];
            return rel;
        } @catch (NSException *exception) {
            @throw exception;
        }
    };
}

- (CaculBlock)divExc {
    return ^NSNumber *(NSNumber *other) {
        NSNumber *rel = nil;
        other = other ?:@0;
        @try {
            rel = [self.decimalWrapper decimalNumberByDividingBy:numberObj(other.decimalWrapper)];
            return rel;
        } @catch (NSException *exception) {
            @throw exception;
        }
    };
}

- (GetRoundBlock)roundToPlain {
    return ^NSNumber *(NSInteger scale) {
        NSDecimal result;
        NSDecimal origin = self.decimalValue;
        NSDecimalRound(&result, &origin, scale, NSRoundPlain);
        return [NSDecimalNumber decimalNumberWithDecimal:result];
    };
}

- (GetRoundBlock)roundToBankers {
    return ^NSNumber *(NSInteger scale) {
        NSDecimal result;
        NSDecimal origin = self.decimalValue;
        NSDecimalRound(&result, &origin, scale, NSRoundBankers);
        return [NSDecimalNumber decimalNumberWithDecimal:result];
    };
}

- (GetRoundBlock)roundToUp {
    return ^NSNumber *(NSInteger scale) {
        NSDecimal result;
        NSDecimal origin = self.decimalValue;
        NSDecimalRound(&result, &origin, scale, NSRoundUp);
        return [NSDecimalNumber decimalNumberWithDecimal:result];
    };
}

- (GetRoundBlock)roundToDown {
    return ^NSNumber *(NSInteger scale) {
        NSDecimal result;
        NSDecimal origin = self.decimalValue;
        NSDecimalRound(&result, &origin, scale, NSRoundDown);
        return [NSDecimalNumber decimalNumberWithDecimal:result];
    };
}

@end

