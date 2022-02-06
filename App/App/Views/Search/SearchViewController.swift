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
    
    var state: AnyObserver<SearchPresenter.State> {
        ui.tableView.apply(SearchFooterDecorator()).asObserver()
    }
    
    var scope: ControlProperty<Int> {
        searchController.searchBar.rx.selectedScopeButtonIndex
    }
    
    var scopes: AnyObserver<[SearchPresenter.Scope]> {
        Binder(searchController) { (search, scopes) in
            search.searchBar.scopeButtonTitles = scopes.map({ $0.title })
        }.asObserver()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.initialize()
        
        ui.tableView.register(cellType: SearchResultCell.self)
        
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.apply(SearchBarStyle())
        navigationItem.hidesSearchBarWhenScrolling = false
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        ui.tableView.rx.modelSelected(SearchResult.self)
            .withUnretained(self)
            .subscribe(onNext: { (context, searchResult) in
                context.showDetails(searchResult: searchResult)
            })
            .disposed(by: disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        searchController.searchBar.becomeFirstResponder()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        searchController.searchBar.placeholderLabel?.textColor = Asset.secondaryColor.color.withAlphaComponent(0.5)
    }
    
    private func showDetails(searchResult: SearchResult) {
        let searchResultDetailsViewController = SearchResultDetailsViewController(searchResult: searchResult)
        show(searchResultDetailsViewController, sender: nil)
    }
}

extension SearchPresenter.Scope {
    var title: String {
        switch self {
        case .all:
            return L10n.searchScopeAll
        case .line:
            return L10n.searchScopeLine
        case .stopPoint:
            return L10n.searchScopeStopPoint
        case .street:
            return L10n.searchScopeStreet
        }
    }
}
