
import UIKit
import Tiercel

@objcMembers public class NXDownloadDownloadTask: NSObject {

    @objc public enum TRValidation: Int {
        case unkown
        case correct
        case incorrect
    }

    internal let downloadTask: DownloadTask


    public var response: URLResponse? {
        downloadTask.response
    }
    
    public var statusCode: Int {
        (downloadTask.response)?.statusCode ?? -1
    }

    public var filePath: String {
        return downloadTask.filePath
    }

    public var pathExtension: String? {
        return downloadTask.pathExtension
    }



    public var status: NXDownloadStatus {
        return NXDownloadStatus(downloadTask.status)
    }

    public var validation: TRValidation {

        switch downloadTask.validation {
        case .unkown:
            return .unkown
        case .correct:
            return .correct
        case .incorrect:
            return .incorrect
        }
    }

    public var url: URL {
        return downloadTask.url
    }


    public var progress: Progress {
        return downloadTask.progress
    }

    public var startDate: Double {
        return downloadTask.startDate
    }

    public var endDate: Double {
        return downloadTask.endDate
    }


    public var speed: Int64 {
        return downloadTask.speed
    }


    public var fileName: String {
        return downloadTask.fileName
    }

    public var timeRemaining: Int64 {
        return downloadTask.timeRemaining
    }

    public var error: Error? {
        return downloadTask.error
    }


    internal init(_ downloadTask: DownloadTask) {
        self.downloadTask = downloadTask;
    }
    
    
    @discardableResult
    public func validateFile(code: String,
                             type: TRFileVerificationType,
                             onMainQueue: Bool = true,
                             handler: @escaping Handler<NXDownloadDownloadTask>) -> Self {
        let convertType: FileChecksumHelper.VerificationType
        switch type {
        case .md5:
            convertType = .md5
        case .sha1:
            convertType = .sha1
        case .sha256:
            convertType = .sha256
        case .sha512:
            convertType = .sha512
        }
        downloadTask.validateFile(code: code, type: convertType, onMainQueue: onMainQueue) { [weak self] _ in
            guard let self = self else { return }
            handler(self)
        }
        return self
    }
    
    @discardableResult
    public func progress(onMainQueue: Bool = true, handler: @escaping Handler<NXDownloadDownloadTask>) -> Self {
        downloadTask.progress(onMainQueue: onMainQueue) { [weak self] _ in
            guard let self = self else { return }
            handler(self)
        }
        return self
    }

    @discardableResult
    public func success(onMainQueue: Bool = true, handler: @escaping Handler<NXDownloadDownloadTask>) -> Self {
        downloadTask.success(onMainQueue: onMainQueue) { [weak self] _ in
            guard let self = self else { return }
            handler(self)
        }
        return self

    }

    @discardableResult
    public func failure(onMainQueue: Bool = true, handler: @escaping Handler<NXDownloadDownloadTask>) -> Self {
        downloadTask.failure(onMainQueue: onMainQueue) { [weak self] _ in
            guard let self = self else { return }
            handler(self)
        }
        return self
    }

}
