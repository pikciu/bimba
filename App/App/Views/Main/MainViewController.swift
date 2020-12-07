import UIKit

final class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarControllers()
        
        tabBar.apply(AppNavigationStyle())
    }
    
    private func setupTabBarControllers() {
        
        let items = [
            TabBarItem.favorites,
            .search,
            .map
        ]
        
        let viewControllers = items.map({ (item) -> UIViewController in
            let viewController = item.viewController
            viewController.title = item.title
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.navigationBar.apply(AppNavigationStyle())
            return navigationController
        })
        
        setViewControllers(viewControllers, animated: false)
        zip(tabBar.items ?? [], items).forEach { (tabBarItem, item) in
            tabBarItem.title = item.title
        }
    }
}

enum TabBarItem {
    case favorites
    case search
    case map
    
    var viewController: UIViewController {
        switch self {
        case .favorites:
            return FavoritesViewController()
        case .search:
            return SearchViewController()
        case .map:
            return MapViewController()
        }
    }
    
    var title: String {
        switch self {
        case .favorites:
            return L10n.tabFavorites
        case .search:
            return L10n.tabSearch
        case .map:
            return L10n.tabMap
        }
    }
}

protocol NavigationBar: class {
    var barTintColor: UIColor? { get set }
    var barStyle: UIBarStyle { get set }
    var tintColor: UIColor! { get set }
    var isTranslucent: Bool { get set }
}

extension UITabBar: NavigationBar {
    
}

extension UINavigationBar: NavigationBar {
    
}

import Domain

struct AppNavigationStyle<T: NavigationBar>: Decorator {
    
    func apply(on object: T) {
        object.barTintColor = Asset.backgroundColor.color
        object.barStyle = .black
        object.tintColor = .white
        object.isTranslucent = false
    }
}
