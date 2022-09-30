//
//  NXInitializer.h
//  Pods
//
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
