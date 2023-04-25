//
//  UIScrollView+NXScroll.swift
//  next_space_ios_arch
//    预先定时任务滚动一下,避免没用渲染完成,从项目里面抽取出来
//  Created by XXF on 2023/4/6.
//

import Foundation

extension UIScrollView{
    
    /**
     预先定时任务滚动一下,避免没用渲染完成,从项目里面抽取出来 增加参数 别写死了
     */
    @objc
    public func nx_preScrollToEveryContent(_ maxPage: Int,completion: @escaping (() -> Void)) {
        // 分页绘制内容到ImageContext
        let originalOffset = self.contentOffset

        // 当contentSize.height<bounds.height时，保证至少有1页的内容绘制
        var pageNum = 1
        if self.contentSize.height > self.bounds.height {
            if self.bounds.height > 0 {
                pageNum = Int(ceil(Float(self.contentSize.height / self.bounds.height)))
            }else{
                pageNum = 1
            }
        }
        
        if pageNum >= maxPage { // 最大8屏
            pageNum = maxPage
        }

        self.scrollScreenshotOfPageContent(0, maxIndex: pageNum) {
            self.contentOffset = originalOffset
            completion()
        }
        
    }
    
    fileprivate func scrollScreenshotOfPageContent(_ index: Int,
                                                   maxIndex: Int,
                                                   completion: @escaping () -> Void) {

        self.setContentOffset(CGPoint(x: 0, y: CGFloat(index) * self.frame.size.height), animated: false)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            if index < maxIndex {
                self.scrollScreenshotOfPageContent(index + 1, maxIndex: maxIndex, completion: completion)
            }else{
                completion()
            }
        }
    }
}
