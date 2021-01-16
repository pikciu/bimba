import Foundation
import RxSwiftUtilities

public struct DomainModule: Module {
    
    public static func register(in container: SwinjectContainer) {
        container.register(ActivityIndicator.self) { _ in ActivityIndicator() }
            .inObjectScope(.weak)
    }
}
