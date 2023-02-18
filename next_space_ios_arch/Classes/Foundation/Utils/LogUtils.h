//
//  LogUtils.h
//  Pods
//
//  Created by XXF on 2022/8/24.
//


//解决其他引用这个库的devpod 组件库能控制日志,否则每个组件库需要 自定义pch文件
#ifdef DEBUG
#define NSLog(s, ... ) NSLog( @"<%@:(%d)> %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define NSLog(...)
#endif
