//
//  NSDictionary+log.m
//  kekebaobei
//
//  Created by jsonLee on 2017/2/21.
//  Copyright © 2017年 kekenet. All rights reserved.
//

#import "NSDictionary+log.h"

@implementation NSDictionary (log)
- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
    NSMutableString *mStr = [NSMutableString string];
    NSMutableString *tab = [NSMutableString stringWithString:@""];
    for (int i = 0; i < level; i++) {
        [tab appendString:@"\t"];
    }
    [mStr appendString:@"{\n"];
    NSArray *allKey = self.allKeys;
    for (int i = 0; i < allKey.count; i++) {
        id value = self[allKey[i]];
        NSString *lastSymbol = (allKey.count == i + 1) ? @"":@";";
        if ([value respondsToSelector:@selector(descriptionWithLocale:indent:)]) {
            [mStr appendFormat:@"\t%@%@ = %@%@\n",tab,allKey[i],[value descriptionWithLocale:locale indent:level + 1],lastSymbol];
            
            //  [mStr appendFormat:@"\t%@%@ = %@%@",tab,allKey[i],[value descriptionWithLocale:locale indent:level + 1],lastSymbol];
            //去掉很多空格
            //[mStr appendFormat:@"\t%@ = %@%@",allKey[i],[value descriptionWithLocale:locale indent:level + 1],lastSymbol];
            
        } else {
            [mStr appendFormat:@"\t%@%@ = %@%@\n",tab,allKey[i],value,lastSymbol];
            
            // [mStr appendFormat:@"\t%@%@ = %@%@",tab,allKey[i],value,lastSymbol];
            //去掉很多空格
            // [mStr appendFormat:@"\t%@ = %@%@",allKey[i],value,lastSymbol];
            
        }
    }
    [mStr appendFormat:@"%@}",tab];
    return mStr;
}
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        return nil;
    }
    return dic;
}

@end
