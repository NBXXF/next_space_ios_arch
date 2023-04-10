//
//  ModalSize.swift
//  Presentr
//
//  Created by Daniel Lozano on 7/6/16.
//  Copyright © 2016 danielozano. All rights reserved.
//

import Foundation
import UIKit

/**
 Descibes a presented modal's size dimension (width or height). It is meant to be non-specific, but the exact position can be calculated by calling the 'calculate' methods, passing in the 'parentSize' which only the Presentation Controller should be aware of.
 
 - Default:     Default size. Will use Presentr's default margins to calculate size of presented controller. This is the size the .Popup presentation type uses.
 - Half:        Half of the screen.
 - Full:        Full screen.
 - Custom:      Custom fixed size.
 - Fluid:       Custom percentage-based fluid size.
 - SideMargin:  Uses side margins to calculate size.
 */

@objcMembers open class ModalSize{
    public static let `default`=ModalSize(type: .default, percentage: 0, margin: 0, size: 0, sizePortrait: 0, sizeLandscape: 0)
    public static let half=ModalSize(type: .half, percentage: 0, margin: 0, size: 0, sizePortrait: 0, sizeLandscape: 0)
    public static let full=ModalSize(type: .full, percentage: 0, margin: 0, size: 0, sizePortrait: 0, sizeLandscape: 0)
    public static func fluid(percentage: Float)->ModalSize{
        return ModalSize(type: .fluid, percentage: percentage, margin: 0, size: 0, sizePortrait: 0, sizeLandscape: 0)
    }
    public static func sideMargin(margin: Float)->ModalSize{
        return ModalSize(type: .sideMargin, percentage: 0, margin: margin, size: 0, sizePortrait: 0, sizeLandscape: 0)
    }
    public static func custom(size: Float)->ModalSize{
        return ModalSize(type: .custom, percentage: 0, margin: 0, size: size, sizePortrait: 0, sizeLandscape: 0)
    }
    public static func customOrientation(sizePortrait: Float, sizeLandscape: Float)->ModalSize{
        return ModalSize(type: .customOrientation, percentage: 0, margin: 0, size: 0, sizePortrait: sizePortrait, sizeLandscape: sizeLandscape)
    }
    
    
    public let type:ModalSizeType
    public let percentage:Float
    public let margin: Float
    public let size: Float;
    public let sizePortrait: Float
    public let sizeLandscape: Float
    init(type:ModalSizeType,
         percentage: Float,
         margin: Float,
         size: Float,
         sizePortrait: Float,
         sizeLandscape: Float) {
        self.type=type;
        self.percentage = percentage
        self.margin = margin
        self.size = size
        self.sizePortrait = sizePortrait
        self.sizeLandscape = sizeLandscape
    }
    
    /**
     Calculates the exact width value for the presented view controller.
     
     - parameter parentSize: The presenting view controller's size. Provided by the presentation controller.
     
     - returns: Exact float width value.
     */
    func calculateWidth(_ parentSize: CGSize) -> Float {
        switch self.type {
        case .default:
            return floorf(Float(parentSize.width) - (PresentrConstants.Values.defaultSideMargin * 2.0))
        case .half:
            return floorf(Float(parentSize.width) / 2.0)
        case .full:
            return Float(parentSize.width)
        case .custom:
            return size
        case .customOrientation:
            switch UIDevice.current.orientation {
            case .portrait, .portraitUpsideDown:
                return min(Float(UIScreen.main.bounds.width), sizePortrait)
            case .landscapeLeft, .landscapeRight:
                return min(Float(UIScreen.main.bounds.width), sizeLandscape)
            default:
                return min(Float(UIScreen.main.bounds.width), sizePortrait)
            }
        case .fluid:
            return floorf(Float(parentSize.width) * percentage)
        case .sideMargin:
            return floorf(Float(parentSize.width) - margin * 2.0)
        }
    }

    /**
     Calculates the exact height value for the presented view controller.
     
     - parameter parentSize: The presenting view controller's size. Provided by the presentation controller.
     
     - returns: Exact float height value.
     */
    func calculateHeight(_ parentSize: CGSize) -> Float {
        switch self.type {
        case .default:
            return floorf(Float(parentSize.height) * PresentrConstants.Values.defaultHeightPercentage)
        case .half:
            return floorf(Float(parentSize.height) / 2.0)
        case .full:
            return Float(parentSize.height)
        case .custom:
            return size
        case .customOrientation:
            switch UIDevice.current.orientation {
            case .portrait, .portraitUpsideDown:
                return min(Float(UIScreen.main.bounds.height), sizePortrait)
            case .landscapeLeft, .landscapeRight:
                return min(Float(UIScreen.main.bounds.height), sizeLandscape)
            default:
                return min(Float(UIScreen.main.bounds.height), sizePortrait)
            }
        case .fluid:
            return floorf(Float(parentSize.height) * percentage)
        case .sideMargin:
            return floorf(Float(parentSize.height) - margin * 2)
        }
    }
    
}
@objc public enum ModalSizeType:Int {
    case `default`
    case half
    case full
	case fluid
	case sideMargin
    case custom
    case customOrientation
}
