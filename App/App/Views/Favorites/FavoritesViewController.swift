import UIKit
import Domain
import RxSwift
import RxCocoa

final class FavoritesViewController: ViewController<FavoritesUI>, FavoritesView {

    private lazy var presenter = FavoritesPresenter(view: self)

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
