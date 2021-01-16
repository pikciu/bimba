import UIKit
import Domain
import RxSwift
import RxCocoa

final class FavoritesViewController: ViewController<FavoritesUI>, FavoritesView {

    private lazy var presenter = FavoritesPresenter(view: self)
    
    var stopPoints: AnyObserver<[StopPointDetails]> {
        ui.tableView.rx.cells(type: FavoriteStopPointCell.self).disposed(by: disposeBag)
    }
    
    var isEmpty: AnyObserver<Bool> {
        ui.apply(PlaceholderDecorator(style: .favorites))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        ui.tableView.register(cellType: FavoriteStopPointCell.self)
        presenter.loadFavorites()
        
        ui.tableView.rx.modelSelected(StopPointDetails.self)
            .withUnretained(self)
            .subscribe(onNext: { (context, stopPoint) in
                context.showTimes(for: stopPoint)
            }).disposed(by: disposeBag)
    }
    
    private func showTimes(for stopPoint: StopPointType) {
        let timesViewController = TimesViewController(stopPoint: stopPoint)
        show(timesViewController, sender: nil)
    }
}
