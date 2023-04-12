//
//  NXRouterKeys.swift
//  AppArch
//   路由公共参数key定义
//  Created by XXF on 2022/9/29.
//

import Foundation
@objcMembers open class NXRouterKeys:NSObject{
    ///区分弹出方式 类型参考枚举NXRouterOpenType.h
    public static let NXRouterOpenTypeKey = "kRouterOpenType";
    
    //仅仅打开方式为modal的时候有效 注意 "modalPresentationConfig" 不能变,和分类的字段名字保持的一致
    public static let NXRouterModalPresentationConfigKey="modalPresentationConfig";
    
    ///是否执行动画  类型是:BOOL
    public static let NXRouterAnimatedKey = "kRouterAnimated";
    
    ///限制页面是否需要登录后才能访问 类型是:BOOL
    public static let NXRouterNeedLoginKey = "kRouterNeedLogin";
    
    ///是否需要导航控制器; 类型是:BOOL
    public static let NXRouterNeedNavigationKey = "kRouterNeedNavigation";
    
    ///限制窗体内容大小  类型是:NXPresentStyle
    public static let NXRouterContentStyleKey = "kRouterContentStyle";
    
    ///业务自定义的标记 类型是:NXRouterFlags  可以多位进行或 ,必须是按二进制移位
    public static let NXRouterFlagsKey = "kRouterFlags";
    
}
