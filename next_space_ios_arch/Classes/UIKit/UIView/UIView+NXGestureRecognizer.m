//
//  UIView+NXGestureRecognizer.m
//  next_space_ios_arch
//
//  Created by XXF on 2022/11/5.
//

#import "UIView+NXGestureRecognizer.h"
#import <objc/runtime.h>

@implementation UIView(NXGestureRecognizer)

#pragma mark - 解决手势冲突
//在单击和双击手势时,由于手势的触发条件会有重合,有些情况下会产生冲突,无法达到满意的效果,利用 requireGestureRecognizerToFail 的方法指定某个手势确定失效之后才会触发本次手势，即使本次手势的触发条件已经满足
static inline void requireSingleTapsRecognizer(UIGestureRecognizer *recognizer,UIView *target) {
    for (UIGestureRecognizer *gesture in target.gestureRecognizers) {
        if ([gesture isKindOfClass:[UITapGestureRecognizer class]]) {
            UITapGestureRecognizer *tap = (UITapGestureRecognizer *)gesture;
            if (tap.numberOfTouchesRequired==1&tap.numberOfTapsRequired == 1) {
                [tap requireGestureRecognizerToFail:recognizer];
            }
        }
    }
}

static inline void requireDoubleTapsRecognizer(UIGestureRecognizer *recognizer,UIView *target) {
    for (UIGestureRecognizer *gesture in target.gestureRecognizers) {
        if ([gesture isKindOfClass:[UITapGestureRecognizer class]]) {
            UITapGestureRecognizer *tap = (UITapGestureRecognizer *)gesture;
            if (tap.numberOfTapsRequired == 2&tap.numberOfTouchesRequired == 1) {
                [tap requireGestureRecognizerToFail:recognizer];
            }
        }
    }
}


static inline void requireLongPressTecognizer(UIGestureRecognizer *recognizer,UIView *target) {
    for (UIGestureRecognizer *gesture in target.gestureRecognizers){
        if ([gesture isKindOfClass:[UILongPressGestureRecognizer class]]) {
            UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)gesture;
            [longPress requireGestureRecognizerToFail:recognizer];
        }
    }
}

//关键字为void*指针（任意类型指针）,每一个关联的关键字必须是唯一的，通常采用静态变量来作为关键字
static char NXViewSingleTapBlockKey;
static char NXViewDoubleTapBlockKey;
static char NXViewDoubleFingerTapBlockKey;
static char NXViewTouchDownTapBlockKey;
static char NXViewTouchUpTapBlcokKey;
static char NXViewLongPressBlockKey;

#pragma mark - 添加block属性
//获取关联对象
- (void)makeBlockForkey:(void *)key {
    NXViewTappedBlock block = objc_getAssociatedObject(self, key);
    if (block) block();
}

//创建关联
- (void)setBlockForKey:(void *)key block:(NXViewTappedBlock)block {
    self.userInteractionEnabled = YES;
    objc_setAssociatedObject(self, key, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark - CallBacks
- (void)singleTap {
    [self makeBlockForkey:&NXViewSingleTapBlockKey];
}

- (void)doubleTap {
    [self makeBlockForkey:&NXViewDoubleTapBlockKey];
}

- (void)doubleFingerTap {
    [self makeBlockForkey:&NXViewDoubleFingerTapBlockKey];
}

- (void)longPress:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan)[self makeBlockForkey:&NXViewLongPressBlockKey];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self makeBlockForkey:&NXViewTouchDownTapBlockKey];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [self makeBlockForkey:&NXViewTouchUpTapBlcokKey];
}

#pragma mark -Taps
- (void)whenTapped:(NXViewTappedBlock)block {
    UITapGestureRecognizer *tap = [self addTapRecognizerWithTaps:1 touches:1 sel:@selector(singleTap)];
    requireDoubleTapsRecognizer(tap,self);
    requireLongPressTecognizer(tap,self);
    [self setBlockForKey:&NXViewSingleTapBlockKey block:block];
}

- (void)whenDoubleTapped:(NXViewTappedBlock)block {
    UITapGestureRecognizer *tap = [self addTapRecognizerWithTaps:2 touches:1 sel:@selector(doubleTap)];
    requireSingleTapsRecognizer(tap,self);
    [self setBlockForKey:&NXViewDoubleTapBlockKey block:block];
}

- (void)whenDoubleFingerTapped:(NXViewTappedBlock)block {
    [self addTapRecognizerWithTaps:1 touches:2 sel:@selector(doubleFingerTap)];
    [self setBlockForKey:&NXViewDoubleFingerTapBlockKey block:block];
}

- (void)whenLongPress:(NXViewTappedBlock)block {
    [self addLongPressRecognizerWithTouches:1 sel:@selector(longPress:)];
    [self setBlockForKey:&NXViewLongPressBlockKey block:block];
}

- (void)whenTouchDown:(NXViewTappedBlock)block {
    [self setBlockForKey:&NXViewTouchDownTapBlockKey block:block];
}

- (void)whenTouchUp:(NXViewTappedBlock)block {
    [self setBlockForKey:&NXViewTouchUpTapBlcokKey block:block];
}

#pragma mark - 添加手势
- (UITapGestureRecognizer *)addTapRecognizerWithTaps:(NSUInteger)taps touches:(NSUInteger)touches sel:(SEL)sel {
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc]initWithTarget:self action:sel];
    tapGr.delegate = self;
    tapGr.numberOfTapsRequired = taps;
    tapGr.numberOfTouchesRequired = touches;
    [self addGestureRecognizer:tapGr];
    return tapGr;
}

- (UILongPressGestureRecognizer *)addLongPressRecognizerWithTouches:(NSUInteger)touches sel:(SEL)sel {
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:sel];
    longPress.numberOfTouchesRequired = touches;
    longPress.delegate = self;
    [self addGestureRecognizer:longPress];
    return longPress;
}

#pragma mark - UIGestureRecognizerDelegate

@end
