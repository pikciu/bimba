import RxSwiftUtilities
import RxSwift

public final class SharedActivityIndicator {
    @Inject
    public var shared: ActivityIndicator
    public let current = ActivityIndicator()
    
    public init() {
        
    }
}

public extension ObservableConvertibleType {
    func trackActivity(_ activityIndicator: SharedActivityIndicator) -> Observable<Element> {
        return trackActivity(activityIndicator.shared)
            .trackActivity(activityIndicator.current)
    }
}
