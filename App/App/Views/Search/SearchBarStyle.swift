import UIKit
import Domain

struct SearchBarStyle: Decorator {
    
    func apply(on object: UISearchBar) {
        object.apply(AppNavigationStyle())
        object.searchBarStyle = .minimal
        object.backgroundImage = UIImage(color: .clear)
        object.scopeBarBackgroundImage = UIImage(color: .clear)
        
        object.scopeBar?.apply(SegmentedControlStyle())
    }
}
