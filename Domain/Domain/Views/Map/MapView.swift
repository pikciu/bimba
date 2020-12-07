import Foundation
import RxSwift
import RxCocoa
import CoreLocation

public protocol MapView: class {
    
    func display(stopPoints: [StopPointDetails])
    func setLocation(location: CLLocationCoordinate2D, delta: CLLocationDegrees)
}
