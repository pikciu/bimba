import Foundation
import RxSwift
import RxCocoa
import CoreLocation
import RxCoreLocation

public final class FavoritesPresenter {
    enum View: Int {
        case favorites
        case nearby
    }
    
    enum State {
        case list
        case empty
        case noPermissions
        
        var isEmpty: Bool {
            if case .empty = self {
                return true
            }
            return false
        }
        
        var noPermissions: Bool {
            if case .noPermissions = self {
                return true
            }
            return false
        }
    }
    
    private let locationManager = Container.resolve(CLLocationManager.self)
    private let disposeBag = DisposeBag()
    private let activityIndicator = SharedActivityIndicator()
    private let favoriteStopPoints = BehaviorRelay(value: [StopPointDetails]())
    private let nearbyStopPoints = BehaviorRelay(value: [StopPointDetails]())
    private let selectedView = BehaviorRelay(value: View.favorites)
    
    public unowned let view: FavoritesView

    public init(view: FavoritesView) {
        self.view = view
        
        view.selectedViewIndex.map({ View(rawValue: $0) })
            .filterNil()
            .debug()
            .bind(to: selectedView)
            .disposed(by: disposeBag)
        
        locationManager.rx.location.filterNil()
            .flatMapLatest({ GetNearbyStopPoints(location: $0).execute() })
            .bind(to: nearbyStopPoints)
            .disposed(by: disposeBag)
        
        let stopPoints = Observable.combineLatest(
            selectedView,
            favoriteStopPoints,
            nearbyStopPoints
        ) { (view, favorites, nearby) -> [StopPointDetails] in
            switch view {
            case .favorites:
                return favorites
            case .nearby:
                return nearby
            }
        }
        
        stopPoints.bind(to: view.stopPoints).disposed(by: disposeBag)
        
        let state = Observable.combineLatest(
            selectedView,
            favoriteStopPoints,
            locationManager.rx.statusChanges
        ) { (view, favoriteStopPoints, status) -> State in
            switch view {
            case .favorites:
                if favoriteStopPoints.isEmpty {
                    return .empty
                }
                return .list
            case .nearby:
                if case .authorizedWhenInUse = status {
                    return .list
                }
                return .noPermissions
            }
        }.share()
        
        state.map({ $0.isEmpty })
            .bind(to: view.isEmpty)
            .disposed(by: disposeBag)
        
        state.map({ $0.noPermissions })
            .bind(to: view.noPermissions)
            .disposed(by: disposeBag)
        
        locationManager.rx.statusChanges.filter({ $0 == .authorizedWhenInUse })
            .withUnretained(self)
            .subscribe(onNext: { (context, _) in
                context.locationManager.startUpdatingLocation()
            })
            .disposed(by: disposeBag)
    }
    
    public func loadFavorites() {
        locationManager.requestWhenInUseAuthorization()
        
        FavoriteStopPoints()
            .execute()
            .bind(to: favoriteStopPoints)
            .disposed(by: disposeBag)
    }
}
