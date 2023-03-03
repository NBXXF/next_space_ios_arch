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

- (id)copyTo:(Class)toClass{
    return [self yy_copyTo:toClass];
}

- (id)yy_copyTo:(Class)toClass{
    return [toClass yy_modelCopyFrom:self];
}

+ (instancetype)nx_fromJSON:(id)json{
    if([self isEqual:NSNumber.class]){
        if([json isKindOfClass:NSNumber.class]){
            return json;
        }
        if([json isKindOfClass:NSString.class]){
            NSString *value=(NSString *)json;
            if([value.lowercaseString isEqual:@"true"]||[value.lowercaseString isEqual:@"yes"]){
                return [NSNumber numberWithInt:1];
            }
            if([value.lowercaseString isEqual:@"false"]||[value.lowercaseString isEqual:@"no"]){
                return [NSNumber numberWithInt:0];
            }
            return [NSNumber numberWithInteger:value.integerValue];
        }
        //暂时不支持其他类型
        return nil;
    }else if([self isEqual:NSString.class]){
        if([json isKindOfClass:NSString.class]){
            return json;
        }
        return nil;
    }else{
        return [self yy_modelWithJSON:json];
    }
}
@end
