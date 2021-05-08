import UIKit
import Domain
import RxSwift
import RxCocoa

struct FavoriteButtonDecorator: Decorator {
    
    func apply(on object: UIBarButtonItem) -> Binder<Bool> {
        Binder(object) { (button, isFavorite) in
            if isFavorite {
                button.accessibilityHint = L10n.removeFromFavorites
                object.image = Asset.starFull.image
            } else {
                button.accessibilityHint = L10n.addToFavorites
                object.image = Asset.starEmpty.image
            }
        }
    }
}

