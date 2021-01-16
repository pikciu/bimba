import UIKit
import MapKit

final class MapUI: View {
    let mapView = MKMapView()
    private(set) lazy var userLocationButton = MKUserTrackingButton(mapView: mapView)
    private(set) lazy var compassButton = MKCompassButton(mapView: mapView)
    private(set) lazy var scaleView = MKScaleView(mapView: mapView)
    
    private(set) lazy var userLocationButtonHeightConstraint = userLocationButton.heightAnchor.constraint(equalToConstant: 0)
    
    override func setupAutoLayout() {
        add(subviews: mapView, userLocationButton, compassButton, scaleView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: topAnchor),
            mapView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            userLocationButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.UI.defaultSpacing),
            userLocationButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Constants.UI.defaultSpacing),
            userLocationButton.widthAnchor.constraint(equalToConstant: 40),
            userLocationButtonHeightConstraint,
            
            compassButton.topAnchor.constraint(equalTo: userLocationButton.bottomAnchor, constant: Constants.UI.defaultSpacing),
            compassButton.centerXAnchor.constraint(equalTo: userLocationButton.centerXAnchor),
            
            scaleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            scaleView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,constant: -Constants.UI.defaultSpacing)
        ])
        
    }
    
    override func setupAppearance() {
        mapView.showsUserLocation = true
        mapView.showsCompass = false
        userLocationButton.backgroundColor = Asset.accentColor.color
        userLocationButton.tintColor = .white
        userLocationButton.layer.cornerRadius = 6
        userLocationButton.layer.borderColor = UIColor.white.cgColor
        userLocationButton.layer.borderWidth = 2
        userLocationButton.layer.masksToBounds = true
    }
}
