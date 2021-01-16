import UIKit
import Domain
import RxSwift
import RxCocoa

struct FavoriteButtonDecorator: Decorator {
    
    func apply(on object: UIBarButtonItem) -> Binder<Bool> {
        Binder(object) { (button, isFavorite) in
            if isFavorite {
                object.image = Asset.starFull.image
            } else {
                object.image = Asset.starEmpty.image
            }
        }
    }
}

