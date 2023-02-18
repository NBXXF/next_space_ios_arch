//
//  NSString+Decimal.m
//  ETicket
//
//  Created by chunjian wang on 2018/5/16.
//  Copyright © 2018年 chunjian wang. All rights reserved.
//

#import "NSString+Decimal.h"

@implementation NSString(Decimal)

- (NSDecimalNumber *)decimalWrapper {
    NSDecimalNumber *number = [NSDecimalNumber decimalNumberWithString:self];
    if ([number isEqualToNumber:@(NAN)]) {
        return [NSDecimalNumber decimalNumberWithString:@"0"];
    }
    return number;
}

- (NSDecimal)decimalStruct {
    return self.decimalWrapper.decimalValue;
}

- (NSNumber *)toNumber {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    numberFormatter.maximumFractionDigits = 8;
    numberFormatter.minimumFractionDigits = 0;
    numberFormatter.roundingMode = NSNumberFormatterRoundFloor;
    numberFormatter.perMillSymbol = @",";
    return [numberFormatter numberFromString:self].formatDecimalWrapper;
}

- (CompareBlock)g {
    return ^BOOL (NSString *other) {
        return [self.decimalWrapper compare:numberObj(other.decimalWrapper)] == NSOrderedDescending;
    };
}

- (CompareBlock)ge {
    return ^BOOL (NSString *other) {
        NSComparisonResult rel = [self.decimalWrapper compare:numberObj(other.decimalWrapper)];
        return rel == NSOrderedDescending || rel == NSOrderedSame;
    };
}

- (CompareBlock)l {
    return ^BOOL (NSString *other) {
        return [self.decimalWrapper compare:numberObj(other.decimalWrapper)] == NSOrderedAscending;
    };
}

- (CompareBlock)le {
    return ^BOOL (NSString *other) {
        NSComparisonResult rel = [self.decimalWrapper compare:numberObj(other.decimalWrapper)];
        return rel == NSOrderedAscending || rel == NSOrderedSame;
    };
}

- (CompareBlock)e {
    return ^BOOL (NSString *other) {
        return [self.decimalWrapper compare:numberObj(other.decimalWrapper)] == NSOrderedSame;
    };
}

- (CompareBlock)ne {
    return ^BOOL (NSString *other) {
        return [self.decimalWrapper compare:numberObj(other.decimalWrapper)] != NSOrderedSame;
    };
}

- (CalBlock)add {
    return ^NSString *(NSString *other) {
        NSString *rel = nil;
        @try {
            rel = [self.decimalWrapper decimalNumberByAdding:numberObj(other.decimalWrapper)].stringValue;
            return rel;
        } @catch (NSException *exception) {
            return @"0";
        }
    };
}

- (CalBlock)sub {
    return ^NSString *(NSString *other) {
        NSString *rel = nil;
        @try {
            rel = [self.decimalWrapper decimalNumberBySubtracting:numberObj(other.decimalWrapper)].stringValue;
            return rel;
        } @catch (NSException *exception) {
            return @"0";
        }
    };
}

- (CalBlock)mul {
    return ^NSString *(NSString *other) {
        NSString *rel = nil;
        @try {
            rel = [self.decimalWrapper decimalNumberByMultiplyingBy:numberObj(other.decimalWrapper)].stringValue;
            return rel;
        } @catch (NSException *exception) {
            return @"0";
        }
    };
}

- (CalBlock)div {
    return ^NSString *(NSString *other) {
        NSString *rel = nil;
        @try {
            rel = [self.decimalWrapper decimalNumberByDividingBy:numberObj(other.decimalWrapper)].stringValue;
            return rel;
        } @catch (NSException *exception) {
            return @"0";
        }
    };
}

- (CalRoundBlock)addR {
    return ^NSString *(NSString *other, NSInteger scale) {
        NSString *rel = nil;
        @try {
            rel = [self.decimalWrapper decimalNumberByAdding:numberObj(other.decimalWrapper)].stringValue;
            return rel.roundToPlain(scale);
        } @catch (NSException *exception) {
            return @"0";
        }
    };
}

- (CalRoundBlock)subR {
    return ^NSString *(NSString *other, NSInteger scale) {
        NSString *rel = nil;
        @try {
            rel = [self.decimalWrapper decimalNumberBySubtracting:numberObj(other.decimalWrapper)].stringValue;
            return rel.roundToPlain(scale);
        } @catch (NSException *exception) {
            return @"0";
        }
    };
}

