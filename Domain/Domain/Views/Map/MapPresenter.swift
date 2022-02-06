import Foundation
import RxSwift
import RxCocoa
import CoreLocation
import RxCoreLocation
import RxOptional
import DependencyContainer

public final class MapPresenter {
    private let disposeBag = DisposeBag()
    private let activityIndicator = SharedActivityIndicator()
    private let locationManager = Container.resolve(CLLocationManager.self)

    public unowned let view: MapView
    
    private let stopPoints = BehaviorRelay(value: [StopPointDetails]())

    public init(view: MapView) {
        self.view = view
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.rx.statusChanges
            .map({ $0 == .authorizedWhenInUse })
            .bind(to: view.showUserTrackingButton)
            .disposed(by: disposeBag)
        
        let poznanLocation = CLLocationCoordinate2D(latitude: 52.409538, longitude: 16.931992)
        view.setLocation(location: poznanLocation, delta: 0.02)
        
        stopPoints.withUnretained(self)
            .subscribe(onNext: { (context, stopPoints) in
                context.view.display(stopPoints: stopPoints)
            }).disposed(by: disposeBag)
    }
    
    public func loadStopPoints() {
        GetStopPoints()
            .execute()
            .bind(to: stopPoints)
            .disposed(by: disposeBag)
    }
}

extension Reactive where Base: CLLocationManager {
    
    var statusChanges: Observable<CLAuthorizationStatus> {
        Observable.merge(
            didChangeAuthorization.map({ $0.status }),
            status
        )
    }
}
