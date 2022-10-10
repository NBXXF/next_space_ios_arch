//
//  NXRouterFlags.h
//  Pods
//
//  Created by XXF on 2022/9/30.
//

typedef NS_ENUM(NSUInteger, NXRouterFlags) {
    ///清理栈顶
    NXRouterFlagsClearClearTop=1<<0,
    
    
    ///清空栈 如果目标vc 不是UINavigationController 默认会包装一个
    NXRouterFlagsClearTask=1<<1,
};
