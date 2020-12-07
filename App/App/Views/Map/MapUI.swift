import UIKit
import MapKit

final class MapUI: View {
    let mapView = MKMapView()
    
    override func setupAutoLayout() {
        add(subviews: mapView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: topAnchor),
            mapView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    override func setupAppearance() {
        mapView.showsUserLocation = true
    }
}
