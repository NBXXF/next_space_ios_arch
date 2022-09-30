//
//  NXInitializer.h
//  Pods
//  常用去启动初始化,多模块初始化,分离业务场景
//  Created by XXF on 2022/9/30.
//

@protocol NXInitializer<NSObject>

/**
 优先级 从大到小
 */
-(NSNumber *)priority;
/**
 app启动时执行
 */
-(void)application:(UIApplication *)application;


@end
