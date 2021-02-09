import Foundation
import RxSwift
import RxCocoa

public final class DeepLinkHandler {
    private let deepLinks = BehaviorRelay(value: nil as DeepLink?)
    
    public func handle(url: URL) {
        guard let deepLink = DeepLink(url: url) else {
            return
        }
        deepLinks.accept(deepLink)
    }
    
    public func observe() -> Observable<DeepLink> {
        deepLinks.filterNil()
    }
}
