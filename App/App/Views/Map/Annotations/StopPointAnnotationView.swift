import UIKit
import MapKit
import Domain
import Reusable

final class  StopPointAnnotationView: MKAnnotationView, Reusable {
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        let image = Asset.mapPin.image
        
        self.image = image
        self.canShowCallout = true
        self.clusteringIdentifier = reuseIdentifier
        self.centerOffset = CGPoint(x: 0, y: -image.size.height / 2)
        self.collisionMode = .circle
        self.displayPriority = .defaultLow
        self.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
