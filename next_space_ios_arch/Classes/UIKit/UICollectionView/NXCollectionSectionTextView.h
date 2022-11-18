//
//  NXCollectionSectionTextViewCollectionReusableView.h
//  next_space_ios_arch
//  常见分组section
//  Created by 1234 on 2022/11/18.
//

#import <UIKit/UIKit.h>
#import "NXCollectionReusableView.h"
NS_ASSUME_NONNULL_BEGIN

@interface NXCollectionSectionTextView : NXCollectionReusableView

//内置textLabel;
@property (nonatomic, readonly, strong) UILabel *textLabel;
@end

NS_ASSUME_NONNULL_END
