//
//  NXCollectionViewPageLayout.swift
//  NXCollectionViewPageLayout
//  中间定位,支持滚动翻页
//  Created by XXF on 2023/4/18.
// 参考https://github.com/NBXXF/FAPaginationLayout?organization=NBXXF&organization=NBXXF
// 有更改

/**
 简单用法
 collectionView.contentInset = UIEdgeInsets.init(top: 0, left: 30, bottom: 0, right: 30)
 collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
 collectionView.flowLayout=NXCollectionViewPageLayout.new;
 */

import UIKit


@objcMembers open class NXCollectionViewPageLayout: UICollectionViewFlowLayout {
    
    private var insertingTopCells: Bool = false
    private var sizeForTopInsertions: CGSize = CGSize.zero
    public var currentCenteredPage: Int {
        guard let collectionView = collectionView else { return -1 }
        let currentCenteredPoint = CGPoint(x: collectionView.contentOffset.x + collectionView.bounds.width/2, y: collectionView.contentOffset.y + collectionView.bounds.height/2)
        
        return collectionView.indexPathForItem(at: currentCenteredPoint)?.row ?? -1
    }
    
    public override init() {
        super.init()
        self.scrollDirection = .horizontal
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.scrollDirection = .horizontal
    }
    
    override public func prepare() {
        
        super.prepare()

        let oldSize: CGSize = sizeForTopInsertions
        
        if insertingTopCells {
            
            let newSize: CGSize  = collectionViewContentSize
            let xOffset: CGFloat = collectionView!.contentOffset.x + (newSize.width - oldSize.width)
            let newOffset: CGPoint = CGPoint(x: xOffset, y: collectionView!.contentOffset.y)
            collectionView!.contentOffset = newOffset
        }
        else {
            insertingTopCells = false
        }

        sizeForTopInsertions = collectionViewContentSize
    }
    

    var lastPoint: CGPoint = CGPoint.zero
    override public func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var layoutAttributes: Array = layoutAttributesForElements(in: collectionView!.bounds)!
        
        if layoutAttributes.count == 0 {
            return proposedContentOffset
        }
        var targetIndex = layoutAttributes.count / 2
        
        // Skip to the next cell, if there is residual scrolling velocity left.
        // This helps to prevent glitches
        let vX = velocity.x
        
        if vX > 0 {
            targetIndex += 1
        } else if vX < 0.0 {
            targetIndex -= 1
        }else if vX == 0 {
            // 没有速度时根据当前中心点位置决定停在哪一页 5.6日修改
            let currentPage = currentCenteredPage
            if let target = layoutAttributes.firstIndex { attr in
                attr.indexPath.row == currentPage
            } {
                targetIndex = target
            } else {
                return lastPoint
            }
            
//            return lastPoint
        }
        
        if targetIndex >= layoutAttributes.count {
            targetIndex = layoutAttributes.count - 1
        }
        
        if targetIndex < 0 {
            targetIndex = 0
        }
        
        let targetAttribute = layoutAttributes[targetIndex]
        
        lastPoint = CGPoint(x: targetAttribute.center.x - collectionView!.bounds.size.width * 0.5, y: proposedContentOffset.y)
        return lastPoint
    }
    
}
