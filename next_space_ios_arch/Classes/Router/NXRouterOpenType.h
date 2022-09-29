//
//  NXRouterOpenType.h
//  Pods
//
//  Created by XXF on 2022/9/29.
//

/**
 vc弹出形式
 */
typedef NS_ENUM(NSUInteger, NXRouterOpenType) {
    ///Push
    NXRouterOpenTypeByPush=0,
    ///Modal
    NXRouterOpenTypeByModal,
    ///从rootVC 直接弹出的modal模式
    NXRouterOpenTypeByRootModal
};
