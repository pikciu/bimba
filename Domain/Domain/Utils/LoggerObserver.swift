import Foundation
import RxSwift

public struct LoggerObserver<T>: ObserverType {
    
    public init() {
        
    }
    
    public func on(_ event: Event<T>) {
        switch event {
        case .completed:
            log.debug("completed")
        case .error(let error):
            log.error(error)
        case .next(let element):
            log.debug(element)
        }
    }
}
