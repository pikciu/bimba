import UIKit

enum AppFont {
    enum Size: CGFloat {
        case small = 12
        case medium = 14
        case big = 30
    }
    
    static let titleFont = regular(size: .medium)
    static let subtitleFont = light(size: .small)
    
    static func light(size: CGFloat) -> UIFont {
        .systemFont(ofSize: size, weight: .regular)
    }
    
    static func regular(size: CGFloat) -> UIFont {
        .systemFont(ofSize: size, weight: .semibold)
    }
    
    static func heavy(size: CGFloat) -> UIFont {
        .systemFont(ofSize: size, weight: .heavy)
    }
    
    static func light(size: Size) -> UIFont {
        light(size: size.rawValue)
    }
    
    static func regular(size: Size) -> UIFont {
        regular(size: size.rawValue)
    }
    
    static func heavy(size: Size) -> UIFont {
        heavy(size: size.rawValue)
    }
}
