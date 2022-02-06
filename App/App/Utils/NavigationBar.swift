import UIKit
import Domain

protocol NavigationBar: AnyObject {
    var barTintColor: UIColor? { get set }
    var barStyle: UIBarStyle { get set }
    var tintColor: UIColor! { get set }
    var isTranslucent: Bool { get set }
}

extension UITabBar: NavigationBar {
    
}

extension UINavigationBar: NavigationBar {
    
}

extension UISearchBar: NavigationBar {
    
}

struct AppNavigationStyle<T: NavigationBar>: Decorator {
    
    func apply(on object: T) {
        object.barTintColor = Asset.backgroundColor.color
        object.barStyle = .black
        object.tintColor = .white
        object.isTranslucent = true
    }
}

@available(iOS 13.0, *)
protocol BarAppearance: UIBarAppearance {
    var tintColor: UIColor? { get set }
}

@available(iOS 13.0, *)
extension UITabBarAppearance: BarAppearance {
    var tintColor: UIColor? {
        get {
            selectionIndicatorTintColor
        }
        set {
            selectionIndicatorTintColor = newValue
        }
    }
}

@available(iOS 13.0, *)
extension UINavigationBarAppearance: BarAppearance {
    
    var tintColor: UIColor? {
        get {
            titleTextAttributes[.foregroundColor] as? UIColor
        }
        set {
            titleTextAttributes[.foregroundColor] = newValue
        }
    }
}

@available(iOS 13.0, *)
protocol BarAppearanceConfigurable: AnyObject {
    
    func configureAppearance(configuration: (BarAppearance) -> Void)
}

@available(iOS 13.0, *)
extension UITabBar: BarAppearanceConfigurable {
    
    func configureAppearance(configuration: (BarAppearance) -> Void) {
        let appearance = UITabBarAppearance()
        configuration(appearance)
        standardAppearance = appearance
        if #available(iOS 15.0, *) {
            scrollEdgeAppearance = appearance
        }
    }
}

@available(iOS 13.0, *)
extension UINavigationBar: BarAppearanceConfigurable {
    
    func configureAppearance(configuration: (BarAppearance) -> Void) {
        let appearance = UINavigationBarAppearance()
        configuration(appearance)
        standardAppearance = appearance
        scrollEdgeAppearance = appearance
        compactAppearance = appearance
        if #available(iOS 15.0, *) {
            compactScrollEdgeAppearance = appearance
        }
    }
}

@available(iOS 13.0, *)
struct AppNavigationAppearanceStyle<T: BarAppearanceConfigurable>: Decorator {
    
    func apply(on object: T) {
        object.configureAppearance { appearance in
            appearance.configureWithDefaultBackground()
            appearance.backgroundColor = Asset.backgroundColor.color.withAlphaComponent(0.8)
            appearance.backgroundImage = UIImage()
            appearance.shadowImage = UIImage()
            appearance.shadowColor = Asset.secondaryColor.color.withAlphaComponent(0.1)
            appearance.tintColor = .white
            let blur = UIBlurEffect(style: .regular)
            appearance.backgroundEffect = blur
        }
    }
}

final class TabBarStyle: Decorator {
    
    func apply(on object: UITabBar) {
        let unselectedColor = Asset.secondaryColor.color.withAlphaComponent(0.5)
        if #available(iOS 13.0, *) {
            object.apply(AppNavigationAppearanceStyle())
            let tabBarItemAppearance = UITabBarItemAppearance()
            tabBarItemAppearance.normal.titleTextAttributes[.foregroundColor] = unselectedColor
            tabBarItemAppearance.selected.titleTextAttributes[.foregroundColor] = UIColor.white
            tabBarItemAppearance.normal.iconColor = unselectedColor
            tabBarItemAppearance.selected.iconColor = .white
            object.standardAppearance.stackedLayoutAppearance = tabBarItemAppearance
            object.standardAppearance.inlineLayoutAppearance = tabBarItemAppearance
            object.standardAppearance.compactInlineLayoutAppearance = tabBarItemAppearance
            if #available(iOS 15.0, *) {
                object.scrollEdgeAppearance?.stackedLayoutAppearance = tabBarItemAppearance
                object.scrollEdgeAppearance?.inlineLayoutAppearance = tabBarItemAppearance
                object.scrollEdgeAppearance?.compactInlineLayoutAppearance = tabBarItemAppearance
            }
        } else {
            object.apply(AppNavigationStyle())
            object.unselectedItemTintColor = unselectedColor
        }
    }
}
