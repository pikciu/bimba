import Foundation
import RxSwiftUtilities
import CoreLocation

public struct DomainModule: Module {
    
    public static func register(in container: SwinjectContainer) {
        container.register(ActivityIndicator.self) { _ in ActivityIndicator() }
            .inObjectScope(.weak)
        
        container.register(DeepLinkHandler.self) { _ in DeepLinkHandler() }
            .inObjectScope(.container)
        
        container.register(CLLocationManager.self) { _ in CLLocationManager() }
            .inObjectScope(.weak)
    }
}
