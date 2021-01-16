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
            .subscribe(with: self, onNext: { (context, stopPoint) in
                context.showTimes(for: stopPoint)
            }).disposed(by: disposeBag)
    }
    
    private func showTimes(for stopPoint: StopPointType) {
        let timesViewController = TimesViewController(stopPoint: stopPoint)
        show(timesViewController, sender: nil)
    }
}


struct PlaceholderDecorator<T: UIView>: Decorator {
    
    let style: Placeholder
    
    func apply(on object: T) -> AnyObserver<Bool> {
        let placeholder = PlaceholderView()
        placeholder.configure(with: style)
        object.add(subviews: placeholder)
        
        NSLayoutConstraint.activate([
            placeholder.bottomAnchor.constraint(equalTo: object.centerYAnchor),
            placeholder.leadingAnchor.constraint(equalTo: object.leadingAnchor, constant: Constants.UI.defaultSpacing).with(priority: .defaultHigh),
            placeholder.trailingAnchor.constraint(equalTo: object.trailingAnchor, constant: -Constants.UI.defaultSpacing).with(priority: .defaultHigh)
        ])
        
        return placeholder.rx.isHidden.mapObserver({ !$0 })
    }
}

extension NSLayoutConstraint {
    @discardableResult
    func with(priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}
