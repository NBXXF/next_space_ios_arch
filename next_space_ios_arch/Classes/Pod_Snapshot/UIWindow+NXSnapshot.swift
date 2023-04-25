//
//  UIWindow+Snapshot.swift
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

import UIKit

extension UIWindow {
    override
    public func nx_takeSnapshotOfVisibleContent() -> UIImage? {
        return self.nx_takeSnapshotOfFullContent()
    }

    override
    public func nx_takeSnapshotOfFullContent() -> UIImage? {
        let backgroundColor = self.backgroundColor ?? UIColor.white

        UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, 0)

        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        context.setFillColor(backgroundColor.cgColor)
        context.setStrokeColor(backgroundColor.cgColor)

        // 使用 layer.render(in: context)的方式生成截图时，在iOS 8.0下，UIWindow展示的是WKWebView时，WKWebView区域的内容是一片空白
        // 使用 drawHierarchy 则无此问题
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }

    override
    public func nx_asyncTakeSnapshotOfFullContent(_ maxPage:Int,completion: @escaping ((UIImage?) -> Void)) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            let image = self.nx_takeSnapshotOfFullContent()
            completion(image)
        }
    }
}
