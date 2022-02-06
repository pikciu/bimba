import UIKit
import Domain
import Data
import Firebase
import DependencyContainer

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    override init() {
        super.init()
        
        Container.register(modules: [DataModule.self, DomainModule.self])
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
        
#if DEBUG
        log.logLevel = .debug
#endif
        
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let handler = Container.resolve(DeepLinkHandler.self)
        handler.handle(url: url)
        return true
    }
}
