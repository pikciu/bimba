import Foundation
import RxSwift
import RxCocoa
import CoreLocation

public protocol MapView: AnyObject {
    var showUserTrackingButton: AnyObserver<Bool> { get }
    
    func display(stopPoints: [StopPointDetails])
    func setLocation(location: CLLocationCoordinate2D, delta: CLLocationDegrees)
}
