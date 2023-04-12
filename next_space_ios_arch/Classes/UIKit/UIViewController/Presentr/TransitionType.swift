//
//  TransitionType.swift
//  Presentr
//
//  Created by Daniel Lozano on 7/6/16.
//  Copyright © 2016 danielozano. All rights reserved.
//

import Foundation

/// Describes the transition animation for presenting the view controller.
///
/// - crossDissolve: Crossfade animation transition.
/// - coverVertical: Slides in vertically from bottom.
/// - coverVerticalFromTop: Slides in vertically from top.
/// - coverHorizontalFromRight: Slides in horizontally from right.
/// - coverHorizontalFromLeft: Slides in horizontally from left.
/// - flipHorizontal: Flips new view horizontally.
/// - custom: Custom transition animation provided by user.
@objcMembers open class TransitionType:NSObject {
    public static let crossDissolve:TransitionType = TransitionType(type: .crossDissolve, anim: nil);
    public static let coverVertical:TransitionType = TransitionType(type: .coverVertical, anim: nil);
    public static let coverVerticalFromTop:TransitionType = TransitionType(type: .coverVerticalFromTop, anim: nil);
    public static let coverHorizontalFromRight:TransitionType = TransitionType(type: .coverHorizontalFromRight, anim: nil);
    public static let coverHorizontalFromLeft:TransitionType = TransitionType(type: .coverHorizontalFromLeft, anim: nil);
    public static let flipHorizontal:TransitionType = TransitionType(type: .flipHorizontal, anim: nil);
    
    public static func coverFromCorner(corner:Corner)->TransitionType{
        return TransitionType(corner: corner);
    }
    public static func custom(anim:PresentrAnimation)->TransitionType{
        return TransitionType(type: .custom, anim: anim);
    }


    let type:TransitionTypeEnum;
    let anim:PresentrAnimation?;
    let corner:Corner?;
    
    public init(type:TransitionTypeEnum,anim:PresentrAnimation?){
        self.type = type;
        self.anim = anim;
        self.corner=nil;
    }
    
    public init(corner:Corner){
        self.type = .coverFromCorner;
        self.anim = nil;
        self.corner=corner;
    }
    /// Associates a custom transition type to the class responsible for its animation.
    ///
    /// - Returns: PresentrAnimation subclass which conforms to 'UIViewControllerAnimatedTransitioning' to be used for the animation transition.
    func animation() -> PresentrAnimation {
        switch self.type {
        case .crossDissolve:
            return CrossDissolveAnimation()
        case .coverVertical:
            return CoverVerticalAnimation()
        case .coverVerticalFromTop:
            return CoverVerticalFromTopAnimation()
        case .coverHorizontalFromRight:
            return CoverHorizontalAnimation(fromRight: true)
        case .coverHorizontalFromLeft:
            return CoverHorizontalAnimation(fromRight: false)
		case .coverFromCorner:
			return CoverFromCornerAnimation(corner: corner!)
        case .flipHorizontal:
            return FlipHorizontalAnimation()
        case .custom:
            return anim!
        }
    }

}

@objc public enum TransitionTypeEnum:Int {
    case crossDissolve
    case coverVertical
    case coverVerticalFromTop
    case coverHorizontalFromRight
    case coverHorizontalFromLeft
    case flipHorizontal
    case coverFromCorner
    case custom;
}
    
