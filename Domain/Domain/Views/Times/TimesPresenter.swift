import Foundation
import RxSwift
import RxCocoa
import RxSwiftExt

public final class TimesPresenter {
    private let disposeBag = DisposeBag()
    private let activityIndicator = SharedActivityIndicator()

    public unowned let view: TimesView
    
    private let times = BehaviorRelay(value: [DepartureTime]())

    public init(view: TimesView) {
        self.view = view
        
        times.bind(to: view.times)
            .disposed(by: disposeBag)
    }
    
    public func loadTimes() {
        Observable<Int>.interval(.seconds(10), scheduler: MainScheduler.asyncInstance)
            .startWith(0)
            .mapTo(GetDepartureTime(stopPointID: view.stopPoint.id))
            .flatMap(with: self, { (context, useCase) in
                useCase.execute().trackActivity(context.activityIndicator)
            })
            .bind(to: times)
            .disposed(by: disposeBag)
    }
}