- (CalRoundBlock)mulR {
    return ^NSString *(NSString *other, NSInteger scale) {
        NSString *rel = nil;
        @try {
            rel = [self.decimalWrapper decimalNumberByMultiplyingBy:numberObj(other.decimalWrapper)].stringValue;
            return rel.roundToPlain(scale);
        } @catch (NSException *exception) {
            return @"0";
        }
    };
}

- (CalRoundBlock)divR {
    return ^NSString *(NSString *other, NSInteger scale) {
        NSString *rel = nil;
        @try {
            rel = [self.decimalWrapper decimalNumberByDividingBy:numberObj(other.decimalWrapper)].stringValue;
            return rel.roundToPlain(scale);
        } @catch (NSException *exception) {
            return @"0";
        }
    };
}

- (CalBlock)addExc {
    return ^NSString *(NSString *other) {
        NSString *rel = nil;
        @try {
            rel = [self.decimalWrapper decimalNumberByAdding:numberObj(other.decimalWrapper)].stringValue;
            return rel;
        } @catch (NSException *exception) {
            @throw exception;
        }
    };
}

- (CalBlock)subExc {
    return ^NSString *(NSString *other) {
        NSString *rel = nil;
        @try {
            rel = [self.decimalWrapper decimalNumberBySubtracting:numberObj(other.decimalWrapper)].stringValue;
            return rel;
        } @catch (NSException *exception) {
            @throw exception;
        }
    };
}

- (CalBlock)mulExc {
    return ^NSString *(NSString *other) {
        NSString *rel = nil;
        @try {
            rel = [self.decimalWrapper decimalNumberByMultiplyingBy:numberObj(other.decimalWrapper)].stringValue;
            return rel;
        } @catch (NSException *exception) {
            @throw exception;
        }
    };
}

- (CalBlock)divExc {
    return ^NSString *(NSString *other) {
        NSString *rel = nil;
        @try {
            rel = [self.decimalWrapper decimalNumberByDividingBy:numberObj(other.decimalWrapper)].stringValue;
            return rel;
        } @catch (NSException *exception) {
            @throw exception;
        }
    };
}

- (RoundBlock)roundToPlain {
    return ^NSString *(NSInteger scale) {
        NSDecimal result;
        NSDecimal origin = self.decimalStruct;
        NSDecimalRound(&result, &origin, scale, NSRoundPlain);
        return [NSDecimalNumber decimalNumberWithDecimal:result].stringValue;
    };
}

- (RoundBlock)roundToBankers {
    return ^NSString *(NSInteger scale) {
        NSDecimal result;
        NSDecimal origin = self.decimalStruct;
        NSDecimalRound(&result, &origin, scale, NSRoundBankers);
        return [NSDecimalNumber decimalNumberWithDecimal:result].stringValue;
    };
}

- (RoundBlock)roundToUp {
    return ^NSString *(NSInteger scale) {
        NSDecimal result;
        NSDecimal origin = self.decimalStruct;
        NSDecimalRound(&result, &origin, scale, NSRoundUp);
        return [NSDecimalNumber decimalNumberWithDecimal:result].stringValue;
    };
}

- (RoundBlock)roundToDown {
    return ^NSString *(NSInteger scale) {
        NSDecimal result;
        NSDecimal origin = self.decimalStruct;
        NSDecimalRound(&result, &origin, scale, NSRoundDown);
        return [NSDecimalNumber decimalNumberWithDecimal:result].stringValue;
    };
}

-(NSString *)removeLastZeroes {
    const char *floatChars = [self UTF8String];
    NSUInteger length = [self length];
    NSUInteger zeroLength = 0;
    NSInteger i = length-1;
    for(; i>=0; i--) {
        if(floatChars[i] == '0'/*0x30*/) {
            zeroLength++;
        } else {
            if(floatChars[i] == '.')
                i--;
            break;
        }
    }
    NSString *returnString;
    if(i == -1) {
        returnString = @"0";
    } else {
        returnString = [self substringToIndex:i+1];
    }
    return returnString;
}

- (NSInteger)digits {
    NSArray<NSString *> * array = [self componentsSeparatedByString:@"."];
    if (array.count == 2) {
        return array.lastObject.length ?: 0;
    }
    return 0;
}

- (NSInteger)formulaDigits {
    NSArray<NSString *> * array = [self componentsSeparatedByString:@"."];
    if (array.count == 2) {
        if(array.lastObject.length > 12){
            return 12;
        }else{
            return array.lastObject.length;
        }
    }
    return 0;
}


@end

