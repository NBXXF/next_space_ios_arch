//
//  CoverVerticalAnimation.swift
//  Pods
//
//  Created by Daniel Lozano Valdés on 3/21/17.
//
//

import Foundation

@objcMembers open class CoverVerticalAnimation: PresentrAnimation {

    override public func transform(containerFrame: CGRect, finalFrame: CGRect) -> CGRect {
        var initialFrame = finalFrame
        initialFrame.origin.y = containerFrame.height + initialFrame.height
        return initialFrame
    }
    
}
