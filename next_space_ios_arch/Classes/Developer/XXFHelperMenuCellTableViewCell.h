//
//  XXFHelperMenuCellTableViewCell.h
//  AFNetworking
//
//  Created by 1234 on 2023/2/17.
//

#import <UIKit/UIKit.h>
#import <next_space_ios_arch/NXItemMenu.h>
#import <next_space_ios_arch/NXItemMenuImpl.h>
#import <Masonry/Masonry-umbrella.h>

NS_ASSUME_NONNULL_BEGIN

@interface XXFHelperMenuCellTableViewCell : UITableViewCell
@property(nonatomic,strong)id<NXItemMenu> itemMenu;

@property(nonatomic,strong) UILabel *menuTitleLabel;
@property(nonatomic,strong) UILabel *menuSubTitleLabel;
@property(nonatomic,strong) UISwitch *checkedSwitch;
@end

NS_ASSUME_NONNULL_END
