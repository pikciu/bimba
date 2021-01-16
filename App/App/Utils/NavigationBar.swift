import UIKit
import Domain

protocol NavigationBar: class {
    var barTintColor: UIColor? { get set }
    var barStyle: UIBarStyle { get set }
    var tintColor: UIColor! { get set }
    var isTranslucent: Bool { get set }
}

extension UITabBar: NavigationBar {
    
}

extension UINavigationBar: NavigationBar {
    
}

extension UISearchBar: NavigationBar {
    
}

import Domain

struct AppNavigationStyle<T: NavigationBar>: Decorator {
    
    func apply(on object: T) {
        object.barTintColor = Asset.backgroundColor.color
        object.barStyle = .black
        object.tintColor = .white
        object.isTranslucent = true
    }
}
