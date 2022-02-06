import UIKit

enum TabBarItem {
    case favorites
    case search
    case map
    
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
    
    func createViewController() -> UIViewController {
        switch self {
        case .favorites:
            return FavoritesViewController()
        case .search:
            return SearchViewController()
        case .map:
            return MapViewController()
        }
    }
}
