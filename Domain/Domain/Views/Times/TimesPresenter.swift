import Foundation
import RxSwift
import RxCocoa
import RxSwiftUtilities

public final class TimesPresenter {
    private let disposeBag = DisposeBag()
    private let activityIndicator = ActivityIndicator()

    public unowned let view: TimesView
    
    private let times = BehaviorRelay(value: [DepartureTime]())

    public init(view: TimesView) {
        self.view = view
    }
    
    public func loadTimes() {
        Observable<Int>.interval(.seconds(10), scheduler: MainScheduler.asyncInstance)
            .mapTo(GetDepartureTime(stopPointID: view.stopPoint.id))
            .flatMap(with: self, { (context, useCase) in
                useCase.execute().trackActivity(context.activityIndicator)
            })
            .bind(to: times)
            .disposed(by: disposeBag)
    }
}
