//
//  MASConstraint+NXPT.m
//  next_space_ios_arch
//  采用相对单位,屏幕适配
//  Created by 1234 on 2022/11/24.
//

#import "MASConstraint+NXPT.h"
#import "XXF.h"

@implementation MASConstraint(NXPT)

- (CGFloat)convertPTFromPX:(CGFloat)value{
    return [XXF convertPTFromPX:value];
}

- (CGSize)convertPTSizeFromPX:(CGSize)value{
    return CGSizeMake([XXF convertPTFromPX:value.width], [XXF convertPTFromPX:value.height]);
}

- (CGPoint)convertPTPointFromPX:(CGPoint)value{
    return CGPointMake([XXF convertPTFromPX:value.x], [XXF convertPTFromPX:value.y]);
}

- (UIEdgeInsets)convertPTEdgeInsetsFromPX:(UIEdgeInsets)value{
    return UIEdgeInsetsMake([XXF convertPTFromPX:value.top], [XXF convertPTFromPX:value.left], [XXF convertPTFromPX:value.bottom], [XXF convertPTFromPX:value.right]);
}

- (MASConstraint * (^)(MASEdgeInsets insets))insetsPT{
    return ^id(MASEdgeInsets insets){
        self.insets = [self convertPTEdgeInsetsFromPX:insets];
        return self;
    };
}


- (MASConstraint * (^)(CGFloat inset))insetPT{
    return ^id(CGFloat inset){
        self.inset = [self convertPTFromPX:inset];
        return self;
    };
}


- (MASConstraint * (^)(CGSize offset))sizeOffsetPT{
    return ^id(CGSize offset) {
        self.sizeOffset = [self convertPTSizeFromPX:offset];
        return self;
    };
}


- (MASConstraint * (^)(CGPoint offset))centerOffsetPT{
    return ^id(CGPoint offset) {
        self.centerOffset = [self convertPTPointFromPX:offset];;
        return self;
    };
}


- (MASConstraint * (^)(CGFloat offset))offsetPT{
    return ^id(CGFloat offset){
        self.offset = [self convertPTFromPX:offset];
        return self;
    };
}
@end
