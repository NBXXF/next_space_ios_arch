//
//  NSString+NXTools.h
//  next_space_ios_arch
//
//  Created by XXF on 2023/2/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString(NXTools)

/**
 优化这种写法
 [key componentsSeparatedByString:@","].firstObject.trim; 写法优化
 */
-(NSString *__nullable)firstComponentSeparatedByString:(NSString *)separator;

/**
 优化这种写法
 [key componentsSeparatedByString:@","].lastObject.trim; 写法优化
 */
-(NSString *__nullable)lastComponentSeparatedByString:(NSString *)separator;

/**
 路径
 "/xx/x/a.txt"-> "/xx/x/"
 "/xx/x/"-> "/xx/x/"
 */
@property(nonatomic,copy,readonly)NSString *pathDirectory;

@end

NS_ASSUME_NONNULL_END
