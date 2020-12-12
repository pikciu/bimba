import Foundation
import RxSwift
import RxCocoa
import CoreLocation
import RxCoreLocation
import RxOptional

public final class MapPresenter {
    private let disposeBag = DisposeBag()
    private let activityIndicator = SharedActivityIndicator()
    private let locationManager = CLLocationManager()

    public unowned let view: MapView
    
    private let stopPoints = BehaviorRelay(value: [StopPointDetails]())

    public init(view: MapView) {
        self.view = view
        
        locationManager.requestWhenInUseAuthorization()
        
        let poznanLocation = CLLocationCoordinate2D(latitude: 52.409538, longitude: 16.931992)
        
        locationManager.rx.location.filterNil()
            .take(1)
            .map({ $0.coordinate })
            .startWith(poznanLocation)
            .subscribe(with: self, onNext: { (context, location) in
                context.view.setLocation(location: location, delta: 0.02)
            }).disposed(by: disposeBag)
        
        stopPoints
            .subscribe(with: self, onNext: { (context, stopPoints) in
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
