import UIKit

final class NavigationController: UINavigationController {
    
    override var childForStatusBarStyle: UIViewController? {
        nil
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        topViewController?.preferredStatusBarStyle ?? .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.apply(AppNavigationStyle())
        if #available(iOS 13.0, *) {
            navigationBar.apply(AppNavigationAppearanceStyle())
        }
    }
}
