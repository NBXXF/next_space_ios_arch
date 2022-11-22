//
//  UIView+NXVisibility.h
//  XXF
//  替代系统的hidden字段隐藏还展位的情况
//  Created by xxf on 2022/11/21.
//

#import "UIView+NXVisibility.h"
#import "NSLayoutConstraint+NXVisibiltiy.h"

@implementation UIView(Visibility)

/**
 注意 UIViewVisibilityGone 应该是清除所有边距，这也是默认行为
 */
-(void)setVisibility:(UIViewVisibility)visibility {
    [self setVisibility:visibility affectedMarginDirections:UIViewMarginDirectionAll];
}

-(void)setVisibility:(UIViewVisibility)visibility affectedMarginDirections:(UIViewMarginDirection)affectedMarginDirections {
    [self testPrintLayoutConstraintFromView:self.superview];
    switch (visibility) {
        case UIViewVisibilityVisible:
            self.hidden = NO;
            [[self findConstraintFromView:self forLayoutAttribute:NSLayoutAttributeWidth] restore];
            [[self findConstraintFromView:self forLayoutAttribute:NSLayoutAttributeHeight] restore];
            [self restoreMarginForDirections:affectedMarginDirections];
            break;
        case UIViewVisibilityInvisible:
            self.hidden = YES;
            break;
        case UIViewVisibilityGone:
            self.hidden = YES;
            [[self findConstraintFromView:self forLayoutAttribute:NSLayoutAttributeWidth] clear];
            [[self findConstraintFromView:self forLayoutAttribute:NSLayoutAttributeHeight] clear];
            [self clearMarginForDirections:affectedMarginDirections];
            break;
        default:
            break;
    }
    
    if (visibility != UIViewVisibilityInvisible) {
        [self layoutIfNeeded];
    }
}

-(void)clearMarginForDirections:(UIViewMarginDirection)affectedMarginDirections {
    if (affectedMarginDirections == UIViewMarginDirectionNone) {
        return;
    }
    
    if (UIViewMarginDirectionTop & affectedMarginDirections) {
        [[self findConstraintFromView:self.superview forLayoutAttribute:NSLayoutAttributeTop] clear];
    }
    if (UIViewMarginDirectionLeft & affectedMarginDirections) {
        [[self findConstraintFromView:self.superview forLayoutAttribute:NSLayoutAttributeLeading] clear];
    }
    if (UIViewMarginDirectionBottom & affectedMarginDirections) {
        [[self findConstraintFromView:self.superview forLayoutAttribute:NSLayoutAttributeBottom] clear];
    }
    if (UIViewMarginDirectionRight & affectedMarginDirections) {
        [[self findConstraintFromView:self.superview forLayoutAttribute:NSLayoutAttributeTrailing] clear];
    }
}

-(void)restoreMarginForDirections:(UIViewMarginDirection)affectedMarginDirections {
    if (affectedMarginDirections == UIViewMarginDirectionNone) {
        return;
    }
    
    if (UIViewMarginDirectionTop & affectedMarginDirections) {
        [[self findConstraintFromView:self.superview forLayoutAttribute:NSLayoutAttributeTop] restore];
    }
    if (UIViewMarginDirectionLeft & affectedMarginDirections) {
        [[self findConstraintFromView:self.superview forLayoutAttribute:NSLayoutAttributeLeading] restore];
    }
    if (UIViewMarginDirectionBottom & affectedMarginDirections) {
        [[self findConstraintFromView:self.superview forLayoutAttribute:NSLayoutAttributeBottom] restore];
    }
    if (UIViewMarginDirectionRight & affectedMarginDirections) {
        [[self findConstraintFromView:self.superview forLayoutAttribute:NSLayoutAttributeTrailing] restore];
    }
}

-(NSDictionary *)getStringDic{
    NSDictionary *dictionary=@{
        @0:@"NSLayoutAttributeNotAnAttribute",
        @1:@"NSLayoutAttributeLeft",
                               @2:@"NSLayoutAttributeRight",
                               @3:@"NSLayoutAttributeTop",
                               @4:@"NSLayoutAttributeBottom",
                               @5:@"NSLayoutAttributeLeading",
                               @6:@"NSLayoutAttributeTrailing",
                               @7:@"NSLayoutAttributeWidth",
                               @8:@"NSLayoutAttributeHeight",
                               @9:@"NSLayoutAttributeCenterX",
                               @10:@"NSLayoutAttributeCenterY",
    };
    return dictionary;
}


-(void)testPrintLayoutConstraintFromView:(UIView *)view {
//    NSArray<__kindof NSLayoutConstraint *> *constraints= view.constraints;
//    NSDictionary *dictionary= [self getStringDic];
//    for (NSLayoutConstraint *constraint in view.constraints) {
//        NSString *str=@"=========>c:";
//        str=[str stringByAppendingFormat:@"firstItem:%ld   ",((UIView *)constraint.firstItem).tag];
//        str=[str stringByAppendingFormat:@"firstAttribute:%@   ",[dictionary objectForKey:@(constraint.firstAttribute)]];
//
//        str=[str stringByAppendingFormat:@"secondItem:%ld   ",((UIView *)constraint.secondItem).tag];
//        str= [str stringByAppendingFormat:@"secondAttribute:%@   ",[dictionary objectForKey:@(constraint.secondAttribute)]];
//        NSLog(str);
//    }
}


-(NSLayoutConstraint *)findConstraintFromView:(UIView *)view forLayoutAttribute:(NSLayoutAttribute)layoutAttribute {
    for (NSLayoutConstraint *constraint in view.constraints) {
        //会把其他组件相对这个组件的约束也清除 UIViewMarginDirectionAll
//        if ((constraint.firstItem == self && constraint.firstAttribute == layoutAttribute) ||
//            (constraint.secondItem == self && constraint.secondAttribute == layoutAttribute)) {
//            return constraint;
//        }
        
        if (constraint.firstItem == self && constraint.firstAttribute == layoutAttribute) {
            return constraint;
        }
    }
    return nil;
}

- (BOOL)isVisible{
    return !self.isHidden;
}

@end
