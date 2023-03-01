//
//  XXFHelperViewController.m
//  AFNetworking
//  开发者中心
//  Created by XXF on 2023/2/16.
//

#import "XXFHelperViewController.h"
#import "next_space_ios_arch/XXF.h"
#import <next_space_ios_arch/NSObject+NXTools.h>
#import <next_space_ios_arch/UITableView+NXRegister.h>
#import <next_space_ios_arch/XXFHelperMenuCellTableViewCell.h>
#import <next_space_ios_arch/RACSignal+AppArch.h>
#import <next_space_ios_arch/NSObject+NXRACSignalSupport.h>
#import <next_space_ios_arch/NXRouter.h>
#import <next_space_ios_arch/next_space_ios_arch-Swift.h>

@interface XXFHelperViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray<id<NXItemMenu>> *dataArray;
@end

@implementation XXFHelperViewController

+ (void)load{
    [NXRouter registerURL:@"XXFHelperViewController" targetClass:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self loadData];

}


-(void)setupUI{
    self.view.backgroundColor=UIColor.whiteColor;
    UILabel *titleLabel=UILabel.new;
    titleLabel.textColor=UIColor.redColor;
    titleLabel.text=@"XXF Developer help";
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(40);
        make.left.right.equalTo(self.view).inset(16);
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(10);
        make.left.right.equalTo(self.view).inset(16);
        make.bottom.equalTo(self.view);
    }];
}

-(void)loadData{
    self.dataArray=[[NSMutableArray array] applyWithBlock:^(NSMutableArray *_Nonnull it) {
        [it addObject:[NXItemMenuImpl.new applyWithBlock:^(NXItemMenuImpl *_Nonnull it) {
            it.title=@"是否允许获取堆栈";
            it.subTitle=@"获取堆栈将会十分卡顿,(设置仅限于内存生效,app重启将会重置)";
            [it setItemSelected:XXF.shared.config.allowCallStackSymbols];
            it.flag=NXHelperCellType.typeStack;
        }]];
        
        [it addObject:[NXItemMenuImpl.new applyWithBlock:^(NXItemMenuImpl *_Nonnull it) {
            it.title=@"是否禁止线程检查";
            it.subTitle=@"禁止线程检查可能会导致最终卡顿,(设置仅限于内存生效,app重启将会重置)";
            [it setItemSelected:XXF.shared.config.disableThreadCheck];
            it.flag=NXHelperCellType.typeThread;
        }]];
        
        [it addObject:[NXItemMenuImpl.new applyWithBlock:^(NXItemMenuImpl *_Nonnull it) {
            it.title=@"是否禁止CPU检查";
            it.subTitle=@"禁止CPU检查可能会导致最终卡顿,(设置仅限于内存生效,app重启将会重置)";
            [it setItemSelected:XXF.shared.config.disableCpuCheck];
            it.flag=NXHelperCellType.typeThread;
        }]];
        
        [it addObject:[NXItemMenuImpl.new applyWithBlock:^(NXItemMenuImpl *_Nonnull it) {
            it.title=@"是否禁止Memory检查";
            it.subTitle=@"禁止Memory检查可能会导致最终卡顿,(设置仅限于内存生效,app重启将会重置)";
            [it setItemSelected:XXF.shared.config.disableMemoryCheck];
            it.flag=NXHelperCellType.typeThread;
        }]];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XXFHelperMenuCellTableViewCell *cell = [tableView dequeueReusableCellWithClass:XXFHelperMenuCellTableViewCell.class];
    id<NXItemMenu> item=self.dataArray[indexPath.row];
    cell.itemMenu=item;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    id<NXItemMenu> item=self.dataArray[indexPath.row];
    [item setItemSelected:!item.isItemSelected];
    if(item.flag==NXHelperCellType.typeStack){
        XXF.shared.config.allowCallStackSymbols=item.isItemSelected;
    }else if(item.flag==NXHelperCellType.typeThread){
        XXF.shared.config.disableThreadCheck=item.isItemSelected;
    }else if(item.flag==NXHelperCellType.typeCpu){
        XXF.shared.config.disableCpuCheck=item.isItemSelected;
    }else if(item.flag==NXHelperCellType.typeMemory){
        XXF.shared.config.disableMemoryCheck=item.isItemSelected;
    }
    [tableView reloadData];
}



- (UITableView *)tableView{
    if(!_tableView){
        _tableView=[[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain] applyWithBlock:^(UITableView *_Nonnull it) {
            it.delegate=self;
            it.dataSource=self;
            it.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
            it.separatorColor=UIColor.linkColor;
            it.showsVerticalScrollIndicator = NO;
            it.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGFLOAT_MIN, CGFLOAT_MIN)];
            it.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }];
    }
    return _tableView;
}
@end
