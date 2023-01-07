//
//  UIView+NXDrop.m
//  AFNetworking
//
//  Created by XXF on 2023/1/6.
//

#import "UIView+NXDrop.h"
#import <objc/runtime.h>

@interface UIView(NXDrop)
@property(nonatomic,strong)NSMutableArray<CALayer *> *associatedDrapLocationLayers;
@end


@implementation UIView(NXDrop)
const char *NXDROP_LAYERS_KEY = "NXDROP_LAYERS_KEY";

- (NSMutableArray<CALayer *> *)associatedDrapLocationLayers{
    NSMutableArray<CALayer *> *array=objc_getAssociatedObject(self, NXDROP_LAYERS_KEY);
    if(!array){
        array=[NSMutableArray array];
    }
    return array;
}

- (void)setAssociatedDrapLocationLayers:(NSMutableArray<CALayer *> *)associatedDrapLocationLayers{
    objc_setAssociatedObject(self, NXDROP_LAYERS_KEY, associatedDrapLocationLayers, OBJC_ASSOCIATION_RETAIN);
}


- (NSArray<CALayer *> *)drapLocationLayers{
    NSMutableArray<CALayer *> *mutArr=self.associatedDrapLocationLayers;
    BOOL changed=NO;
    for(int i = (int)mutArr.count-1; i>=0; i--){
        CALayer *data=mutArr[i];
        if(!data.superlayer){
            [mutArr removeObjectAtIndex:i];
            changed=YES;
        }
    }
    if(changed){
        self.associatedDrapLocationLayers=mutArr;
    }
    return mutArr;
}

- (void)addDrapLocationLayer:(CALayer *)layer{
    [self.layer addSublayer:layer];
    NSMutableArray<CALayer *> *mutArr=self.associatedDrapLocationLayers;
    [mutArr removeObject:layer];
    [mutArr addObject:layer];
    self.associatedDrapLocationLayers=mutArr;
}



- (void)removeDrapLocationLayer:(CALayer *)layer{
    [layer removeFromSuperlayer];
    NSMutableArray<CALayer *> *mutArr=self.associatedDrapLocationLayers;
    [mutArr removeObject:layer];
    self.associatedDrapLocationLayers=mutArr;
}

- (void)removeDrapLocationLayers{
    NSMutableArray<CALayer *> *mutArr=self.associatedDrapLocationLayers;
    for(int i = (int)mutArr.count-1; i>=0; i--){
        CALayer *data=mutArr[i];
        [data removeFromSuperlayer];
        [mutArr removeObjectAtIndex:i];
    }
    [mutArr removeAllObjects];
    self.associatedDrapLocationLayers=mutArr;
}

@end
