//
//  UIView+Vibrate.m
//  next_space_ios_arch
//
//  Created by XXF on 2023/3/25.
//

#import "UIView+Feedback.h"
#import <next_space_ios_arch/NSObject+NXAssociation.h>
#import <next_space_ios_arch/NSDictionary+NXTools.h>
#import <next_space_ios_arch/NSMutableArray+NXTools.h>
#import <next_space_ios_arch/NSObject+NXTools.h>
@implementation ImpactFeedbackGenerator
singleton_implementation(ImpactFeedbackGenerator)

- (NSDictionary<NSNumber *,UIImpactFeedbackGenerator *> *)feedbackGenerators{
    if(!_feedbackGenerators){
        NSMutableDictionary *dict= [NSMutableDictionary dictionary];
        [dict setObject:[[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleHeavy] forKey:@(UIImpactFeedbackStyleHeavy)];
        [dict setObject:[[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight] forKey:@(UIImpactFeedbackStyleLight)];
        [dict setObject:[[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium] forKey:@(UIImpactFeedbackStyleMedium)];
        [dict setObject:[[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleSoft] forKey:@(UIImpactFeedbackStyleSoft)];
        [dict setObject:[[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleRigid] forKey:@(UIImpactFeedbackStyleRigid)];
        _feedbackGenerators=dict.copy;
    }
    return _feedbackGenerators;
}
@end






@implementation UIView(Feedback)
- (BOOL)allowFeedback{
    return [[self nx_getAssociatedObject:NSStringFromSelector(@selector(allowFeedback))] boolValue]
    &&self.userInteractionEnabled;
}
- (void)setAllowFeedback:(BOOL)allowFeedback{
    if(allowFeedback){
        self.userInteractionEnabled=YES;
    }
    [self nx_setAssociatedObject:@YES forKey:NSStringFromSelector(@selector(allowFeedback)) policy:NX_ASSOCIATION_ASSIGN];
}

- (UIImpactFeedbackStyle)feedbackStyle{
    //默认中等反馈震动
    id style=[self nx_getAssociatedObject:NSStringFromSelector(@selector(feedbackStyle))]?:@(UIImpactFeedbackStyleMedium);
    return [style integerValue];
}
- (void)setFeedbackStyle:(UIImpactFeedbackStyle)vibrateStyle{
    [self nx_setAssociatedObject:@(vibrateStyle) forKey:NSStringFromSelector(@selector(feedbackStyle))];
}

- (void)prepareFeedback{
    [[ImpactFeedbackGenerator.shared.feedbackGenerators objectForKey:@(self.feedbackStyle)] prepare];
}


- (void)performFeedback{
    [[ImpactFeedbackGenerator.shared.feedbackGenerators objectForKey:@(self.feedbackStyle)] impactOccurredWithIntensity:1.0];
}
@end
