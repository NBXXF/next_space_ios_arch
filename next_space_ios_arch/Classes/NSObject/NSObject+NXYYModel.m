//
//  NSObject+NXYYModel.m
//  next_space_ios_arch
// 提供以json 形式的copy
//  Created by XXF on 2022/10/27.
//

#import "NSObject+NXYYModel.h"

@implementation NSObject(NXYYModel)

+ (instancetype)copyFrom:(id)fromObject{
    return [self yy_modelCopyFrom:fromObject];
}

+ (instancetype)yy_modelCopyFrom:(id)fromObject{
    id json = [fromObject yy_modelToJSONObject];
    id copyModel= [self yy_modelWithJSON:json];
    return copyModel;
}
@end
