//
//  NXResponseException.m
//  next_space
//
//  Created by XXF on 2021/7/5.
//

#import "NXOCError.h"

@implementation NXOCError

- (instancetype)initWithCode:(NSInteger)code andMsg:(NSString *)msg andExt:(NSDictionary *)ext{
    if(self = [super initWithDomain:@"http" code:code userInfo:ext]){
        _msg=msg;
    }
    return self;
}


+(NXOCError *)paramsError {
    NXOCError * error = [[NXOCError alloc] initWithCode:-1 andMsg:@"参数错误" andExt:@{}];
    return error;
}

+(NXOCError *)noPermissionError{
    NXOCError * error = [[NXOCError alloc] initWithCode:-1 andMsg:@"无权限操作" andExt:@{}];
    return error;
}

@end
