import Foundation
import RxSwift
import RxCocoa
import RxSwiftUtilities

public final class MapPresenter {
    private let disposeBag = DisposeBag()
    private let activityIndicator = ActivityIndicator()

    public unowned let view: MapView

    public init(view: MapView) {
        self.view = view
    }
}
