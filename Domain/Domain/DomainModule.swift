import Foundation
import RxSwiftUtilities
import CoreLocation
import DependencyContainer

public struct DomainModule: Module {
    
    public static func register(in container: Container) {
        container.registerWeak(ActivityIndicator.self) { _ in ActivityIndicator() }
        container.registerShared(DeepLinkHandler.self) { _ in DeepLinkHandler() }
        container.registerWeak(CLLocationManager.self) { _ in CLLocationManager() }
    }
}
