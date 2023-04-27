
import UIKit
import Tiercel

@objcMembers public class NXDownloadSessionManager: NSObject {

    private let sessionManager: SessionManager
    

    public var isControlNetworkActivityIndicator: Bool {
        get {  sessionManager.isControlNetworkActivityIndicator }
        set {  sessionManager.isControlNetworkActivityIndicator = newValue }
    }


    public let operationQueue: DispatchQueue
    
    public let cache: NXDownloadCache
    
    public let identifier: String
    
    public var completionHandler: (() -> Void)? {
        get {
            return sessionManager.completionHandler
        }
        set {
            sessionManager.completionHandler = newValue
        }
    }
    
    
    public var configuration: NXDownloadSessionConfiguration {
        didSet {
            configuration.sessionManager = sessionManager
            var config = SessionConfiguration()
            config.timeoutIntervalForRequest = configuration.timeoutIntervalForRequest
            config.maxConcurrentTasksLimit = configuration.maxConcurrentTasksLimit
            config.allowsCellularAccess = configuration.allowsCellularAccess
            sessionManager.configuration = config
        }
    }
    
    public var status: NXDownloadStatus {
        return NXDownloadStatus(sessionManager.status)
    }
    
    public private(set) var tasks: [NXDownloadDownloadTask] = []
    
    
    public var completedTasks: [NXDownloadDownloadTask] {
        return tasks.filter { $0.status == .succeeded }
    }
    
    public var progress: Progress {
        return sessionManager.progress
    }
    
    public var speed: Int64 {
        return sessionManager.speed
    }
    
    public var timeRemaining: Int64 {
        return sessionManager.timeRemaining
    }

    public init(identifier: String,
                            configuration: NXDownloadSessionConfiguration,
                            operationQueue: DispatchQueue) {
        self.identifier = identifier
        self.operationQueue = operationQueue
        var config = SessionConfiguration()
        config.timeoutIntervalForRequest = configuration.timeoutIntervalForRequest
        config.maxConcurrentTasksLimit = configuration.maxConcurrentTasksLimit
        config.allowsCellularAccess = configuration.allowsCellularAccess
        self.configuration = configuration
        let bundleIdentifier = Bundle.main.bundleIdentifier ?? "com.Daniels.Tiercel"
        sessionManager = SessionManager(identifier, configuration: config,
//                                        logger: Logger(identifier: "\(bundleIdentifier).\(identifier)", option: .none),
                                        operationQueue: operationQueue)
        self.configuration.sessionManager = sessionManager
        cache = NXDownloadCache(cache: sessionManager.cache)
        super.init()
        tasks = sessionManager.tasks.map { NXDownloadDownloadTask($0) }

    }

    public convenience init(identifier: String,
                            configuration: NXDownloadSessionConfiguration) {
        self.init(identifier: identifier, configuration: configuration, operationQueue: DispatchQueue(label: "com.Tiercel.SessionManager.operationQueue"))
    }
    
    public func invalidate() {
        sessionManager.invalidate()
    }

    @discardableResult
    public func download(url: NXDownloadURLConvertible,
                         headers: [String: String]?,
                         fileName: String?) -> NXDownloadDownloadTask? {
        //创建目录,支持fileName 支持子文件夹路径
        if((fileName?.count)! > 0){
            let fullPath = (cache.downloadFilePath as NSString).appendingPathComponent(fileName!)
            try? FileManager.default.createPathDirectory(atPath: fullPath, withIntermediateDirectories: true);
        }
        if let downloadTask = sessionManager.download(asURLConvertible(url), headers: headers, fileName: fileName) {
            let convertDownloadTask = NXDownloadDownloadTask(downloadTask)
            tasks.append(convertDownloadTask)
            return convertDownloadTask
        } else {
            return nil
        }

    }
    
    @discardableResult
    public func download(url: NXDownloadURLConvertible) -> NXDownloadDownloadTask? {
        return download(url: url, headers: nil, fileName: nil)
    }

    
    
    @discardableResult
    public func multiDownload(urls: [NXDownloadURLConvertible],
                              headers: [[String: String]]?,
                              fileNames: [String]?) -> [NXDownloadDownloadTask] {
        //创建目录,支持fileName 支持子文件夹路径
        if(fileNames != nil){
            for fileName in fileNames!{
                let fullPath = (cache.downloadFilePath as NSString).appendingPathComponent(fileName)
                try? FileManager.default.createPathDirectory(atPath: fullPath, withIntermediateDirectories: true);
            }
        }

        let convertURLs = urls.map { asURLConvertible($0) }
        let downloadTasks = sessionManager.multiDownload(convertURLs,headersArray: headers,fileNames: fileNames)
        let convertDownloadTasks = downloadTasks.map { NXDownloadDownloadTask($0) }
        tasks.append(contentsOf: convertDownloadTasks)
        return convertDownloadTasks
    }
    
    
    @discardableResult
    public func multiDownload(urls: [NXDownloadURLConvertible]) -> [NXDownloadDownloadTask] {
        return multiDownload(urls: urls, headers: nil, fileNames: nil)
    }
    

    
    
