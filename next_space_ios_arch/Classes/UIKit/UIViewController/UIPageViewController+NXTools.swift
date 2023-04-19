//
//  UIPageViewController+NXTools.swift
//  next_space_ios_arch
//
//  Created by XXF on 2023/4/19.
//

import Foundation
@objc extension UIPageViewController {
    /**
     设置是否支持滚动
     */
   @objc var isPagingEnabled: Bool {
        get {
            var isEnabled: Bool = true
            for view in view.subviews {
                if let subView = view as? UIScrollView {
                    isEnabled = subView.isScrollEnabled
                }
            }
            return isEnabled
        }
        set {
            for view in view.subviews {
                if let subView = view as? UIScrollView {
                    subView.isScrollEnabled = newValue
                }
            }
        }
    }
}
