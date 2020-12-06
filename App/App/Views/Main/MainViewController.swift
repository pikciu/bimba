import UIKit

final class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarControllers()
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
            return UINavigationController(rootViewController: viewController)
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
