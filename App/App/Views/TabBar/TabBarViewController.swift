import UIKit

final class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarControllers()
    }
    
    private func setupTabBarControllers() {
        
        let viewControllers = [
            FavoritesViewController(),
            SearchViewController(),
            MapViewController()
        ]
        
        setViewControllers(viewControllers, animated: false)
    }
}
