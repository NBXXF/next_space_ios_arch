//
//  SnapshotKitProtocol.swift
//  SnapshotKit
//
//  Created by York on 2018/9/9.
//
/**
  源码地址https://github.com/YK-Unit/SnapshotKit
   这里重新弄一份。业务那一份已经改得稀乱,改法不可逆,不符合编程规范
   所有类加NX
   所有方法加nx_
 */

import Foundation
import UIKit

public protocol NXSnapshotKitProtocol {

    /// Synchronously take a snapshot of the view's visible content
    ///
    /// - Returns: UIImage?
    func nx_takeSnapshotOfVisibleContent() -> UIImage?


    /// Synchronously take a snapshot of the view's full content
    ///
    /// - Important: when the size of the view's full content is small, use this method to take snapshot
    /// - Returns: UIImage?
    func nx_takeSnapshotOfFullContent() -> UIImage?

    /// Asynchronously take a snapshot of the view's full content
    ///
    /// - Important: when the size of the view's full content is large, use this method to take snapshot
    /// - Parameter maxPage: 最大页数 只针对滚动控件有效
    /// - Parameter completion: <#completion description#>
    func nx_asyncTakeSnapshotOfFullContent(_ maxPage: Int, completion: @escaping ((_ image: UIImage?) -> Void))
}
