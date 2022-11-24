//
//  XXF.m
//  AFNetworking
//
//  Created by XXF on 2022/8/24.
//

#import "XXF.h"
static NXPTConvertBlock ptConvertBlock;

@implementation XXF

+ (void)setPTWithBlock:(NXPTConvertBlock)block{
    ptConvertBlock=block;
}

+ (CGFloat)convertPTFromPX:(CGFloat)value{
    if(ptConvertBlock){
        return ptConvertBlock(value);
    }else{
        return value;
    }
}
@end
