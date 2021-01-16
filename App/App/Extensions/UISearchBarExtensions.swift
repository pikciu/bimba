import UIKit

extension UISearchBar {
    var textField: UITextField? {
        if #available(iOS 13.0, *) {
            return searchTextField
        } else {
            return value(forKey: "searchField") as? UITextField
        }
    }
    
    var placeholderLabel: UILabel? {
        textField?.value(forKey: "placeholderLabel") as? UILabel
    }
    
    var clearButton: UIButton? {
        textField?.value(forKey: "_clearButton") as? UIButton
    }
    
    var scopeBar: UISegmentedControl? {
        subviews(of: UISegmentedControl.self).first
    }
}

extension UIView {
    
    func subviews<T: UIView>(of type: T.Type) -> [T] {
        subviews.flatMap({ [$0 as? T].compactMap({ $0 }) + $0.subviews(of: T.self) })
    }
}
