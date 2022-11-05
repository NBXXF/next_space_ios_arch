//
//  NXViewController.m
//  next_space_ios_arch
//  处理基类,做框架层使用,现在很多组件hook生命周期的 冲突很多,现在得基于继承上来做
//  Created by XXF on 2022/11/3.
//

#import "NXViewController.h"
#import "UIViewController+PopDissmiss.h"
#import <Masonry/Masonry.h>
@interface NXViewController()
@property (nonatomic, strong) UIView *contentView;
//默认NO 等同于普通ViewController
@property(nonatomic,assign) BOOL isCanceledOnTouchOutside;
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
    [self setBackgroundView:[UIView new]];
    
    
    //初始化contentView
    [self.view addSubview:self.contentView];
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
        [_backgroundView whenTapped:^{
            if(self->_isCanceledOnTouchOutside){
                [self popOrDismissViewControllerAnimated:YES completion:nil];
            }
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


- (void)setCanceledOnTouchOutside:(BOOL)cancel {
    _isCanceledOnTouchOutside=cancel;
}


- (void)setComponentAlpha:(CGFloat)alpha{
    self.backgroundView.backgroundColor=[UIColor colorWithWhite:0 alpha:alpha];
}



- (void)setComponentBackgroundColor:(UIColor *)color{
    self.backgroundView.backgroundColor = color;
}



- (void)setComponentCornerRadius:(CGFloat)radius{
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = 8;
}


-(void)setComponentShadowOpacity:(CGFloat)opacity{
    self.contentView.layer.shadowColor = UIColor.blackColor.CGColor;
    self.contentView.layer.shadowOffset = CGSizeMake(0, 4);
    self.contentView.layer.shadowOpacity =opacity;
    self.contentView.layer.shadowRadius = 20;
}



- (void)setComponentSize:(CGSize)size gravity:(NXComponentGravity)gravity{
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(size.width);
        make.height.mas_equalTo(size.height);
        switch (gravity) {
            case NXComponentGravityTop:{
                make.top.equalTo(self.contentView.superview);
                make.centerX.equalTo(self.contentView.superview);
            }
                break;
            case NXComponentGravityBottom:{
                make.bottom.equalTo(self.contentView.superview);
                make.centerX.equalTo(self.contentView.superview);
            }
                break;
            case NXComponentGravityCenter:{
                make.centerX.centerY.equalTo(self.contentView.superview);
            }
                break;
            default:{
                make.centerX.centerY.equalTo(self.contentView.superview);
            }
                break;
        }
    }];
}

@end
