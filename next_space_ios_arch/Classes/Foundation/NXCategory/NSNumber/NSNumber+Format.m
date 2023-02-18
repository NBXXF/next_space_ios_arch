//
//  NSNumber+format2TN.m
//  ETicket
//
//  Created by Apple on 2018/3/8.
//  Copyright © 2018年 TCT Technology Co.Ltd. All rights reserved.
//

#import "NSNumber+Format.h"
#import "NSNumber+Decimal.h"

@implementation NSNumber (format2TN)

- (NSString *)formatKM2T4 {
    if (self.ge(@(1000000))) {
        return [NSString stringWithFormat:@"%@M",[@(self.doubleValue / 1000000) format2T2]];
    }
    
    if (self.g(@1000)) {
        return [NSString stringWithFormat:@"%@K",[@(self.doubleValue / 1000) format2T2]];
    }
    
    return [self format2TN:4];
}

- (NSString *)formatKM2T2 {
    if (self.ge(@(1000000))) {
        return [NSString stringWithFormat:@"%@M",[@(self.doubleValue / 1000000) format2T2]];
    }
    
    if (self.g(@1000)) {
        return [NSString stringWithFormat:@"%@K",[@(self.doubleValue / 1000) format2T2]];
    }
    
    return [self format2T2];
}

- (NSString *)format2T4 {
    return [self format2TN:4];
}

- (NSString *)format2T2 {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setPositiveFormat:@"###,##0.00;"];
    NSString *formatted = [formatter stringFromNumber:self.roundToDown(2)];
    return [self onlyRemoveSymbol:[NSString stringWithFormat:@"%@", formatted]];
}

- (NSString *)format5T5 {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setPositiveFormat:@"###,##0.00000;"];
    NSString *formatted = [formatter stringFromNumber:self.roundToDown(5)];
    return [self onlyRemoveSymbol:[NSString stringWithFormat:@"%@", formatted]];
}

- (NSString *)formatNTN:(NSInteger)digits {
    return [self formatNTN:digits removePerMillSymbol:YES];
}

- (NSString *)formatNTN:(NSInteger)digits removePerMillSymbol:(BOOL)remove{
    return [self formatNTN:digits removePerMillSymbol:remove style:NSNumberFormatterDecimalStyle];
}

- (NSString *)formatNTN:(NSInteger)digits removePerMillSymbol:(BOOL)remove style:(NSNumberFormatterStyle)style {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:style];
    numberFormatter.minimumFractionDigits = digits;
    numberFormatter.maximumFractionDigits = digits;
    numberFormatter.roundingMode = NSNumberFormatterRoundFloor;//不四舍五入
    numberFormatter.perMillSymbol = @","; //千分号符号
    if (remove) {
        return [self onlyRemoveSymbol:[numberFormatter stringFromNumber:self]];
    }
    return [numberFormatter stringFromNumber:self];
}


- (NSString *)formatNTN:(NSInteger)digits FormatterRoundingMode:(NSNumberFormatterRoundingMode)model{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    numberFormatter.minimumFractionDigits = digits;
    numberFormatter.maximumFractionDigits = digits;
    numberFormatter.roundingMode = model;//不四舍五入
    numberFormatter.perMillSymbol = @","; //千分号符号
    return [self onlyRemoveSymbol:[numberFormatter stringFromNumber:self]];
}



- (NSString *)formatMin:(NSInteger)Min TMax:(NSInteger)Max{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    numberFormatter.minimumFractionDigits = Min;
    numberFormatter.maximumFractionDigits = Max;
    numberFormatter.roundingMode = NSNumberFormatterRoundFloor;//不四舍五入
    numberFormatter.perMillSymbol = @","; //千分号符号
    return [self onlyRemoveSymbol:[numberFormatter stringFromNumber:self]];
}

- (NSString *)format2TN:(NSInteger)digits {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    //小数形式
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    // 小数位最少位数
    numberFormatter.minimumFractionDigits = 2;
    // 小数位最多位数
    numberFormatter.maximumFractionDigits = digits;
    // 舍入方式
    numberFormatter.roundingMode = NSNumberFormatterRoundFloor;
    //千分号符号
    numberFormatter.perMillSymbol = @",";
    return [self onlyRemoveSymbol:[numberFormatter stringFromNumber:self]];
}

- (NSString *)format0TN:(NSInteger)digits {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    numberFormatter.minimumFractionDigits = 0;
    numberFormatter.maximumFractionDigits = digits;
    numberFormatter.roundingMode = NSNumberFormatterRoundFloor;
    numberFormatter.perMillSymbol = @",";
    return [self onlyRemoveSymbol:[numberFormatter stringFromNumber:self]];
}

- (NSString *)onlyRemoveSymbol:(NSString *)string {
    return [string stringByReplacingOccurrencesOfString:@"," withString:@""];
}

- (NSString *)removeSymbol:(NSString *)string {
    NSInteger bit = self.doubleValue < 0 ? 11 : 10;
    string = [string stringByReplacingOccurrencesOfString:@"," withString:@""];
    if (string.length <= bit) {
        return string;
    }
    NSString *result = [string substringToIndex:bit];
    return [result rangeOfString:@"."].location == (result.length - 1) ? [result substringToIndex:result.length - 1] : result;
}

@end
