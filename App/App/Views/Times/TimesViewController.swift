import UIKit
import Domain
import RxSwift
import RxCocoa

final class TimesViewController: ViewController<TimesUI>, TimesView {

    private lazy var presenter = TimesPresenter(view: self)
    let stopPoint: StopPointType
    var times: AnyObserver<[DepartureTime]> {
        ui.tableView.rx.cells(type: TimeCell.self).disposed(by: disposeBag)
    }
    
    var isFavorite: AnyObserver<Bool> {
        ui.favoriteButton.apply(FavoriteButtonDecorator()).asObserver()
    }
    
    var toggleFavorite: Observable<Void> {
        ui.favoriteButton.rx.tap.asObservable()
    }
    
    init(stopPoint: StopPointType) {
        self.stopPoint = stopPoint
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = stopPoint.name
        
        navigationItem.setRightBarButton(ui.favoriteButton, animated: false)
        
        presenter.loadTimes()
        
        ui.tableView.register(cellType: TimeCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

struct FavoriteButtonDecorator: Decorator {
    
    func apply(on object: UIBarButtonItem) -> Binder<Bool> {
        Binder(object) { (button, isFavorite) in
            if isFavorite {
                object.image = Asset.starFull.image
            } else {
                object.image = Asset.starEmpty.image
            }
        }
    }
}
