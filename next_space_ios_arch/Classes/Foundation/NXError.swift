//
//  NXError.swift
//  next_space_ios_arch
//
//  Created by 1234 on 2022/12/8.
//

import Foundation
@objc public class NXError:NSError{
    @objc public var msg:String?=nil;
    @objc public init(msg: String? = nil) {
        super.init(domain: "http", code: -1);
        self.msg = msg
    }
    
    @objc public init(msg: String? = nil,code: Int) {
        super.init(domain: "http", code: code);
        self.msg = msg
    }
    
    @objc public required init?(coder: NSCoder) {
        super.init(coder: coder);
    }
}

@objc public extension NXError{
    @objc static func paramsError()->NXError{
        return NXError(msg: "参数错误", code: -1);
    }
    
    @objc static func noPermissionError()->NXError{
        return NXError(msg: "无权限操作", code: -1);
    }
}
