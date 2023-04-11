//
//  NXViewController.m
//  next_space_ios_arch
//  处理基类,做框架层使用,现在很多组件hook生命周期的 冲突很多,现在得基于继承上来做
//  Created by XXF on 2022/11/3.
//

#import "NXViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "UIViewController+PopDissmiss.h"
#import <Masonry/Masonry.h>
#import "UIApplication+NXTools.h"
#import <next_space_ios_arch/UIView+Feedback.h>
#import <next_space_ios_arch/NSObject+NXTools.h>

@interface NXViewController()
@property (nonatomic, strong) UIView *contentView;
@end
@implementation NXViewController
/**
 特殊标记系统方法废弃
 */
- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion DEPRECATED_MSG_ATTRIBUTE("为了组件复用,请直接使用分类拓展popOrDismissViewControllerAnimated或者finishNavigationControllerAnimated方法"){
    [super dismissViewControllerAnimated: flag completion:completion] ;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    //初始化backgroundView
    UIView *bgView=[UIView new];
    bgView.backgroundColor=UIColor.clearColor;
    [self setBackgroundView:bgView];
    
    
    //初始化contentView
    [self.view addSubview:self.contentView];
    //兼容以前的业务
    self.contentView.frame=self.view.bounds;
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.contentView.superview);
        make.height.equalTo(self.contentView.superview);
        make.centerX.centerY.equalTo(self.contentView.superview);
    }];
}


- (void)setBackgroundView:(UIView *)backgroundView {
    if(_backgroundView==backgroundView){
        return;
    }
    [_backgroundView removeFromSuperview];
    _backgroundView = backgroundView;
    if(_backgroundView){
        //这一句很重要 设计必须是第0个元素
        [self.view insertSubview:_backgroundView atIndex:0];
        [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(_backgroundView.superview);
            make.height.equalTo(_backgroundView.superview);
            make.centerX.centerY.equalTo(_backgroundView.superview);
        }];
    }
}



- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
        _contentView.backgroundColor=UIColor.whiteColor;
    }
    return _contentView;
}



- (void)enableSafeAreaBottomInsets{
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.contentView.superview);
        make.top.equalTo(self.contentView.superview);
        make.bottom.equalTo(self.contentView.superview).offset(-fabs(UIApplication.sharedApplication.bottomLayoutOffset));
        make.centerX.centerY.equalTo(self.contentView.superview);
    }];
}

- (void)disableSafeAreaBottomInsets{
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.contentView.superview);
        make.top.equalTo(self.contentView.superview);
        make.bottom.equalTo(self.contentView.superview);
        make.centerX.centerY.equalTo(self.contentView.superview);
    }];
}


- (void)setBaseResult:(id)result{
    if(self.kRouterResultCallback){
        //触觉震动反馈
        [FeedbackGenerator.shared performDefaultFeedback];
        self.kRouterResultCallback(self,result);
    }
}
@end
