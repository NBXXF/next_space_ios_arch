//
//  Feedbackable.swift
//  Feedback
//  交互反馈,（系统决定是是震动还是语音）
//  Created by XXF on 2023/3/24.
//

import UIKit

private var fb_styleKey = 1
private var fb_onKey = 1


/**
 FeedbackGenerator的子类
 1. UIImpactFeedbackGenerator. 使用碰撞反馈发生器来表明发生了碰撞。举个例子，
    当用户界面上的一个对象碰到什么东西、或者卡到某个地方的时候，触发碰撞反馈发生器。
 2. UISelectionFeedbackGenerator. 使用选择反馈发生器来表明选择状态发生了改变。
 3. UINotificationFeedbackGenerator. 使用通知反馈发生器来表明成功，失败，警告。
 */
@objc public protocol Feedbackable {
    //震动样式
    var fb_impactStyle: UIImpactFeedbackGenerator.FeedbackStyle { get set }
    
    //是否开启反馈
    var fb_impactEnable: Bool { get set }
    
    //执行准备
    func fb_prepareImpact();
    
    //执行震动==UIImpactFeedbackGenerator#impactOccurred()
    func fb_performImpact();
    
}

@available(iOS 13.0, *)
extension Feedbackable where Self: UIView {
    public var fb_impactStyle: UIImpactFeedbackGenerator.FeedbackStyle {
        get {
            return objc_getAssociatedObject(self, &fb_styleKey) as? UIImpactFeedbackGenerator.FeedbackStyle ?? .medium
        }
        set {
            objc_setAssociatedObject(self, &fb_impactStyle, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    public var fb_impactEnable: Bool {
        get {
            return objc_getAssociatedObject(self, &fb_onKey) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &fb_onKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    
    public func fb_performImpact() {
        switch fb_impactStyle {
        case .heavy:
            ImpactFeedbackGenerator.shared.heavy.impactOccurred()
        case .medium:
            ImpactFeedbackGenerator.shared.medium.impactOccurred()
        case .light:
            ImpactFeedbackGenerator.shared.light.impactOccurred()            
        case .soft:
            ImpactFeedbackGenerator.shared.soft.impactOccurred()
        case .rigid:
            ImpactFeedbackGenerator.shared.rigid.impactOccurred()
        @unknown default:
            ImpactFeedbackGenerator.shared.light.impactOccurred()
        }
    }
    
    public func fb_prepareImpact() {
        switch fb_impactStyle {
        case .heavy:
            ImpactFeedbackGenerator.shared.heavy.prepare()
        case .medium:
            ImpactFeedbackGenerator.shared.medium.prepare()
        case .light:
            ImpactFeedbackGenerator.shared.light.prepare()
        case .soft:
            ImpactFeedbackGenerator.shared.soft.prepare()
        case .rigid:
            ImpactFeedbackGenerator.shared.rigid.prepare()
        @unknown default:
            ImpactFeedbackGenerator.shared.light.prepare()
        }
    }
}

@available(iOS 13.0, *)
class ImpactFeedbackGenerator {
    public static let shared = ImpactFeedbackGenerator()
    public lazy var heavy: UIImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
    public lazy var medium: UIImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
    public lazy var light: UIImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
    public lazy var soft: UIImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .soft)
    public lazy var rigid: UIImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .rigid)
}
