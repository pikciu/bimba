import UIKit
import Domain
import RxSwift
import RxCocoa
import RxMKMapView
import MapKit

final class MapViewController: ViewController<MapUI>, MapView, MKMapViewDelegate {

    private lazy var presenter = MapPresenter(view: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ui.mapView.register(StopPointAnnotationView.self, forAnnotationViewWithReuseIdentifier: StopPointAnnotationView.reuseIdentifier)
        ui.mapView.register(StopPointClusterAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
        
        ui.mapView.rx.setDelegate(self).disposed(by: disposeBag)

        presenter.stopPoints
            .map({ $0.map({ StopPointAnnotation(stopPoint: $0) }) })
            .bind(to: ui.mapView.rx.annotations)
            .disposed(by: disposeBag)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is StopPointAnnotation else {
            return nil
        }
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: StopPointAnnotationView.reuseIdentifier, for: annotation)
        annotationView.clusteringIdentifier = StopPointAnnotationView.reuseIdentifier
        return annotationView
    }
}

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

import Reusable

final class  StopPointAnnotationView: MKAnnotationView, Reusable {
    var stopPointAnnotation: StopPointAnnotation {
        annotation as! StopPointAnnotation
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        let image = Asset.mapPin.image
        
        self.image = image
        self.canShowCallout = true
        self.clusteringIdentifier = reuseIdentifier
        self.centerOffset = CGPoint(x: 0, y: -image.size.height / 2)
        self.collisionMode = .circle
        self.displayPriority = .defaultLow
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class StopPointClusterAnnotationView: MKAnnotationView {
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        collisionMode = .circle
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
        
        guard let annotation = annotation as? MKClusterAnnotation else {
            return
        }
        let count = annotation.memberAnnotations.count
        image = drawImage(count: count)
        
        if count > 2 {
            displayPriority = .defaultHigh
        } else {
            displayPriority = .defaultLow
        }
    }
    
    private func drawImage(count: Int) -> UIImage? {
        let size = CGSize(width: 40, height: 40)
        return UIGraphicsImageRenderer(size: size).image { (context) in
            let frame = CGRect(origin: .zero, size: size)
            
            UIColor.white.setFill()
            UIBezierPath(ovalIn: frame).fill()
            
            let margin = CGFloat(2)
            let innterOvalRect = frame.inset(by: UIEdgeInsets(all: margin))
            
            Asset.backgroundColor.color.setFill()
            UIBezierPath(ovalIn: innterOvalRect).fill()
            
            let text = String(count)
            let attributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11, weight: .semibold)
            ]
            let textSize = text.size(withAttributes: attributes)
            let textRect = CGRect(
                x: size.width / 2 - textSize.width / 2,
                y: size.height / 2 - textSize.height / 2,
                width: textSize.width,
                height: textSize.height
            )
            text.draw(in: textRect, withAttributes: attributes)
        }
    }
}

extension UIEdgeInsets {
    init(all: CGFloat) {
        self.init(horizontal: all, vertical: all)
    }
    
    init(horizontal: CGFloat, vertical: CGFloat) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
}
