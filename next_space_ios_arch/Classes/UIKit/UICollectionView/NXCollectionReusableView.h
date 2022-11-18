//
//  NXCollectionReusableView.h
//  next_space_ios_arch
//  规范section
//  Created by XXF on 2022/11/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NXCollectionReusableView : UICollectionReusableView
@property(nonatomic, readonly) UIView *contentView;
@property(nonatomic, strong, nullable) UIView *backgroundView;
@end

NS_ASSUME_NONNULL_END
