//
//  UIScrollView+Snapshot.swift
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

extension UIScrollView {

    override
    public func nx_takeSnapshotOfVisibleContent() -> UIImage? {
        // 获取当前可视区域的rect
        var visibleRect = self.bounds
        visibleRect.origin = self.contentOffset

        return self.nx_takeSnapshotOfFullContent(for: visibleRect)
    }

    override
    public func nx_takeSnapshotOfFullContent() -> UIImage? {
        let originalFrame = self.frame
        let originalOffset = self.contentOffset

        self.frame = CGRect.init(origin: originalFrame.origin, size: self.contentSize)
        self.contentOffset = .zero

        let backgroundColor = self.backgroundColor ?? UIColor.white

        UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, 0)

        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        context.setFillColor(backgroundColor.cgColor)
        context.setStrokeColor(backgroundColor.cgColor)

        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        self.frame = originalFrame
        self.contentOffset = originalOffset

        return image
    }

    override
    public func nx_asyncTakeSnapshotOfFullContent(_ maxPage: Int, completion: @escaping ((UIImage?) -> Void)) {
        // 分页绘制内容到ImageContext
        let originalOffset = self.contentOffset

        // 当contentSize.height<bounds.height时，保证至少有1页的内容绘制
        var pageNum = 1
        if self.bounds.height <= 0 {
            pageNum = 1
        }else if self.contentSize.height > self.bounds.height {
            pageNum = Int(ceilf(Float(self.contentSize.height / self.bounds.height)))
        }

        let maxPage=min(pageNum,maxPage);
        
        let backgroundColor = self.backgroundColor ?? UIColor.white

        
        let cropRect=CGSize(width: self.contentSize.width, height: min(self.contentSize.height,CGFloat(maxPage) * self.bounds.height));
        UIGraphicsBeginImageContextWithOptions(cropRect, true, 0)

        guard let context = UIGraphicsGetCurrentContext() else {
            completion(nil)
            return
        }
        context.setFillColor(backgroundColor.cgColor)
        context.setStrokeColor(backgroundColor.cgColor)

        self.nx_drawScreenshotOfPageContent(0, maxIndex: maxPage-1) {
            var image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.contentOffset = originalOffset
            if((image != nil)&&image!.size.height>self.contentSize.height){
                image=self.__cropImage(CGRect(x: 0, y: 0, width: image!.size.width, height: self.contentSize.height), image: image!);
            }
            //这里从项目迁移而来
            guard let image = image else {
                completion(self.nx_takeSnapshotOfVisibleContent())
                return
            }
            completion(image)
        }
    }

    func __cropImage(_ rect: CGRect,image:UIImage) -> UIImage? {
          var newRect = rect
        newRect.origin.x *= image.scale
        newRect.origin.y *= image.scale
        newRect.size.width *= image.scale
        newRect.size.height *= image.scale
        guard let imageRef = image.cgImage?.cropping(to: newRect) else { return nil }
        return UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
    }
    
    fileprivate func nx_drawScreenshotOfPageContent(_ index: Int, maxIndex: Int, completion: @escaping () -> Void) {

        self.setContentOffset(CGPoint(x: 0, y: CGFloat(index) * self.frame.size.height), animated: false)
        let pageFrame = CGRect(x: 0, y: CGFloat(index) * self.frame.size.height, width: self.bounds.size.width, height: self.bounds.size.height)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            self.drawHierarchy(in: pageFrame, afterScreenUpdates: true)

            if index < maxIndex {
                self.nx_drawScreenshotOfPageContent(index + 1, maxIndex: maxIndex, completion: completion)
            }else{
                completion()
            }
        }
    }
}
