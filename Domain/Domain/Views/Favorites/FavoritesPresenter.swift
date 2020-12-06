import Foundation
import RxSwift
import RxCocoa
import RxSwiftUtilities

public final class FavoritesPresenter {
    private let disposeBag = DisposeBag()
    private let activityIndicator = ActivityIndicator()

    public unowned let view: FavoritesView

    public init(view: FavoritesView) {
        self.view = view
    }
}
