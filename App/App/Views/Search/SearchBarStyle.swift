import UIKit
import Domain

struct SearchBarStyle: Decorator {
    
    func apply(on object: UISearchBar) {
        object.apply(AppNavigationStyle())
        object.searchBarStyle = .minimal
        object.backgroundImage = UIImage(color: .clear)
        object.scopeBarBackgroundImage = UIImage(color: .clear)
        if let clearIcon = object.textField?.leftView as? UIImageView {
            clearIcon.image = clearIcon.image?.withRenderingMode(.alwaysTemplate)
            clearIcon.tintColor = .white
        }
        
        object.scopeBar?.apply(SegmentedControlStyle())
    }
}
