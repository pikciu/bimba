import UIKit
import Domain

struct SegmentedControlStyle: Decorator {
    
    func apply(on object: UISegmentedControl) {
        object.tintColor = .white
        
        object.setTitleTextAttributes([.foregroundColor: Asset.secondaryColor.color], for: .normal)
        object.setTitleTextAttributes([.foregroundColor: Asset.primaryColor.color], for: .selected)
        
        if #available(iOS 13.0, *) {
            object.selectedSegmentTintColor = .white
        }
    }
}
