import Foundation
import RxSwift
import RxCocoa

public final class FavoritesPresenter {
    private let disposeBag = DisposeBag()
    private let activityIndicator = SharedActivityIndicator()

    public unowned let view: FavoritesView

    public init(view: FavoritesView) {
        self.view = view
    }
}
