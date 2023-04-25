

import UIKit
import Tiercel

@objcMembers public class NXDownloadCache: NSObject {
    
    private let cache: Cache
    
    public var downloadPath: String {
        return cache.downloadPath
    }

    public var downloadTmpPath: String {
        return cache.downloadTmpPath
    }
    
    public var downloadFilePath: String {
        return cache.downloadFilePath
    }
    
    public var identifier: String {
        return cache.identifier
    }
    
    public init(_ name: String) {
        self.cache = Cache(name)
    }
    
    internal init(cache: Cache) {
        self.cache = cache
    }
    
    public func filePath(fileName: String) -> String? {
        return cache.filePath(fileName: fileName)
    }
    
    public func fileURL(fileName: String) -> URL? {
        return cache.fileURL(fileName: fileName)
    }
    
    public func fileExists(fileName: String) -> Bool {
        return cache.fileExists(fileName: fileName)

    }
    
    public func filePath(url: NXDownloadURLConvertible) -> String? {
        return cache.filePath(url: asURLConvertible(url))
    }
    
    public func fileURL(url: NXDownloadURLConvertible) -> URL? {
        return cache.fileURL(url: asURLConvertible(url))

    }
    
    public func fileExists(url: NXDownloadURLConvertible) -> Bool {
        return cache.fileExists(url: asURLConvertible(url))

    }
    
    
    
    public func clearDiskCache(onMainQueue: Bool, handler: Handler<NXDownloadCache>?) {
        cache.clearDiskCache(onMainQueue: onMainQueue) { [weak self] _ in
            guard let self = self else { return }
            handler?(self)
        }
    }
    
    public func clearDiskCache() {
        clearDiskCache(onMainQueue: true, handler: nil)
    }

}



