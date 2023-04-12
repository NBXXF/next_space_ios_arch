//
//  UIColor+Parser.h
//  AFNetworking
//
//  Created by XXF on 2022/8/17.
//

#import <Foundation/Foundation.h>
//将这个工具继承下去
#import <DynamicColor/DynamicColor-Swift.h>
#import <DynamicColor/DynamicColor-umbrella.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Parser)
- (CGFloat)red;

- (CGFloat)green;

- (CGFloat)blue;
@end

NS_ASSUME_NONNULL_END
