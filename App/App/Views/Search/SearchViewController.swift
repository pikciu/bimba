import UIKit
import Domain
import RxSwift
import RxCocoa

final class SearchViewController: ViewController<SearchUI>, SearchView {

    private lazy var presenter = SearchPresenter(view: self)
    private let searchController = UISearchController(searchResultsController: nil)
    
    var results: AnyObserver<[SearchResult]> {
        ui.tableView.rx.cells(type: SearchResultCell.self).disposed(by: disposeBag)
    }
    
    var searchQuery: Observable<String> {
        searchController.searchBar.rx.text.filterNil()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.initialize()
        
        ui.tableView.register(cellType: SearchResultCell.self)
        
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        ui.tableView.rx.modelSelected(SearchResult.self)
            .subscribe(with: self, onNext: { (context, searchResult) in
                context.showDetails(searchResult: searchResult)
            })
            .disposed(by: disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        searchController.searchBar.becomeFirstResponder()
    }
    
    private func showDetails(searchResult: SearchResult) {
        let searchResultDetailsViewController = SearchResultDetailsViewController(searchResult: searchResult)
        show(searchResultDetailsViewController, sender: nil)
    }
}
