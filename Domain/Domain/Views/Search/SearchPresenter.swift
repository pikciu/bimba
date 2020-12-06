import Foundation
import RxSwift
import RxCocoa
import RxSwiftUtilities

public final class SearchPresenter {
    private let disposeBag = DisposeBag()
    private let activityIndicator = ActivityIndicator()

    public unowned let view: SearchView

    public init(view: SearchView) {
        self.view = view
    }
}
