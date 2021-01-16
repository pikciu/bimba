import UIKit

enum AppFont {
    enum Size: CGFloat {
        case small = 13
        case medium = 17
        case big = 40
    }
    
    static let titleFont = regular(size: .medium)
    static let subtitleFont = light(size: .small)
    
    static func light(size: CGFloat) -> UIFont {
        .systemFont(ofSize: size, weight: .medium)
    }
    
    static func regular(size: CGFloat) -> UIFont {
        .systemFont(ofSize: size, weight: .bold)
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
