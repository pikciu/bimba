import Foundation

extension Sequence {
    
    func sorted<T: Comparable>(key keySelector: (Element) throws -> T) rethrows -> [Element] {
        try sorted { (lhs, rhs) in
            try keySelector(lhs) < keySelector(rhs)
        }
    }
}
