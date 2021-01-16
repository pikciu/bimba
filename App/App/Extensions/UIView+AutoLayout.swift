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

extension NSLayoutConstraint {
    @discardableResult
    func with(priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}
