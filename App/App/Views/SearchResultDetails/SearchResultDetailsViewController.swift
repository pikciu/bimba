import UIKit
import Domain
import RxSwift
import RxCocoa

final class SearchResultDetailsViewController: ViewController<SearchResultDetailsUI>, SearchResultDetailsView {
    
    private lazy var presenter = SearchResultDetailsPresenter(view: self)
    
    let searchResult: SearchResult
    
    var isBusy: AnyObserver<Bool> {
        ui.tableView.apply(FooterLoader()).asObserver()
    }
    
    var routes: AnyObserver<[Route]> {
        ui.segmentedControl.rx.segments(animated: false)
            .mapObserver({ $0.map({ $0.direction.name }) })
    }
    
    var selectedRouteIndex: ControlProperty<Int> {
        ui.segmentedControl.rx.selectedSegmentIndex
    }
    
    var isRoutesSelectorDisabled: AnyObserver<Bool> {
        ui.segmentedControlContainer.rx.isHidden.asObserver()
    }
    
    var items: AnyObserver<[SearchResultDetailsPresenter.Item]> {
        ui.tableView.rx.cells(factory: SearchResultDetailsCellFactory()).disposed(by: disposeBag)
    }
    
    init(searchResult: SearchResult) {
        self.searchResult = searchResult
        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = searchResult.text
        presenter.loadDetails()
        
        ui.tableView.register(cellType: StopPointCell.self)
        ui.tableView.register(cellType: LineStopPointCell.self)
        
        ui.tableView.rx.modelSelected(SearchResultDetailsPresenter.Item.self)
            .withUnretained(self)
            .subscribe(onNext: { (context, item) in
                context.showTimes(for: item.stopPoint)
            })
            .disposed(by: disposeBag)
    }
    
    private func showTimes(for stopPoint: StopPoint) {
        let timesViewController = TimesViewController(stopPoint: stopPoint)
        show(timesViewController, sender: nil)
    }
}

extension Reactive where Base: UISegmentedControl {
    
    func segments(animated: Bool) -> Binder<[String]> {
        Binder(base) { (control, segments) in
            control.removeAllSegments()
            segments.reversed()
                .forEach { (title) in
                    control.insertSegment(withTitle: title, at: 0, animated: animated)
                }
        }
    }
}
