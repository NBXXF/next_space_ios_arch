//
//  UIView+NXStatus.m
//  next_space_ios_arch
//
//  Created by 1234 on 2022/11/17.
//

#import "UIView+NXStatus.h"

@implementation UIView(NXStatus)

- (BOOL)disable{
    if([self isKindOfClass:UIControl.class]){
        UIControl *control=(UIControl *)self;
        return !control.enabled;
    }
    return !self.userInteractionEnabled;
}

- (void)setDisable:(BOOL)disable{
    if([self isKindOfClass:UIControl.class]){
        UIControl *control=(UIControl *)self;
        control.enabled=!disable;
    }else{
        self.userInteractionEnabled=!disable;
    }
    if(disable){
        self.alpha=0.3f;
    }else{
        self.alpha=1.0f;
    }
}
@end
