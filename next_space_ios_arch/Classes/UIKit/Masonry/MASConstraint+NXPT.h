//
//  MASConstraint+NXPT.h
//  next_space_ios_arch
//  采用相对单位,屏幕适配
//  Created by 1234 on 2022/11/24.
//

#import <Foundation/Foundation.h>
#import <Masonry/Masonry.h>
NS_ASSUME_NONNULL_BEGIN

@interface MASConstraint(NXPT)

- (MASConstraint * (^)(MASEdgeInsets insets))insetsPT;


- (MASConstraint * (^)(CGFloat inset))insetPT;


- (MASConstraint * (^)(CGSize offset))sizeOffsetPT;


- (MASConstraint * (^)(CGPoint offset))centerOffsetPT;


- (MASConstraint * (^)(CGFloat offset))offsetPT;

@end

NS_ASSUME_NONNULL_END
