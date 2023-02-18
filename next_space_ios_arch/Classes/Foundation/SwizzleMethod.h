//
//  SwizzleMethod.h
//  ETicket
//
//  Created by chunjian wang on 2017/12/12.
//  Copyright © 2017年 chunjian wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SwizzleMethod : NSObject

+ (void)swizzleMethod:(Class)cls originalSelector:(SEL)originalSel swizzledSelector:(SEL)swizzledSel;


@end
