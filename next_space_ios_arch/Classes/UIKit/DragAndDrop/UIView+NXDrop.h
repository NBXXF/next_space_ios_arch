//
//  UIView+NXDrop.h
//  AFNetworking
//  封装常见的拖动处理layer的情况
//  Created by XXF on 2023/1/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView(NXDrop)

/**
 droping 附加的sublayer 长用于拖动定位
 */
@property(nonatomic,strong,readonly)NSArray<CALayer *> *drapLocationLayers;

- (void)addDrapLocationLayer:(CALayer *)layer;

- (void)removeDrapLocationLayer:(CALayer *)layer;

- (void)removeDrapLocationLayers;
@end

NS_ASSUME_NONNULL_END
