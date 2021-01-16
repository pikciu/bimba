import UIKit
import MapKit
import Domain
import Reusable

final class  StopPointAnnotationView: MKAnnotationView, Reusable {
    
    private let button = UIButton(type: .detailDisclosure)
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        let image = Asset.pin.image
        
        self.image = image
        self.canShowCallout = true
        self.clusteringIdentifier = reuseIdentifier
        self.centerOffset = CGPoint(x: 0, y: -image.size.height / 2)
        self.collisionMode = .circle
        self.displayPriority = .defaultLow
        self.rightCalloutAccessoryView = button
        self.tintColor = Asset.primaryColor.color
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
        
        guard let annotation = annotation as? StopPointAnnotation else {
            return
        }
        let type = annotation.stopPoint.type.first
        button.setImage(type?.image, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
