//
//  NXSessionDataTask.m
//  next_space_ios_arch
//
//  Created by XXF on 2023/2/23.
//

#import "NXSessionDataTaskResult.h"

@implementation NXSessionDataTaskResult

- (NSDictionary *)userInfo{
    if(!_userInfo){
        return [NSMutableDictionary dictionary];
    }
    return _userInfo;
}
@end
