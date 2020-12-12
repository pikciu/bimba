import UIKit
import Domain
import Data

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        Container.register(modules: DataModule.self, DomainModule.self)
        
#if DEBUG
        log.logLevel = .debug
#endif
        
        return true
    }

}

