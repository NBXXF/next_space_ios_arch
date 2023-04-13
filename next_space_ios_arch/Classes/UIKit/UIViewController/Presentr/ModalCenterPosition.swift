//
//  ModalCenterPosition.swift
//  Presentr
//
//  Created by Daniel Lozano on 7/6/16.
//  Copyright © 2016 danielozano. All rights reserved.
//

import Foundation

/**
 Describes the presented presented view controller's center position. It is meant to be non-specific, but we can use the 'calculatePoint' method when we want to calculate the exact point by passing in the 'containerBounds' rect that only the presentation controller should be aware of.

 - Center:       Center of the screen.
 - TopCenter:    Center of the top half of the screen.
 - BottomCenter: Center of the bottom half of the screen.
 - Custom: A custom center position using a CGPoint which represents the center point of the presented view controller.
 - Custom: A custom center position to be calculated, using a CGPoint which represents the origin of the presented view controller.
 */
@objcMembers open class ModalCenterPosition:NSObject {
    public static let center=ModalCenterPosition(type: .center, point: CGPoint.zero);
    public static let topCenter=ModalCenterPosition(type: .topCenter, point: CGPoint.zero);
    public static let bottomCenter=ModalCenterPosition(type: .bottomCenter, point: CGPoint.zero);
    
    public static func custom(centerPoint: CGPoint)->ModalCenterPosition{
        return ModalCenterPosition(type: .custom, point: centerPoint);
    }
    
    public static func customOrigin(origin: CGPoint)->ModalCenterPosition{
        return ModalCenterPosition(type: .customOrigin, point: origin);
    }

    
    let type:ModalCenterPositionType;
    let point:CGPoint;
    init(type: ModalCenterPositionType,point:CGPoint) {
        self.type = type
        self.point=point;
    }
    
    
    /**
     Calculates the exact position for the presented view controller center.

     - parameter containerBounds: The container bounds the controller is being presented in.

     - returns: CGPoint representing the presented view controller's center point.
     */
    func calculateCenterPoint(_ containerFrame: CGRect) -> CGPoint? {
        
        switch self.type {
        case .center:
            return CGPoint(x: containerFrame.origin.x + (containerFrame.width / 2),
                           y: containerFrame.origin.y + (containerFrame.height / 2))
        case .topCenter:
            return CGPoint(x: containerFrame.origin.x + (containerFrame.width / 2),
                           y: containerFrame.origin.y + (containerFrame.height * (1 / 4) - 1))
        case .bottomCenter:
            return CGPoint(x: containerFrame.origin.x + (containerFrame.width / 2),
                           y: containerFrame.origin.y + (containerFrame.height * (3 / 4)))
        case .custom:
            return point
        case .customOrigin:
            return nil
        }
    }

    func calculateOrigin() -> CGPoint? {
        switch self.type {
        case .customOrigin:
            return point
        default:
            return nil
        }
    }

}

@objc public enum ModalCenterPositionType:Int {
    case center
    case topCenter
    case bottomCenter
    case custom
    case customOrigin
}