    public func fetchTask(url: NXDownloadURLConvertible) -> NXDownloadDownloadTask? {
        do {
            let validURL = try url.tr_asURL()
            return tasks.first { $0.url == validURL }
        } catch {
            return nil
        }
    }
    
    public func start(url: NXDownloadURLConvertible) {
        sessionManager.start(asURLConvertible(url))
    }
    
    public func start(task: NXDownloadDownloadTask) {
        sessionManager.start(task.downloadTask)
    }
    
    public func suspend(url: NXDownloadURLConvertible, onMainQueue: Bool, handler: Handler<NXDownloadDownloadTask>?) {
        sessionManager.suspend(asURLConvertible(url), onMainQueue: onMainQueue) { [weak self] _ in
            if let task = self?.fetchTask(url: url) {
                handler?(task)
            }
        }
    }
    
    public func suspend(url: NXDownloadURLConvertible) {
        suspend(url: url, onMainQueue: true, handler: nil)
    }


    public func cancel(url: NXDownloadURLConvertible, onMainQueue: Bool, handler: Handler<NXDownloadDownloadTask>?) {
        guard let task = fetchTask(url: url) else { return }
        tasks.removeAll { $0.url == task.url}
        sessionManager.cancel(asURLConvertible(url), onMainQueue: onMainQueue) { [weak self] _ in
            if let task = self?.fetchTask(url: url) {
                handler?(task)
            }
        }
    }
    
    public func cancel(url: NXDownloadURLConvertible) {
        cancel(url: url, onMainQueue: true, handler: nil)
    }
    
    public func remove(url: NXDownloadURLConvertible, completely: Bool, onMainQueue: Bool, handler: Handler<NXDownloadDownloadTask>?) {
        guard let task = fetchTask(url: url) else { return }
        tasks.removeAll { $0.url == task.url}
        sessionManager.remove(asURLConvertible(url), completely: completely, onMainQueue: onMainQueue) { [weak self] _ in
            if let task = self?.fetchTask(url: url) {
                 handler?(task)
             }
        }
    }
    
    public func remove(url: NXDownloadURLConvertible) {
        remove(url: url, completely: false, onMainQueue: true, handler: nil)
    }
    
    public func totalStart() {
        self.tasks.forEach { task in
            start(task: task)
        }
    }
    
    public func totalSuspend(onMainQueue: Bool, handler: Handler<NXDownloadSessionManager>?) {
        sessionManager.totalSuspend(onMainQueue: onMainQueue) { [weak self] _ in
            guard let self = self else { return }
            handler?(self)
        }
    }
    
    public func totalSuspend() {
        totalSuspend(onMainQueue: true, handler: nil)
    }
    
    public func totalCancel(onMainQueue: Bool, handler: Handler<NXDownloadSessionManager>?) {
        tasks.removeAll()
        sessionManager.totalCancel(onMainQueue: onMainQueue) { [weak self] _ in
            guard let self = self else { return }
            handler?(self)
        }
    }
    
    public func totalCancel() {
        totalCancel(onMainQueue: true, handler: nil)
    }
    
    public func totalRemove(completely: Bool, onMainQueue: Bool, handler: Handler<NXDownloadSessionManager>?) {
        tasks.removeAll()
        sessionManager.totalRemove(completely: completely, onMainQueue: onMainQueue) { [weak self] _ in
            guard let self = self else { return }
            handler?(self)
        }
    }
    
    public func totalRemove() {
        totalRemove(completely: false, onMainQueue: true, handler: nil)
    }
    
    @discardableResult
    public func progress(onMainQueue: Bool = true, handler: @escaping Handler<NXDownloadSessionManager>) -> Self {
        sessionManager.progress(onMainQueue: onMainQueue) { [weak self] _ in
            guard let self = self else { return }
            handler(self)
        }
        return self
    }
    
    @discardableResult
    public func success(onMainQueue: Bool = true, handler: @escaping Handler<NXDownloadSessionManager>) -> Self {
        sessionManager.success(onMainQueue: onMainQueue) { [weak self] _ in
            guard let self = self else { return }
            handler(self)
        }
        return self
    }
    
    @discardableResult
    public func failure(onMainQueue: Bool = true, handler: @escaping Handler<NXDownloadSessionManager>) -> Self {
        sessionManager.failure(onMainQueue: onMainQueue) { [weak self] _ in
            guard let self = self else { return }
            handler(self)
        }
        return self
    }
}

