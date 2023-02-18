//
//  String+Extension.swift
//  ETicket
//
//  Created by chunjian wang on 2020/3/20.
//  Copyright © 2020 chunjian wang. All rights reserved.
//

import Foundation
import UIKit

public extension String {
    
    func getLableHeigh(font:UIFont,width:CGFloat) -> CGFloat {

        let size = CGSize.init(width: width, height:  CGFloat(MAXFLOAT))

        let dic = [NSAttributedString.Key.font:font] // swift 3.0

        let strSize = self.boundingRect(with: size, options: [.usesLineFragmentOrigin], attributes: dic, context:nil).size

        return ceil(strSize.height) + 1
    }
    ///获取字符串的宽度
    func getLableWidth(font:UIFont,height:CGFloat) -> CGFloat {

        let size = CGSize.init(width: CGFloat(MAXFLOAT), height: height)

        let dic = [NSAttributedString.Key.font:font] // swift 3.0

        let cString = self.cString(using: String.Encoding.utf8)
        let str = String.init(cString: cString!, encoding: String.Encoding.utf8)
        let strSize = str?.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic, context:nil).size
        return strSize?.width ?? 0
    }
    /**
     计算文字的宽度

     - parameter width:
     - parameter font:

     - returns:
     */
    func sizeWithConstrained(_ font: UIFont,
                             constraintRect: CGSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)) -> CGSize {
        let boundingBox = self.boundingRect(
            with: constraintRect,
            options: NSStringDrawingOptions.usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: font],
            context: nil)
        return CGSize.init(width: boundingBox.size.width + 5, height: boundingBox.size.height)
    }

    func isEmail() -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}")
        return predicate.evaluate(with: self)
    }

    func isChinese() -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", "^[\\u4E00-\\u9FA5]+$")
        return predicate.evaluate(with: self)
    }

    func isDigital() -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", "^[0-9]+(.[0-9]{1,8})?$")
        return predicate.evaluate(with: self)
    }

    func isMobile() -> Bool {
        return count > 1
    }

    static func isNotBlank(_ string:Any?) -> Bool {
        guard let value = string as? String else {
            return false
        }
        return value.count > 0
    }

    static func isBlank(_ string:Any?) -> Bool {
        return !isNotBlank(string)
    }

    static func isBankCard(_ string:Any?) -> Bool {
        guard let value = string as? String else {
            return false
        }
        let predicate = NSPredicate(format: "SELF MATCHES %@", "^[0-9]{2,20}$")
        return predicate.evaluate(with: value)
    }

    func number() -> NSNumber {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 8
        formatter.minimumFractionDigits = 0
        formatter.roundingMode = .floor
        formatter.locale = Locale(identifier: "en_US")
        return (formatter.number(from: self) ?? 0)
    }
    
    var decimal : Decimal {
        return Decimal(string: self, locale: .current) ?? 0
    }
    
    var decimalNumber: NSDecimalNumber {
        return NSDecimalNumber(string: self)
    }
    
    func subString(start:Int, length:Int = -1) -> String {
        if self == "" {
            return ""
        }
        if self.count < (start + length) {
            return self
        }
        var len = length
        if len == -1 {
            len = self.count - start
        }
        let st = self.index(startIndex, offsetBy:start)
        let en = self.index(st, offsetBy:len)
        return String(self[st ..< en])
    }

    func digits() -> Int {
        let array = self.components(separatedBy: ".")
        if array.count == 2 {
            return array.last?.count ?? 0
        }
        return 0
    }
    
    /// 小数位数
    func precision() -> Int {
        if self.contains(".") {
            let separatedArray = self.components(separatedBy: ".")
            let numberStr = separatedArray.last
            return numberStr?.count ?? 0
        }else{
            return -self.count
        }
    }
    
    ///表情判断
    func disable_emoji() -> String {
        if self == "➊" || self == "➋" || self == "➌" || self == "➍" || self == "➎" || self == "➏" || self == "➐" || self == "➑" || self == "➒" {
            return self
        }
        let regex = try!NSRegularExpression.init(pattern: "[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]", options: .caseInsensitive)
        
        let modifiedString = regex.stringByReplacingMatches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange.init(location: 0, length: self.count), withTemplate: "")
        return modifiedString
    }

    func attributed() -> NSMutableAttributedString {
        return NSMutableAttributedString.init(string: self)
    }
}

