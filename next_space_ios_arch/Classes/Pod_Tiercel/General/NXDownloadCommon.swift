
import Foundation
import Tiercel

@objc public enum NXDownloadStatus: Int {
    case waiting
    case running
    case suspended
    case canceled
    case failed
    case removed
    case succeeded

    case willSuspend
    case willCancel
    case willRemove
    
    internal init(_ status: Status) {
        switch status {
        case .waiting:
            self = .waiting
        case .running:
            self = .running
        case .suspended:
            self = .suspended
        case .canceled:
            self = .canceled
        case .failed:
            self = .failed
        case .removed:
            self = .removed
        case .succeeded:
            self = .succeeded
        case .willSuspend:
            self = .willSuspend
        case .willCancel:
            self = .willCancel
        case .willRemove:
            self = .willRemove

        }
    }
}

@objc public enum TRFileVerificationType : Int {
    case md5
    case sha1
    case sha256
    case sha512
}

@objc public enum TRLogLevel: Int {
    case detailed
    case simple
    case none
}
