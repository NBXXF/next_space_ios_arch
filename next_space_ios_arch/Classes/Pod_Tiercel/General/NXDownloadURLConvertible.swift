
import Foundation
import Tiercel

@objc public protocol NXDownloadURLConvertible {

    func tr_asURL() throws -> URL
}

extension NSString: NXDownloadURLConvertible {

    public func tr_asURL() throws -> URL {
        return try self.asURLConvertible().asURL()
    }
    
    internal func asURLConvertible() -> URLConvertible {
        return self as String
    }
}

extension NSURL: NXDownloadURLConvertible {

    public func tr_asURL() throws -> URL { return try self.asURLConvertible().asURL() }
    
    internal func asURLConvertible() -> URLConvertible {
        return self as URL
    }
}

extension NSURLComponents: NXDownloadURLConvertible {

    public func tr_asURL() throws -> URL {
        return try self.asURLConvertible().asURL()
    }
    
    internal func asURLConvertible() -> URLConvertible {
        return self as URLComponents
    }
}

internal func asURLConvertible(_ url: NXDownloadURLConvertible) -> URLConvertible {
    if let temp = url as? NSString {
        return temp as String
    } else if let temp = url as? NSURL {
        return temp as URL
    } else {
        return url as! URLComponents
    }
}
