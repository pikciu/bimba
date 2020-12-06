import UIKit
import Domain
import RxSwift
import RxCocoa

final class MapViewController: ViewController<MapUI>, MapView {

    private lazy var presenter = MapPresenter(view: self)

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
