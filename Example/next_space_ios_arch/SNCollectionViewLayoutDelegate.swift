//
//  SNCollectionViewLayoutDelegate.swift
//  SNCollectionViewLayout
//
//  Created by Ahmad Almasri on 10/05/2021.
//

import Foundation


@objc public protocol SNCollectionViewLayoutDelegate {
    func scaleForItem(inCollectionView collectionView: UICollectionView, withLayout layout: UICollectionViewLayout, atIndexPath indexPath: IndexPath) -> UInt
    func itemFlexibleDimension(inCollectionView collectionView: UICollectionView, withLayout layout: UICollectionViewLayout, fixedDimension: CGFloat) -> CGFloat
    func headerFlexibleDimension(inCollectionView collectionView: UICollectionView, withLayout layout: UICollectionViewLayout, fixedDimension: CGFloat) -> CGFloat
}


