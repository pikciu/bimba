import Foundation
import RxSwift
import RxCocoa
import RxSwiftUtilities

public final class TimesPresenter {
    private let disposeBag = DisposeBag()
    private let activityIndicator = ActivityIndicator()

    public unowned let view: TimesView

    public init(view: TimesView) {
        self.view = view
    }
}
