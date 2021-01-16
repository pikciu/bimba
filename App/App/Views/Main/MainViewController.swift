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