public extension NSAttributedString {
    static func attributed(_ attributeds:[(String,UIFont,UIColor)]) -> NSAttributedString {
        let attr = NSMutableAttributedString()
        attributeds.forEach { (arg0) in
            let (value, font, color) = arg0
            attr.append(NSAttributedString(string: value, attributes: [NSAttributedString.Key.font:font,NSAttributedString.Key.foregroundColor:color]))
        }
        return attr
    }
    
    fileprivate func applying(attributes: [NSAttributedString.Key: Any]) -> NSAttributedString {
        let copy = NSMutableAttributedString(attributedString: self)
        let range = (string as NSString).range(of: string)
        copy.addAttributes(attributes, range: range)

        return copy
    }
    
    
//    func underline(style:NSUnderlineStyle) -> NSAttributedString {
//        return applying(attributes: [.underlineStyle : style.union(NSUnderlineStyle.single).rawValue])
//    }
    
}

public extension NSMutableAttributedString {

    func lineSpacing(spacing:CGFloat, toRangesMatching pattern: String) -> NSMutableAttributedString {
        guard let pattern = try? NSRegularExpression(pattern: pattern, options: []) else { return self }

        let matches = pattern.matches(in: string, options: [], range: NSRange(0..<length))
        var attr = self
        for match in matches {
            attr = self.lineSpacing(spacing: spacing, range: match.range)
        }
        return attr
    }

    func lineSpacing(spacing:CGFloat,range:NSRange?=nil) -> NSMutableAttributedString {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = spacing
        style.alignment = .left
        if range != nil{
            self.addAttributes([.paragraphStyle:style], range: range!)
        }else{
            self.addAttributes([.paragraphStyle:style], range: NSMakeRange(0, self.string.count))
        }

        return self
    }

    func font(font:UIFont, toRangesMatching pattern: String) -> NSMutableAttributedString {
        guard let pattern = try? NSRegularExpression(pattern: pattern, options: []) else { return self }

        let matches = pattern.matches(in: self.string, options: [], range: NSRange(0..<length))
        var attr = self
        for match in matches {
            attr = self.font(font: font, range: match.range)
        }
        return attr
    }

    func font(font:UIFont,range:NSRange?=nil) -> NSMutableAttributedString {

        if range != nil{
            self.addAttributes([.font:font], range: range!)
        } else {
            self.addAttributes([.font:font], range: NSMakeRange(0, self.string.count))
        }

        return self
    }

    func foregroundColor(color:UIColor, toRangesMatching pattern: String) -> NSMutableAttributedString {
        if string.isEmpty {
            return self
        }

        guard let pattern = try? NSRegularExpression(pattern: pattern, options: []) else { return self }

        let matches = pattern.matches(in: string, options: [], range: NSRange(0..<length))
        var attr = self
        for match in matches {
            attr = self.foregroundColor(color: color, range: match.range)
        }
        return attr
    }


    func foregroundColor(color:UIColor,range:NSRange?=nil) -> NSMutableAttributedString {
        if range != nil{
            self.addAttributes([.foregroundColor:color], range: range!)
        } else {
            self.addAttributes([.foregroundColor:color], range: NSMakeRange(0, self.string.count))
        }

        return self
    }

    func addAttribute(_ name: NSAttributedString.Key, value: Any, toRangesMatching pattern: String) -> NSMutableAttributedString {
        guard let pattern = try? NSRegularExpression(pattern: pattern, options: []) else { return self }

        let matches = pattern.matches(in: string, options: [], range: NSRange(0..<length))
        var attr = self
        for match in matches {
            attr = self.addAttribute(name, value: value, range: match.range)
        }
        return attr
    }

    func addAttribute(_ name: NSAttributedString.Key, value: Any, range: NSRange? = nil) -> NSMutableAttributedString {
        if range != nil{
            self.addAttributes([name:value], range: range!)
        } else {
            self.addAttributes([name:value], range: NSMakeRange(0, self.string.count))
        }
        return self
    }


    func append(attr:NSAttributedString) -> NSMutableAttributedString {
        self.append(attr)
        return self
    }
}
