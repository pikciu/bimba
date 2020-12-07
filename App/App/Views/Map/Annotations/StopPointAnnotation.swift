import MapKit
import Domain

final class StopPointAnnotation: NSObject, MKAnnotation {
    
    let stopPoint: StopPointDetails
    
    var title: String? {
        stopPoint.name
    }
    
    var subtitle: String? {
        stopPoint.headsings
    }
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: stopPoint.coordinates.latitude,
            longitude: stopPoint.coordinates.longitude
        )
    }
    
    init(stopPoint: StopPointDetails) {
        self.stopPoint = stopPoint
        super.init()
    }
}
