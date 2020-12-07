import UIKit

extension UIEdgeInsets {
    init(all: CGFloat) {
        self.init(horizontal: all, vertical: all)
    }
    
    init(horizontal: CGFloat, vertical: CGFloat) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
}

