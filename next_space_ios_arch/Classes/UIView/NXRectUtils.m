//
//  NXCGRectUtils.m
//  next_space_ios_arch
//
//  Created by XXF on 2022/10/24.
//

#import "NXRectUtils.h"

@implementation NXRectUtils

+ (CGFloat)getCenterX:(CGRect)rect{
    return (rect.origin.x+rect.size.width/2);
}

+ (CGFloat)getCenterY:(CGRect)rect{
    return (rect.origin.y+rect.size.height/2);
}

+(CGFloat)absFloat:(CGFloat)value{
    if(value<0){
        return (-1.0)*value;
    }else{
        return value;
    }
}

/**
 是否水平方向居中
 */
+(BOOL)isHorizontalCenter:(CGRect)current target:(CGRect)target{
    return [self isHorizontalCenter:current target:target distance:1.0f];
}


+ (BOOL)isHorizontalCenter:(CGRect)current target:(CGRect)target distance:(CGFloat)distance{
    return [self absFloat:([self getCenterY:current]-[self getCenterY:target])]<=[self absFloat:distance];
}

/**
 是否垂直方向居中
 */
+(BOOL)isVerticalCenter:(CGRect)current target:(CGRect)target{
    return [self isVerticalCenter:current target:target distance:1.0f];
}


+ (BOOL)isVerticalCenter:(CGRect)current target:(CGRect)target distance:(CGFloat)distance{
    return [self absFloat:([self getCenterX:current]-[self getCenterX:target])]<=[self absFloat:distance];
}


/**
 是否是target的左边
 @param target 相对参考位置
 @param strict 是否抛弃重叠情况
 */
+(BOOL)isLeft:(CGRect)current target:(CGRect)target strict:(BOOL)strict{
    if(!strict){
        return current.origin.x<target.origin.x;
    }else{
        return (current.origin.x+current.size.width)<= target.origin.x;
    }
}


/**
 是否是target的右边
 @param target 相对参考位置
 @param strict 是否抛弃重叠情况
 */
+(BOOL)isRight:(CGRect)current target:(CGRect)target strict:(BOOL)strict{
    if(!strict){
        return current.origin.x>target.origin.x;
    }else{
        return current.origin.x>=(target.origin.x+target.size.width);
    }
}

/**
 是否是target的上边
 @param target 相对参考位置
 @param strict 是否抛弃重叠情况
 */
+(BOOL)isUp:(CGRect)current target:(CGRect)target strict:(BOOL)strict{
    if(!strict){
        return current.origin.y<target.origin.y;
    }else{
        return (current.origin.y+current.size.height)<=target.origin.y;
    }
}


/**
 是否是target的下边
 @param target 相对参考位置
 @param strict 是否抛弃重叠情况
 */
+(BOOL)isDown:(CGRect)current target:(CGRect)target strict:(BOOL)strict{
    if(!strict){
        return current.origin.y>target.origin.y;
    }else{
        return current.origin.y>=(target.origin.y+target.size.height);
    }
}

@end
