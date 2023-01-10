//
//  MASConstraint+NXPT.m
//  next_space_ios_arch
//  采用相对单位,屏幕适配
//  Created by XXF on 2022/11/24.
//

#import "MASConstraint+NXPT.h"
#import <Masonry/MASConstraint+Private.h>
#import "UIScreen+NXTools.h"

@implementation MASConstraint(NXPT)

- (CGFloat)convertPTFromPX:(CGFloat)value{
    return [UIScreen.mainScreen getDensityValue:value];
}

- (CGSize)convertPTSizeFromPX:(CGSize)value{
    return CGSizeMake([self convertPTFromPX:value.width],
                      [self convertPTFromPX:value.height]);
}

- (CGPoint)convertPTPointFromPX:(CGPoint)value{
    return CGPointMake([self convertPTFromPX:value.x],
                       [self convertPTFromPX:value.y]);
}

- (UIEdgeInsets)convertPTEdgeInsetsFromPX:(UIEdgeInsets)value{
    return UIEdgeInsetsMake([self convertPTFromPX:value.top],
                            [self convertPTFromPX:value.left],
                            [self convertPTFromPX:value.bottom],
                            [self convertPTFromPX:value.right]);
}

- (MASConstraint * (^)(MASEdgeInsets insets))insetsPT{
    return ^id(MASEdgeInsets insets){
        self.insets = [self convertPTEdgeInsetsFromPX:insets];
        return self;
    };
}


- (MASConstraint * (^)(CGFloat inset))insetPT{
    return ^id(CGFloat inset){
//        return self.inset(inset);
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

- (MASConstraint * (^)(CGFloat value))mas_equalToPT {
    return ^id(CGFloat value) {
        CGFloat newValue=[self convertPTFromPX:value];
        return self.equalToWithRelation(@(newValue), NSLayoutRelationEqual);
    };
}

- (MASConstraint * (^)(CGFloat value))mas_greaterThanOrEqualToPT {
    return ^id(CGFloat value) {
        CGFloat newValue=[self convertPTFromPX:value];
        return self.equalToWithRelation(@(newValue), NSLayoutRelationGreaterThanOrEqual);
    };
}

- (MASConstraint * (^)(CGFloat value))mas_lessThanOrEqualToPT {
    return ^id(CGFloat value) {
        CGFloat newValue=[self convertPTFromPX:value];
        return self.equalToWithRelation(@(newValue), NSLayoutRelationLessThanOrEqual);
    };
}
@end
