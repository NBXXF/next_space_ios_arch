//
//  NXHTTPSessionManager.m
//  NXHTTP
//  解决AFN下载bug 并进行拓展
//  Created by XXF on 2022/11/9.
//

#import "NXHTTPSessionManager.h"
#import "NXURLSession.h"
@interface NXHTTPSessionManager()
@property (readwrite, nonatomic, strong) NSURLSession *mySession;
@property (readwrite, nonatomic, strong) NSURLSessionConfiguration *mySessionConfiguration;
@end
@implementation NXHTTPSessionManager

- (instancetype)initWithBaseURL:(NSURL *)url sessionConfiguration:(NSURLSessionConfiguration *)configuration{
    _mySessionConfiguration=configuration;
    return [super initWithBaseURL:url sessionConfiguration:configuration];
}


- (instancetype)initWithSessionConfiguration:(NSURLSessionConfiguration *)configuration{
    _mySessionConfiguration=configuration;
    return [super initWithSessionConfiguration:configuration];
}
- (NSURLSession *)session{
    @synchronized (self) {
        if (!_mySession) {
            //这里用NXURLSession 进行拦截
            _mySession = [NXURLSession sessionWithConfiguration:self.mySessionConfiguration delegate:self delegateQueue:self.operationQueue];
        }
    }
    return _mySession;
}


- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
    //默认非200 下载框架也是执行下载的,这里解决这个问题
    if([downloadTask.response isKindOfClass:NSHTTPURLResponse.class]){
        NSHTTPURLResponse *urlResponse=(NSHTTPURLResponse *)downloadTask.response;
        NSInteger code=urlResponse.statusCode;
        if(code!=200){
            [[NSNotificationCenter defaultCenter] postNotificationName:AFURLSessionDownloadTaskDidFailToMoveFileNotification object:downloadTask userInfo: @{
                NSLocalizedDescriptionKey:@"下载失败",
                NSLocalizedFailureReasonErrorKey:[NSString stringWithFormat:@"code:%ld %@",(long)code,urlResponse.description],
                NSLocalizedRecoverySuggestionErrorKey:@"意见：请联系接口定义人"
                }];
            return;
        }
    }
    //再执行父类方法
    [super URLSession:session downloadTask:downloadTask didFinishDownloadingToURL:location];
}
@end
