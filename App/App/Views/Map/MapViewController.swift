import UIKit
import Domain
import RxSwift
import RxCocoa
import MapKit

final class MapViewController: ViewController<MapUI>, MapView, MKMapViewDelegate {

    private lazy var presenter = MapPresenter(view: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.loadStopPoints()
        
        ui.mapView.register(StopPointAnnotationView.self, forAnnotationViewWithReuseIdentifier: StopPointAnnotationView.reuseIdentifier)
        ui.mapView.register(StopPointClusterAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
        
        ui.mapView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is StopPointAnnotation else {
            return nil
        }
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: StopPointAnnotationView.reuseIdentifier, for: annotation)
        annotationView.clusteringIdentifier = StopPointAnnotationView.reuseIdentifier
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let clusterAnnotation = view.annotation as? MKClusterAnnotation else {
            return
        }
        zoom(to: clusterAnnotation.coordinate)
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let stopPointAnnotation = view.annotation as? StopPointAnnotation else {
            return
        }
        showTimes(for: stopPointAnnotation.stopPoint)
    }
    
    func display(stopPoints: [StopPointDetails]) {
        let annotations = stopPoints.map({ StopPointAnnotation(stopPoint: $0) })
        ui.mapView.removeAnnotations(ui.mapView.annotations)
        ui.mapView.addAnnotations(annotations)
    }
    
    private func showTimes(for stopPoint: StopPointDetails) {
        let timesViewController = TimesViewController(stopPoint: stopPoint)
        show(timesViewController, sender: nil)
    }
    
    private func zoom(to coordinates: CLLocationCoordinate2D) {
        var span = ui.mapView.region.span
        span.latitudeDelta = span.latitudeDelta / 3
        span.longitudeDelta = span.longitudeDelta / 3
        zoom(to: coordinates, span: span)
    }
    
    func setLocation(location: CLLocationCoordinate2D, delta: CLLocationDegrees) {
        let span = MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta)
        zoom(to: location, span: span)
    }
    
    private func zoom(to location: CLLocationCoordinate2D, span: MKCoordinateSpan) {
        let region = MKCoordinateRegion(center: location, span: span)
        ui.mapView.setRegion(region, animated: true)
    }
}
