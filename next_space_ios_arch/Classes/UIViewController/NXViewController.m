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
@property(nonatomic,strong) UITapGestureRecognizer *__touchOutsideTapGestureRecognizer;
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
    [self.view addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.contentView.superview);
        make.height.equalTo(self.contentView.superview);
        make.centerX.centerY.equalTo(self.contentView.superview);
    }];
    [self setCanceledOnTouchOutside:YES];
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
        _contentView.backgroundColor=UIColor.whiteColor;
        _contentView.userInteractionEnabled=YES;
    }
    return _contentView;
}

-(void)__canceledOnTouchOutside:(UITapGestureRecognizer *)gest{
    [self backViewControllerAnimated:YES completion:nil];
}
- (void)setCanceledOnTouchOutside:(BOOL)cancel {
    if(!___touchOutsideTapGestureRecognizer){
        ___touchOutsideTapGestureRecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__canceledOnTouchOutside:)];
    }
    [self.view removeGestureRecognizer:___touchOutsideTapGestureRecognizer];
    if(cancel){
        [self.view addGestureRecognizer:___touchOutsideTapGestureRecognizer];
    }
}

- (void)setComponentAlpha:(CGFloat)alpha{
    self.view.backgroundColor=[UIColor colorWithWhite:0 alpha:alpha];
}

- (void)setComponentCornerRadius:(CGFloat)radius{
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = 8;
}

- (void)setComponentBackgroundColor:(UIColor *)color{
    self.view.backgroundColor = color;
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
