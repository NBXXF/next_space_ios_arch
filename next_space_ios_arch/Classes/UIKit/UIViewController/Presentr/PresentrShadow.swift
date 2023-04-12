//
//  PresentrShadow.swift
//  Pods
//
//  Created by Daniel Lozano Valdés on 3/21/17.
//
//

import UIKit
import DynamicColor

/// Helper struct that represents the shadow properties
@objcMembers open class PresentrShadow:NSObject {

    public let shadowColor: UIColor?

    public let shadowOpacity: Float?

    public let shadowOffset: CGSize?

    public let shadowRadius: CGFloat?

    public init(shadowColor: UIColor?, shadowOpacity: Float?, shadowOffset: CGSize?, shadowRadius: CGFloat?) {
        self.shadowColor = shadowColor
        self.shadowOpacity = shadowOpacity
        self.shadowOffset = shadowOffset
        self.shadowRadius = shadowRadius
    }

    public override init() {
        self.shadowColor = UIColor(hexString: "#000000").withAlphaComponent(0.3);
        self.shadowOpacity = 1
        self.shadowOffset = CGSize(width: 0, height: 4)
        self.shadowRadius = 10
    }
}
