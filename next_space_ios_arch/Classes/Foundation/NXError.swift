//
//  NXError.swift
//  next_space_ios_arch
//
//  Created by XXF on 2021/7/15.
//

import Foundation
@objc public class NXError:NSError{
    @objc public var msg:String?=nil;
    @objc public init(msg: String? = nil) {
        super.init(domain: "http", code: -1);
        self.msg = msg;
    }
    
    @objc public init(code: Int,msg: String) {
        super.init(domain: "http", code: code);
        self.msg = msg;
    }
    
    @objc public init(code: Int,msg: String,userInfo: [String : Any]?) {
        super.init(domain: "http", code: code,userInfo: userInfo);
        self.msg = msg;
    }
    
    @objc public required init?(coder: NSCoder) {
        super.init(coder: coder);
    }
}

@objc public extension NXError{
    @objc static func paramsError()->NXError{
        return NXError(code: -1,msg: "参数错误");
    }
    
    @objc static func noPermissionError()->NXError{
        return NXError(code: -1,msg: "无权限操作");
    }
}
