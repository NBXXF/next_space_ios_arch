//
//  CMCollectionCommonFlowLayout.h
//  CMCollectionWaterFall
//
//

#import <UIKit/UIKit.h>

@protocol CMWaterFallDataSource <NSObject>

@required

- (CGFloat)cm_heightForItem:(NSIndexPath *)indexPath;



@end


@interface CMWaterFallLayout : UICollectionViewFlowLayout


/**列数*/
@property (nonatomic,assign) NSInteger closCount;

/**数据源代理*/
@property (nonatomic,weak) id<CMWaterFallDataSource> dataSource;



@end
