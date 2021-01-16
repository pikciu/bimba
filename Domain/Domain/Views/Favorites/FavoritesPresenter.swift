import Foundation
import RxSwift
import RxCocoa

public final class FavoritesPresenter {
    private let disposeBag = DisposeBag()
    private let activityIndicator = SharedActivityIndicator()
    private let stopPoints = BehaviorRelay(value: [StopPointDetails]())
    
    public unowned let view: FavoritesView

    public init(view: FavoritesView) {
        self.view = view
        
        stopPoints.bind(to: view.stopPoints).disposed(by: disposeBag)
        stopPoints.map({ $0.isEmpty }).bind(to: view.isEmpty).disposed(by: disposeBag)
    }
    
    public func loadFavorites() {
        FavoriteStopPoints()
            .execute()
            .bind(to: stopPoints)
            .disposed(by: disposeBag)
    }
}
