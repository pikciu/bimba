import UIKit
import Domain

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
