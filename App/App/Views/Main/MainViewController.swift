import UIKit
import Domain
import RxSwift
import WidgetKit

final class MainViewController: UITabBarController {
    let disposeBag = DisposeBag()
    let activityIndicator = SharedActivityIndicator()
    let deepLinkHandler = Container.resolve(DeepLinkHandler.self)
    
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
        
        deepLinkHandler.observe()
            .observeOn(MainScheduler.asyncInstance)
            .withUnretained(self)
            .subscribe(onNext: { (context, deepLink) in
                switch deepLink {
                case .stop(let stopPoint):
                    context.showTimes(stop: stopPoint)
                }
            })
            .disposed(by: disposeBag)
        
        NotificationCenter.default.rx.notification(UIApplication.didBecomeActiveNotification)
            .subscribe(onNext: { _ in
                if #available(iOS 14.0, *) {
                    WidgetCenter.shared.reloadAllTimelines()
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func showTimes(stop: StopPointType) {
        guard let navigationController = selectedViewController as? UINavigationController else {
            return
        }
        let timesViewController = TimesViewController(stopPoint: stop)
        navigationController.pushViewController(timesViewController, animated: true)
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
