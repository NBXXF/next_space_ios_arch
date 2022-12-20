//
//  NXTestFlowLayoutViewController.m
//  next_space_ios_arch_Example
//
//  Created by 1234 on 2022/12/9.
//

#import "NXTestFlowLayoutViewController.h"
#import <next_space_ios_arch/next_space_ios_arch-umbrella.h>
#import "MyCellCollectionViewCell.h"

//@interface NXTestFlowLayoutViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,SNCollectionViewLayoutDelegate>
//@property(nonatomic,strong)UICollectionView *collectionView;
//
//@end

@implementation NXTestFlowLayoutViewController

//- (void)viewDidLoad {
//    [super viewDidLoad];
// 
//    [self.view addSubview:self.collectionView];
//    [self.collectionView mas_makeConstraintsWithSelf:^(MASConstraintMaker * _Nonnull make, __kindof UIView * _Nonnull it, UIView * _Nonnull superview) {
//        make.edges.equalTo(superview);
//    }];
//    
//    SNCollectionViewLayout *snCollectionViewLayout=SNCollectionViewLayout.new;
//   
//    snCollectionViewLayout.fixedDivisionCount = 4; // Columns for .vertical, rows for .horizontal
//    snCollectionViewLayout.delegate = self;
//    self.collectionView.collectionViewLayout = snCollectionViewLayout;
//    
//    [[UIApplication.sharedApplication keyWindow] endEditing:YES];
//    
//   RACSignal *first= [RACSignal just:@"x"];
//    [[first concat:[RACSignal defer:^RACSignal * _Nonnull{
//        [NSThread sleepForTimeInterval:2.0];
//        return [RACSignal just:@"y"];
//    }]].subscribeOnSubThread subscribeNext:^(id  _Nullable x) {
//        NSLog(@"============>收到:%@",x);
//    }];
//
//}
//
//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    [[UIApplication.sharedApplication keyWindow] endEditing:YES];
//}
//- (NSUInteger)scaleForItemInCollectionView:(UICollectionView *)collectionView withLayout:(UICollectionViewLayout *)layout atIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row == 0 || indexPath.row == 3 || indexPath.row == 10 || indexPath.row == 70) {
//        return 4;
//    }
//    if (indexPath.row%4==0) {
//        return 3;
//    }
//    
//    if(indexPath.row%3==0){
//        return 2;
//    }
//    return 1;
//}
//- (CGFloat)itemFlexibleDimensionInCollectionView:(UICollectionView *)collectionView withLayout:(UICollectionViewLayout *)layout fixedDimension:(CGFloat)fixedDimension{
//    NSLog(@"============>fix:%f",fixedDimension);
//    return fixedDimension;
//}
//- (CGFloat)headerFlexibleDimensionInCollectionView:(UICollectionView *)collectionView withLayout:(UICollectionViewLayout *)layout fixedDimension:(CGFloat)fixedDimension{
//    return 0;
//}
//
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    return 100;
//}
//
//- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    MyCellCollectionViewCell *cell=[collectionView dequeueReusableCellWithClass:MyCellCollectionViewCell.class forIndexPath:indexPath];
//    cell.textview.text=[NSString stringWithFormat:@"index:%ld",(long)indexPath.row];
//    cell.contentView.backgroundColor=[self randomColor];
//    return cell;
//}
//
//- (UIColor *)randomColor
//{
//    return [UIColor colorWithRed:arc4random_uniform(256.0) / 255.0 green:arc4random_uniform(256.0) / 255.0 blue:arc4random_uniform(256.0) / 255.0 alpha:1];
//}
//
//
//- (UICollectionView *)collectionView{
//    if(!_collectionView){
//        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
////        layout.itemSize=CGSizeMake(kScreenWidth-KRealWidth(32), KRealWidth(105));
//        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
//        _collectionView.backgroundColor = UIColor.clearColor;
//        _collectionView.dataSource=self;
//        _collectionView.delegate=self;
//    }
//    return _collectionView;
//}
//
//


@end
