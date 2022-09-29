//
//  NXRouterKeys.swift
//  AppArch
//   路由公共参数key定义
//  Created by XXF on 2022/9/29.
//

import Foundation
@objc public class NXRouterKeys:NSObject{
    ///区分弹出方式 类型参考枚举NXRouterOpenType.h
    @objc public static let NXRouterOpenTypeKey = "kRouterOpenType";
    
    ///是否执行动画  类型是:BOOL
    @objc public static let NXRouterAnimatedKey = "kRouterAnimated";
    
    ///处理同级导航栏返回层级 Index  类型是:int
    @objc public static let NXRouterBackIndexKey = "kRouterBackIndex";
    
    ///指定返回到的页面并进行偏移 类型是:int
    @objc public static let NXRouterBackPageOffsetKey = "kRouterBackPageOffset";
    
    ///限制页面是否需要登录后才能访问 类型是:BOOL
    @objc public static let NXRouterNeedLoginKey = "kRouterNeedLogin";
    
    ///是否需要导航控制器; 类型是:BOOL
    @objc public static let NXRouterNeedNavigationKey = "kRouterNeedNavigation";
    
    ///限制窗体内容大小  类型是:NXPresentStyle
    @objc public static let NXRouterContentStyleKey = "kRouterContentStyle";
    
    ///业务自定义的标记 类型是:int
    @objc public static let NXRouterFlagsKey = "kRouterFlags";
    
}
