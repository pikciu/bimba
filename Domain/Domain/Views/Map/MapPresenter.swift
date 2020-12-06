import Foundation
import RxSwift
import RxCocoa
import RxSwiftUtilities

public final class MapPresenter {
    private let disposeBag = DisposeBag()
    private let activityIndicator = ActivityIndicator()

    public unowned let view: MapView
    
    public let stopPoints = BehaviorRelay(value: [StopPointDetails]())

    public init(view: MapView) {
        self.view = view
        
        GetStopPoints()
            .execute()
            .bind(to: stopPoints)
            .disposed(by: disposeBag)
    }
}
