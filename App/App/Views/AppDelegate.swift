import UIKit
import Domain
import Data
import Firebase

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        Container.register(modules: DataModule.self, DomainModule.self)
        
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
        
#if DEBUG
        log.logLevel = .debug
#endif
        
        return true
    }

}
