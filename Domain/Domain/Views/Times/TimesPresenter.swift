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
        
        StopPointIsFavorite(id: view.stopPoint.id)
            .execute()
            .bind(to: view.isFavorite)
            .disposed(by: disposeBag)
        
        view.toggleFavorite.mapTo(ToggleFavorite(id: view.stopPoint.id))
            .flatMap({ $0.execute() })
            .subscribe(LoggerObserver())
            .disposed(by: disposeBag)
        
        activityIndicator.current.drive(view.isBusy).disposed(by: disposeBag)
    }
    
    public func loadTimes() {
        Observable<Int>.interval(.seconds(10), scheduler: MainScheduler.asyncInstance)
            .startWith(0)
            .mapTo(GetDepartureTime(stopPointID: view.stopPoint.id))
            .withUnretained(self)
            .flatMap({ (context, useCase) in
                useCase.execute().trackActivity(context.activityIndicator)
            })
            .bind(to: times)
            .disposed(by: disposeBag)
    }
}
