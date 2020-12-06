import UIKit

extension UIView {
    
    func add(subviews: [UIView]) {
        for subview in subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
            addSubview(subview)
        }
    }
    
    func add(subviews: UIView...) {
        add(subviews: subviews)
    }
}
