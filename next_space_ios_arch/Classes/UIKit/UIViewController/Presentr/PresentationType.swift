//
//  PresentationType.swift
//  Presentr
//
//  Created by Daniel Lozano on 7/6/16.
//  Copyright © 2016 danielozano. All rights reserved.
//

import Foundation

/// Basic Presentr type. Its job is to describe the 'type' of presentation. The type describes the size and position of the presented view controller.
///
/// - alert: This is a small 270 x 180 alert which is the same size as the default iOS alert.
/// - popup: This is a average/default size 'popup' modal.
/// - topHalf: This takes up half of the screen, on the top side.
/// - bottomHalf: This takes up half of the screen, on the bottom side.
/// - fullScreen: This takes up the entire screen.
/// - dynamic: Uses autolayout to calculate width & height. Have to provide center position.
/// - custom: User provided custom width, height & center position.
@objcMembers open class PresentationType:NSObject {
    public static let alert = PresentationType(type: .alert, width: nil, height: nil, center: .center)
    public static let popup = PresentationType(type: .popup, width: nil, height: nil, center: .center)
    public static let topHalf =  PresentationType(type: .topHalf, width: nil, height: nil, center:.topCenter)
    public static let bottomHalf =  PresentationType(type: .bottomHalf, width: nil, height: nil, center: .bottomCenter)
    public static let fullScreen =  PresentationType(type: .fullScreen, width: nil, height: nil, center: .center)
    public static func dynamic(center: ModalCenterPosition)->PresentationType{
        return  PresentationType(type: .dynamic, width: nil, height: nil, center: center)
    }
    public static func custom(width: ModalSize, height: ModalSize, center: ModalCenterPosition)->PresentationType{
        return  PresentationType(type: .custom, width: width, height: height, center: center)
    }
    
  
    
    let type:PresentationTypeEnum
    let width: ModalSize?
    let height: ModalSize?
    let center: ModalCenterPosition
    init(type:PresentationTypeEnum,
         width: ModalSize?,
         height: ModalSize?,
         center: ModalCenterPosition) {
        self.type=type;
        self.width = width
        self.height = height
        self.center = center
    }

    /// Describes the sizing for each Presentr type. It is meant to be non device/width specific, except for the .custom case.
    ///
    /// - Returns: A tuple containing two 'ModalSize' enums, describing its width and height.
    func size() -> (width: ModalSize, height: ModalSize)? {
        switch self.type {
        case .alert:
            return (.custom(size: 270), .custom(size: 180))
        case .popup:
            return (.default, .default)
        case .topHalf, .bottomHalf:
            return (.full, .half)
        case .fullScreen:
            return (.full, .full)
        case .custom:
            return (self.width, self.height) as? (width: ModalSize, height: ModalSize)
        case .dynamic:
            return nil
        }
    }

    /// Describes the position for each Presentr type. It is meant to be non device/width specific, except for the .custom case.
    ///
    /// - Returns: Returns a 'ModalCenterPosition' enum describing the center point for the presented modal.
    func position() -> ModalCenterPosition {
        switch self.type {
        case .alert, .popup:
            return .center
        case .topHalf:
            return .topCenter
        case .bottomHalf:
            return .bottomCenter
        case .fullScreen:
            return .center
        case .custom:
            return center
        case .dynamic:
            return center
        }
    }

    /// Associates each Presentr type with a default transition type, in case one is not provided to the Presentr object.
    ///
    /// - Returns: Return a 'TransitionType' which describes a transition animation.
    func defaultTransitionType() -> TransitionType {
        switch self.type {
        case .topHalf:
            return .coverVerticalFromTop
        default:
            return .coverVertical
        }
    }

    /// Default round corners setting.
    var shouldRoundCorners: Bool {
        switch self.type {
        case .alert, .popup:
            return true
        default:
            return false
        }
    }

}

@objc public enum PresentationTypeEnum:Int {
    case alert
    case popup
    case topHalf
    case bottomHalf
    case fullScreen
    case dynamic
    case custom
}
