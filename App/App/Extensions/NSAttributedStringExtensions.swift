import Foundation

extension Sequence where Element == NSAttributedString {
    
    func joined(with separator: NSAttributedString) -> NSAttributedString {
        reduce(NSMutableAttributedString()) { (result, current) in
            if result.length > 0 {
                result.append(separator)
            }
            result.append(current)
            return result
        }
    }
    
    func joined(with separator: String) -> NSAttributedString {
        joined(with: NSAttributedString(string: separator))
    }
}
