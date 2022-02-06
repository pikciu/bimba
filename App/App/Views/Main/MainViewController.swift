import UIKit
import Domain
import RxSwift
import WidgetKit
import DependencyContainer

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
        
        tabBar.apply(TabBarStyle())
        
        activityIndicator.shared.drive(UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            .disposed(by: disposeBag)
        
        deepLinkHandler.observe()
            .observe(on: MainScheduler.asyncInstance)
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
            let viewController = item.createViewController()
            viewController.title = item.title
            return NavigationController(rootViewController: viewController)
        })
        
        setViewControllers(viewControllers, animated: false)
        zip(tabBar.items ?? [], items).forEach { (tabBarItem, item) in
            tabBarItem.title = item.title
            tabBarItem.image = item.image
        }
    }
}

final class NavigationController: UINavigationController {
    
    override var childForStatusBarStyle: UIViewController? {
        nil
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        topViewController?.preferredStatusBarStyle ?? .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.apply(AppNavigationStyle())
        if #available(iOS 13.0, *) {
            navigationBar.apply(AppNavigationAppearanceStyle())
        }
    }
}
