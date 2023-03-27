//
//  XXFHelperMenuCellTableViewCell.m
//  AFNetworking
//
//  Created by XXF on 2023/2/17.
//

#import "XXFHelperMenuCellTableViewCell.h"
@implementation XXFHelperMenuCellTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self setupUI];
    }
    return self;
}


- (void)setItemMenu:(id<NXItemMenu>)itemMenu{
    _itemMenu=itemMenu;
    
    self.menuTitleLabel.text=itemMenu.title;
    self.menuSubTitleLabel.text=itemMenu.subTitle;
    [self.checkedSwitch setOn:itemMenu.isItemSelected];
}

-(void)setupUI{
    [self.contentView addSubview:self.menuTitleLabel];
    [self.contentView addSubview:self.menuSubTitleLabel];
    [self.contentView addSubview:self.checkedSwitch];
    
    [self.menuTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView).inset(80);
    }];
    [self.menuSubTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.menuTitleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView).inset(80);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    [self.checkedSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-5);
    }];
}


- (UILabel *)menuTitleLabel{
    if(!_menuTitleLabel){
        _menuTitleLabel=UILabel.new;
        _menuTitleLabel.textColor=UIColor.blackColor;
        _menuTitleLabel.font=[UIFont boldSystemFontOfSize:16];
        _menuTitleLabel.text=@"标题";
    }
    return _menuTitleLabel;
}

- (UILabel *)menuSubTitleLabel{
    if(!_menuSubTitleLabel){
        _menuSubTitleLabel=UILabel.new;
        _menuSubTitleLabel.textColor=UIColor.grayColor;
        _menuSubTitleLabel.font=[UIFont systemFontOfSize:12];
        _menuSubTitleLabel.text=@"子标题";
        _menuTitleLabel.numberOfLines=2;
    }
    return _menuSubTitleLabel;
}
- (UISwitch *)checkedSwitch{
    if(!_checkedSwitch){
        _checkedSwitch=UISwitch.new;
        _checkedSwitch.userInteractionEnabled=NO;
    }
    return _checkedSwitch;
}

@end
