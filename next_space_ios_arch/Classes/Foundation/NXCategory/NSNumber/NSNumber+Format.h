//
//  NSNumber+Format.h
//  ETicket
//
//  Created by Apple on 2018/3/8.
//  Copyright © 2018年 TCT Technology Co.Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (format2TN)

//NSNumber * number = @(98764.12345);
//NSNumberFormatterNoStyle = 98764
//NSNumberFormatterCurrencyStyle = US$98,764.12
//NSNumberFormatterDecimalStyle = 98,764.123
//NSNumberFormatterPercentStyle = 9,876,412%
//NSNumberFormatterScientificStyle = 9.876412345E4
//NSNumberFormatterSpellOutStyle = 九万八千七百六十四点一二三四五
//NSNumberFormatterOrdinalStyle = 第9,8764
//NSNumberFormatterCurrencyISOCodeStyle = USD98,764.12end
//NSNumberFormatterCurrencyPluralStyle = 98,764.12美元
//NSNumberFormatterCurrencyAccountingStyle = US$98,764.12

/*
 * 保留2-4位小数，> 1000 单位 K , >1000000 单位M
 */
///保留2-4位小数，> 1000 单位 K , >1000000 单位M
- (NSString *)formatKM2T4;

/*
 * 2位小数，> 1000 单位 K , >1000000 单位M
 */
///2位小数，> 1000 单位 K , >1000000 单位M
- (NSString *)formatKM2T2;

/*
 * 2-4位小数
 */
///2-4位小数
 - (NSString *)format2T4;

/*
 * 2位小数
 * eg:
 * 0 => 0.00, 1.2=>1.20,1.342=>1.34
 */
///2位小数
- (NSString *)format2T2;

/*
 * 5位小数
 * eg:
 * 0 => 0.00000,1.2=>1.20000,1.342=>1.34200
 */
///5位小数
- (NSString *)format5T5;

/*
 * 2-digits位小数
 */
///2-digits位小数
- (NSString *)format2TN:(NSInteger)digits;
///N位小数
- (NSString *)formatNTN:(NSInteger)digits;
/// 移除千分位小数
- (NSString *)formatNTN:(NSInteger)digits removePerMillSymbol:(BOOL)remove;
- (NSString *)formatNTN:(NSInteger)digits removePerMillSymbol:(BOOL)remove style:(NSNumberFormatterStyle)style;

///N位小数  舍入方式
- (NSString *)formatNTN:(NSInteger)digits FormatterRoundingMode:(NSNumberFormatterRoundingMode)model;
///小数位最小位 到最大位  千分号去掉
- (NSString *)formatMin:(NSInteger)Min TMax:(NSInteger)Max;
/*
 * 0-digits位小数
 */
///0-N digits位小数
- (NSString *)format0TN:(NSInteger)digits;

@end
