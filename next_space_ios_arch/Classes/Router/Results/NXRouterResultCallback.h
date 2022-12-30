//
//  NXRouterResultCallback.h
//  Pods
//  路由跳转执行的返回值
//  Created by XXF on 2022/9/27.
//


/**
 @param component 组件
 @param result 业务约定的返回值
 */
typedef void(^NXRouterResultCallback)(id  __nullable component, id __nullable result);
