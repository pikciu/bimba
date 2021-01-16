import UIKit
import Domain
import RxSwift

final class MainViewController: UITabBarController {
    let disposeBag = DisposeBag()
    let activityIndicator = SharedActivityIndicator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarControllers()
        
        view.backgroundColor = Asset.backgroundColor.color
        
        LoadStopPoints()
            .execute()
            .trackActivity(activityIndicator)
            .subscribe(LoggerObserver())
            .disposed(by: disposeBag)
        
        tabBar.apply(AppNavigationStyle())
        
        activityIndicator.shared.drive(UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            .disposed(by: disposeBag)
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
        
        tabBar.unselectedItemTintColor = Asset.secondaryColor.color.withAlphaComponent(0.5)
        
        setViewControllers(viewControllers, animated: false)
        zip(tabBar.items ?? [], items).forEach { (tabBarItem, item) in
            tabBarItem.title = item.title
            tabBarItem.image = item.image
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
    
    var image: UIImage {
        switch self {
        case .favorites:
            return Asset.favorite.image
        case .search:
            return Asset.search.image
        case .map:
            return Asset.map.image
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

extension UISearchBar: NavigationBar {
    
}

import Domain

struct AppNavigationStyle<T: NavigationBar>: Decorator {
    
    func apply(on object: T) {
        object.barTintColor = Asset.backgroundColor.color
        object.barStyle = .black
        object.tintColor = .white
        object.isTranslucent = true
    }
}
